// ======================================================================
//
// Module Name  : Bicubic Interpolation
//
// Author       : jorjor
// Company      : NKUST NCLAB
// Created Date : 2024.09.09
//
// ======================================================================

`timescale 1ns/100ps

module Bicubic (
    input               CLK,    // Clock Source
    input               RST,    // Active high asynchronous reset
    input       [6:0]   V0,     // The left up point of coordinate x
    input       [6:0]   H0,     // The left up point of coordinate y
    input       [4:0]   SW,     // The width of image before scaling
    input       [4:0]   SH,     // The height of image before scaling
    input       [5:0]   TW,     // The width of image after scaling
    input       [5:0]   TH,     // The height of image after scaling
    output              DONE    // Active high done signal
);

localparam FBIT = 15;    // The bit width of floating point

// --------------------------------------------------------------------
// ROM Control
wire    [13:0]          rom_addr;       // ROM address (raddr_y * 100 + raddr_x)
wire                    rom_cen;        // ROM read enable signal 
wire    [7:0]           rom_data;       // ROM data output (obtain after 1.5 cc)

reg     [6:0]           raddr_y;        // Read address (Coordinate Y)
reg     [6:0]           raddr_x;        // Read address (Coordinate X)

// --------------------------------------------------------------------
// RAM Control
wire    [13:0]          ram_addr;       // RAM address (waddr_y * 100 + waddr_x)
wire                    ram_cen;        // RAM read enable signal 
wire                    ram_wen;        // RAM write enable signal
wire    [7:0]           ram_wdata;      // RAM write data  

wire                    en_calc; 
wire                    en_calc_r;      // for pipeline 

reg     [6:0]           waddr_y;        // Write Address (Coordinate Y)
reg     [6:0]           waddr_x;        // Write Address (Coordinate X)

// --------------------------------------------------------------------
// Mode Control
reg     [1:0]           mode;           // Mode control signal
/*  mode : output
 *   00  : orginal pixel
 *   01  : compute the interpolation of coordinate x
 *   10  : compute the interpolation of coordinate y
 *   11  : compute the interpolations of coordinate x and coordinate y
 */

// --------------------------------------------------------------------
// Registers
reg     [7:0]           data [0:3];

// --------------------------------------------------------------------
// Arithmetic
wire    [4:0]           SW_1;           // SW - 1
wire    [4:0]           SH_1;           // SH - 1
wire    [5:0]           TW_1;           // TW - 1
wire    [5:0]           TH_1;           // TH - 1

wire    [FBIT+7-1:0]    x_new;          // The coordinate x for determine the position (Q7.15)  
wire    [FBIT+7-1:0]    y_new;          // The coordinate y for determine the position (Q7.15)
reg     [6:0]           int_x_new;      // The integer part of x_new
reg     [6:0]           int_y_new;      // The integer part of y_new
reg     [FBIT-1:0]      float_x_new;    // The floating part of x_new 
reg     [FBIT-1:0]      float_y_new;    // The floating part of y_new

wire    [7:0]           p;              // Data output of Bicubic Interpolation (Q8.0)
reg     [7:0]           p0;             // Data output or Data buffer for 2D Interpolation
reg     [7:0]           p1, p2, pn;     // Data buffer for 2D Interpolation
reg     [7:0]           ip0;            // Data in (p0) of Bicubic Interpolation
reg     [7:0]           ip1;            // Data in (p1) of Bicubic Interpolation
reg     [7:0]           ip2;            // Data in (p2) of Bicubic Interpolation
reg     [7:0]           ipn;            // Data in (pn) of Bicubic Interpolation
reg     [FBIT-1:0]      x_sel;          // Floating part of Bicubic Interpolation  

// --------------------------------------------------------------------
// Finite State Machine
reg     [3:0]           count_p;        // The counter for sending address to ROM
reg     [3:0]           count;          // The counter for reading data from ROM

reg     [3:0]           state;
reg     [3:0]           nstate;

localparam  IDLE        = 0;            // IDLE
localparam  PREPARE     = 1;            // Compute x_new, y_new and mode
localparam  CHECK       = 2;            // Check mode for determine next state
localparam  READ_T0     = 3;            // Read orginal pixel
localparam  READ_T1     = 4;            // Read the pixel for computing the interpolation of coordinate x
localparam  READ_T2     = 5;            // Read the pixel for computing the interpolation of coordinate y
localparam  READ_T3     = 6;            // Read the pixel for computing the interpolations of coordinate x and coordinate y
localparam  EXTRA_T3_1  = 7;            // Extra state for READ_T3(STATE) to read the pixel 
localparam  EXTRA_T3_2  = 8;            // Extra state for READ_T3(STATE) to read the pixel 
localparam  PIPE        = 9;            // Pipeline stage
localparam  CALC        = 10;           // Calculation stage
localparam  NEXT_PIXEL  = 11;           // Deliver the calculation result into RAM and Determine next state 
localparam  FINISH      = 12;           // Finish calculation

integer i;

// ====================================================================
// ROM Control
// The control for reading data (Please refer to the annotated part below)
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        raddr_y <= 0; 
        raddr_x <= 0; 
    end
    else begin
        case (nstate)
            CHECK   : begin raddr_y <= V0 + (y_new >> FBIT); raddr_x <= H0 + (x_new >> FBIT); end
            READ_T1     : begin
                if (count_p[1]) begin
                    raddr_x <= raddr_x - 3;
                end
                else begin
                    raddr_x <= raddr_x + 1;
                end
            end
            READ_T2     : begin
                if (count_p[1]) begin
                    raddr_y <= raddr_y - 3;
                end
                else begin
                    raddr_y <= raddr_y + 1;
                end
            end
            READ_T3     : begin
                if (count_p < 11) begin
                    if (count_p[1:0] == 2'b11) begin
                        raddr_y <= raddr_y + 1;
                        raddr_x <= H0 + int_x_new;
                    end
                    else if (count_p[1:0] == 2'b10) begin
                        raddr_x <= raddr_x - 3;
                    end
                    else begin
                        raddr_x <= raddr_x + 1;
                    end
                end
                else begin
                    if (count_p[1:0] == 2'b11) begin
                        raddr_y <= raddr_y - 3;
                        raddr_x <= H0 + int_x_new;
                    end
                    else if (count_p[1:0] == 2'b10) begin
                        raddr_x <= raddr_x - 3;
                    end
                    else begin
                        raddr_x <= raddr_x + 1;
                    end
                end
            end
        endcase
    end
end

//always @(posedge CLK or posedge RST) begin
//    if (RST) begin
//        raddr_y <= 0; 
//        raddr_x <= 0; 
//    end
//    else begin
//        case (nstate)
//            CHECK   : begin raddr_y <= V0 + (y_new >> FBIT); raddr_x <= H0 + (x_new >> FBIT); end
//            READ_T1     : begin
//                case(count_p)
//                    0       : begin raddr_y <= V0+int_y_new;    raddr_x <= H0+int_x_new+1; end 
//                    1       : begin raddr_y <= V0+int_y_new;    raddr_x <= H0+int_x_new+2; end
//                    2       : begin raddr_y <= V0+int_y_new;    raddr_x <= H0+int_x_new-1; end
//                endcase
//            end
//            READ_T2     : begin
//                case(count_p)
//                    0       : begin raddr_y <= V0+int_y_new+1;  raddr_x <= H0+int_x_new; end 
//                    1       : begin raddr_y <= V0+int_y_new+2;  raddr_x <= H0+int_x_new; end
//                    2       : begin raddr_y <= V0+int_y_new-1;  raddr_x <= H0+int_x_new; end
//                endcase
//            end
//            READ_T3     : begin
//                case(count_p)
//                    0       : begin raddr_y <= V0+int_y_new;    raddr_x <= H0+int_x_new+1; end 
//                    1       : begin raddr_y <= V0+int_y_new;    raddr_x <= H0+int_x_new+2; end
//                    2       : begin raddr_y <= V0+int_y_new;    raddr_x <= H0+int_x_new-1; end
//
//                    3       : begin raddr_y <= V0+int_y_new+1;  raddr_x <= H0+int_x_new; end 
//                    4       : begin raddr_y <= V0+int_y_new+1;  raddr_x <= H0+int_x_new+1; end 
//                    5       : begin raddr_y <= V0+int_y_new+1;  raddr_x <= H0+int_x_new+2; end
//                    6       : begin raddr_y <= V0+int_y_new+1;  raddr_x <= H0+int_x_new-1; end
//                    
//                    7       : begin raddr_y <= V0+int_y_new+2;  raddr_x <= H0+int_x_new; end 
//                    8       : begin raddr_y <= V0+int_y_new+2;  raddr_x <= H0+int_x_new+1; end 
//                    9       : begin raddr_y <= V0+int_y_new+2;  raddr_x <= H0+int_x_new+2; end
//                    10      : begin raddr_y <= V0+int_y_new+2;  raddr_x <= H0+int_x_new-1; end
//                    
//                    11      : begin raddr_y <= V0+int_y_new-1;  raddr_x <= H0+int_x_new; end 
//                    12      : begin raddr_y <= V0+int_y_new-1;  raddr_x <= H0+int_x_new+1; end 
//                    13      : begin raddr_y <= V0+int_y_new-1;  raddr_x <= H0+int_x_new+2; end
//                    14      : begin raddr_y <= V0+int_y_new-1;  raddr_x <= H0+int_x_new-1; end
//                endcase
//            end
//        endcase
//    end
//end

// Calculate the read address of ROM
// assign rom_addr = raddr_y * 100 + raddr_x;
assign rom_addr = (raddr_y << 6) + (raddr_y << 5) + (raddr_y << 2) + raddr_x; // 100 = (64 + 32 + 4) or (128 - 16 - 8 - 4)

// Always enable to read data from ROM
assign rom_cen = 1'b0; 

ImgROM u_ImgROM (
    .Q(rom_data), 
    .CLK(CLK), 
    .CEN(rom_cen), 
    .A(rom_addr));

// ====================================================================
// RAM Control

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        waddr_y <= 7'b0;
        waddr_x <= 7'b0;
    end
    else begin
        if (state == IDLE) begin
            // Reset to 0
            waddr_y <= 7'b0;
            waddr_x <= 7'b0;
        end
        else if (state == NEXT_PIXEL) begin
            // Determine next state after complete a calculation
            if (waddr_x == TW-1) begin
                waddr_y <= waddr_y + 7'b1;
                waddr_x <= 7'b0;
            end
            else begin
                waddr_x <= waddr_x + 6'b1;
            end
        end
    end
end

// Calculate the write address of RAM
assign ram_addr = waddr_y * TW + waddr_x;

// Enable to write data into RAM after calculation
assign ram_cen  = 1'b0;
assign ram_wen  = en_calc_r;

assign en_calc = (state != CALC);
sr #(
    .BIT  (1),
    .SHIFT(1)
) u_sr_pn (
    .CLK    (CLK),
    .RST    (RST),
    .din    (en_calc),
    .dout   (en_calc_r)
);

// Write data into RAM
assign ram_wdata = p0;

ResultSRAM u_ResultSRAM (
    .Q(), 
    .CLK(CLK), 
    .CEN(ram_cen), 
    .WEN(ram_wen), 
    .A(ram_addr), 
    .D(ram_wdata));

// ====================================================================
// Mode Control

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        mode <= 2'b0;
    end
    else if (state == PREPARE) begin
        // update mode signal at prepare stage       
        mode <= {(y_new[FBIT-1:0] != 0), (x_new[FBIT-1:0] != 0)};
        
        // or
        //
        //if ((y_new[FBIT-1:0] == 0) && (x_new[FBIT-1:0] == 0)) begin
        //   mode <= 2'b00;
        //end
        //else if ((y_new[FBIT-1:0] == 0) && (x_new[FBIT-1:0] != 0)) begin
        //   mode <= 2'b01;
        //end
        //else if ((y_new[FBIT-1:0] != 0) && (x_new[FBIT-1:0] == 0)) begin
        //   mode <= 2'b10;
        //end
        //else begin
        //   mode <= 2'b11;
        //end
    end
end


// ====================================================================
// Registers

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        for (i = 0 ; i < 4; i=i+1) begin
            data[i] <= 8'b0; 
        end
    end
    else begin
        // Storing the data which is delivered from ROM
        if (state == READ_T0 || state == READ_T1 || state == READ_T2 || state == READ_T3) begin
            data[count[1:0]] <= rom_data; 
        end
    end
end

// ====================================================================
// Arithmetic

// Calculate x_new and y_new
assign SW_1 = SW - 1;
assign SH_1 = SH - 1;
assign TW_1 = TW - 1;
assign TH_1 = TH - 1;

multi_div #(
    .FBIT(FBIT)
) u_multi_div_x (
    .a  (waddr_x),
    .b  (SW_1),
    .c  (TW_1),
    .d  (x_new) 
);

multi_div #(
    .FBIT(FBIT)
) u_multi_div_y (
    .a  (waddr_y),
    .b  (SH_1),
    .c  (TH_1),
    .d  (y_new) 
);

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        {int_x_new, float_x_new} <= 0;
        {int_y_new, float_y_new} <= 0;
    end
    else if (state == PREPARE) begin
        {int_x_new, float_x_new} <= x_new;
        {int_y_new, float_y_new} <= y_new;
    end
end

// Sharing the 1D Interpolation module to reduce hardware consumption
always @(*) begin
    if ((mode == 2'b11) && (state == EXTRA_T3_2)) begin
        x_sel = float_y_new;
        ip0 = p0;
        ip1 = p1;
        ip2 = p2;
        ipn = pn;
    end
    else begin
        x_sel = (mode == 2'b10) ? float_y_new : float_x_new;
        ip0 = data[0];
        ip1 = data[1];
        ip2 = data[2];
        ipn = data[3];
    end
end

// 1D Interpolation module
interpolation1d #(
    .FBIT(FBIT)
) u_interpolation1d_x0 (
    .CLK (CLK),
    .RST (RST),
    .ip0 (ip0),     // Q8.0
    .ip1 (ip1),     // Q8.0 
    .ip2 (ip2),     // Q8.0 
    .ipn (ipn),     // Q8.0 
    .x   (x_sel),   // Q0.6
    .dout(p)        // Q8.0
);

// Data Buffer of Bicubic Interpolation module
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        p0  <= 0;
        p1  <= 0;
        p2  <= 0;
        pn  <= 0;
    end
    else begin
        if ((state == CALC) || (count == 5)) begin
            p0 <= p;
        end
        else if (count == 9) begin
            p1 <= p;
        end
        else if (count == 13) begin
            p2 <= p;
        end
        else if (state == EXTRA_T3_1) begin
            pn <= p;
        end
    end
end

// ====================================================================
// Finite State Machine

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        count <= 0;
        count_p <= 0;
    end
    else begin
        count <= count_p;
        if (nstate == READ_T1 || nstate == READ_T2) begin
            count_p <= (count_p == 3) ? 0 : count_p + 1;
        end
        else if (nstate == READ_T3) begin
            count_p <= (count_p == 15) ? 0 : count_p + 1;
        end
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state <= IDLE;
    end
    else begin
        state <= nstate;
    end
end

always @(*) begin
    case(state)
        // IDLE State
        IDLE        : nstate = PREPARE;
        // Calculate x_new, y_new and mode
        PREPARE     : nstate = CHECK;
        // Check mode for determine next state
        CHECK       : begin
            case(mode)
                2'b00   : nstate = READ_T0;
                2'b01   : nstate = READ_T1;
                2'b10   : nstate = READ_T2;
                default : nstate = READ_T3;
            endcase
        end
        // Read original pixel
        READ_T0     : nstate = PIPE;
        // Read the pixel for computing the interpolation of coordinate x
        READ_T1     : nstate = (count == 3) ? PIPE  : READ_T1;
        // Read the pixel for computing the interpolation of coordinate y
        READ_T2     : nstate = (count == 3) ? PIPE  : READ_T2;
        // Read the pixel for computing the interpolations of coordinate x and coordinate y
        READ_T3     : nstate = (count == 15) ? PIPE : READ_T3;
        // Extra state for READ_T3(STATE) to read the pixel 
        EXTRA_T3_1  : nstate = EXTRA_T3_2;
        // Extra state for READ_T3(STATE) to read the pixel 
        EXTRA_T3_2  : nstate = CALC;
        // pipeline
        PIPE        : nstate = (mode == 2'b11) ? EXTRA_T3_1 : CALC;
        // Calculation 
        CALC        : nstate = NEXT_PIXEL;
        // Deliver the calculation result into RAM and Determine next state 
        NEXT_PIXEL  : nstate = ((waddr_y == TH-1) && (waddr_x == TW-1)) ? FINISH : PREPARE;
        // Finish calculation
        FINISH      : nstate = IDLE;
        default     : nstate = IDLE;
    endcase
end

// ====================================================================
// Module Output Signal

assign DONE = (state == FINISH);

endmodule

