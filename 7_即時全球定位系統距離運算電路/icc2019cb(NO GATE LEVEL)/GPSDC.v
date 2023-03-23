`timescale 1ns/10ps

module GPSDC(clk, reset_n, DEN, LON_IN, LAT_IN, COS_ADDR, COS_DATA, ASIN_ADDR, ASIN_DATA, Valid, a, D);
input                   clk;
input                   reset_n;
input                   DEN;

input           [23:0]  LON_IN; // lambda
input           [23:0]  LAT_IN; // phi

input           [95:0]  COS_DATA;
output reg      [6:0]   COS_ADDR;

input           [127:0] ASIN_DATA;
output reg      [5:0]   ASIN_ADDR;

output                  Valid;
output          [39:0]  D;
output          [63:0]  a;

reg                     enable_start;

reg             [23:0]  LON_A; // Q8.16
reg             [23:0]  LAT_A; // Q8.16
reg             [23:0]  LON_B; // Q8.16
reg             [23:0]  LAT_B; // Q8.16

reg             [23:0]  inputA_SIN2;    // control the inputs for SIN2 function
reg             [23:0]  inputB_SIN2;
wire            [63:0]  output_SIN2; // Q0.64

reg             [63:0]  LAT_SIN2; // the output of SIN2 function
reg             [63:0]  LON_SIN2; // Q0.64

reg             [47:0]  inputX_COS;     // the inputs of COS function
reg             [47:0]  inputX0_COS;    // Q16.32
reg             [47:0]  inputY0_COS;
reg             [47:0]  inputX1_COS;
reg             [47:0]  inputY1_COS;

wire            [63:0]  output_COS; // Q0.64

reg             [63:0]  LAT_COSA; // Q0.64
reg             [63:0]  LAT_COSB; // Q0.64

wire            [63:0]  multi;

//reg             [63:0]  inputX_ASIN;     // the inputs of ASIN function
reg             [63:0]  inputX0_ASIN;    // Q0.64
reg             [63:0]  inputY0_ASIN;
reg             [63:0]  inputX1_ASIN;
reg             [63:0]  inputY1_ASIN;

wire            [39:0]  outputY_ASIN;

reg             [3:0]   state;
reg             [3:0]   nstate;

parameter IDLE = 0,
            CAL_SIN2_LAT = 1,
            GOT_SIN2_LAT = 2,
            CAL_SIN2_LON = 3,
            GOT_SIN2_LON = 4,
            PREPARE_COS_A = 5,
            CAL_COS_A   = 6,
            GOT_COS_A    = 7,
            PREPARE_COS_B = 8,
            CAL_COS_B   = 9,
            GOT_COS_B    = 10,
            PREPARE_ASIN = 11,
            CAL_ASIN   = 12,
            GOT_ASIN    = 13,
            FINISH = 15;

assign Valid = (state == FINISH) ? 1'b1 : 1'b0;
assign D = (a == 64'b0) ? 40'b0 : outputY_ASIN;
assign a = LAT_SIN2 + multi;

FUNC_MULTI U_FUNC_MULTI(.a(LAT_COSA), .b(LAT_COSB), .c(LON_SIN2), .out(multi));

// =================================================================================
// Perform ASIN FUNCTION

FUNC_INTERPOLATION_ASIN U_FUNC_INTERPOLATION_ASIN(.x0(inputX0_ASIN), .y0(inputY0_ASIN), .x1(inputX1_ASIN), .y1(inputY1_ASIN), .x(a), .y(outputY_ASIN));

always @(posedge clk or negedge reset_n) begin : the_inputs_of_ASIN
    if (!reset_n) begin
        inputX0_ASIN <= 60'b0;
        inputY0_ASIN <= 60'b0;
        inputX1_ASIN <= 60'b0;
        inputY1_ASIN <= 60'b0;
    end
    else begin
        if (state == PREPARE_ASIN) begin
            {inputX0_ASIN, inputY0_ASIN} <= ASIN_DATA;
        end
        else if (state == CAL_ASIN) begin
            if ((a > inputX0_ASIN) && (a < ASIN_DATA[127:64])) begin
                {inputX1_ASIN, inputY1_ASIN} <= ASIN_DATA;
            end
            else begin
                {inputX0_ASIN, inputY0_ASIN} <= ASIN_DATA;
            end
        end
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        ASIN_ADDR <= 6'b0;
    end
    else begin
        if (state == PREPARE_ASIN) begin
            ASIN_ADDR <= 6'b0;
        end
        else if (state == CAL_ASIN) begin
            ASIN_ADDR <= ASIN_ADDR + 6'b1;
        end
    end
end

// =================================================================================
// Perform COS FUNCTION

FUNC_INTERPOLATION_COS U_FUNC_INTERPOLATION_COS(.x0(inputX0_COS), .y0(inputY0_COS), .x1(inputX1_COS), .y1(inputY1_COS), .x(inputX_COS), .y(output_COS));

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        LAT_COSA <= 64'b0;
        LAT_COSB <= 64'b0;
    end
    else begin
        if (state == GOT_COS_A) begin
            LAT_COSA <= output_COS;
        end
        else if (state == GOT_COS_B) begin
            LAT_COSB <= output_COS;
        end
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        inputX_COS <= 48'b0;
    end
    else begin
        if (state == PREPARE_COS_A) begin
            inputX_COS <= {8'b0, LAT_A, 16'b0};
        end
        else if (state == PREPARE_COS_B) begin
            inputX_COS <= {8'b0, LAT_B, 16'b0};
        end
    end
end

always @(posedge clk or negedge reset_n) begin : the_inputs_of_COS
    if (!reset_n) begin
        inputX0_COS <= 48'b0;
        inputY0_COS <= 48'b0;
        inputX1_COS <= 48'b0;
        inputY1_COS <= 48'b0;
    end
    else begin
        if (state == PREPARE_COS_A || state == PREPARE_COS_B) begin
            {inputX0_COS, inputY0_COS} <= COS_DATA;
        end
        else if (state == CAL_COS_A || state == CAL_COS_B) begin
            if ((inputX_COS > inputX0_COS) && (inputX_COS < COS_DATA[95:48])) begin
                {inputX1_COS, inputY1_COS} <= COS_DATA;
            end
            else begin
                {inputX0_COS, inputY0_COS} <= COS_DATA;
            end
        end
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        COS_ADDR <= 7'b0;
    end
    else begin
        if (state == PREPARE_COS_A || state == PREPARE_COS_B) begin
            COS_ADDR <= 7'b0;
        end
        else if (state == CAL_COS_A || state == CAL_COS_B) begin
            COS_ADDR <= COS_ADDR + 7'b1;
        end
    end
end

// =================================================================================
// Perform SIN2 FUNCTION

FUNC_SIN2 U_FUNC_SIN2(.A(inputA_SIN2), .B(inputB_SIN2), .out(output_SIN2));

always @(posedge clk or negedge reset_n) begin : the_output_of_SIN2
    if (!reset_n) begin
        LAT_SIN2 <= 96'b0;
        LON_SIN2 <= 96'b0;
    end
    else begin
        if (state == GOT_SIN2_LAT) begin
            LAT_SIN2 <= output_SIN2;
        end
        else if (state == GOT_SIN2_LON) begin
            LON_SIN2 <= output_SIN2;
        end
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        inputA_SIN2 <= 24'b0;
        inputB_SIN2 <= 24'b0;
    end
    else begin
        if (state == CAL_SIN2_LAT) begin
            inputA_SIN2 <= LAT_A;
            inputB_SIN2 <= LAT_B;
        end
        else if (state == CAL_SIN2_LON) begin
            inputA_SIN2 <= LON_A;
            inputB_SIN2 <= LON_B;
        end
    end
end

// =================================================================================

always @(posedge clk or negedge reset_n) begin : buffer_LON_and_LAT
    if (!reset_n) begin
        LON_A <= 24'b0;
        LAT_A <= 24'b0;
        LON_B <= 24'b0;
        LAT_B <= 24'b0;
    end
    else if (DEN) begin
        LON_A <= LON_IN;
        LAT_A <= LAT_IN;
        LON_B <= LON_A;
        LAT_B <= LAT_A;
    end
end

always @(posedge clk or negedge reset_n) begin : check_is_it_first_data
    if (!reset_n) begin
        enable_start <= 1'b0;
    end
    else begin
        if (~enable_start && DEN) begin
            enable_start <= 1'b1;
        end
    end
end

always @(*) begin
    case(state)
        IDLE            : nstate = (enable_start && DEN) ? CAL_SIN2_LAT : IDLE; 
        CAL_SIN2_LAT    : nstate = GOT_SIN2_LAT;
        GOT_SIN2_LAT    : nstate = CAL_SIN2_LON;
        CAL_SIN2_LON    : nstate = GOT_SIN2_LON;
        GOT_SIN2_LON    : nstate = PREPARE_COS_A;
        PREPARE_COS_A   : nstate = CAL_COS_A;
        CAL_COS_A       : nstate = ((inputX_COS > inputX0_COS) && (inputX_COS < COS_DATA[95:48])) ? GOT_COS_A : CAL_COS_A;
        GOT_COS_A       : nstate = PREPARE_COS_B;
        PREPARE_COS_B   : nstate = CAL_COS_B;
        CAL_COS_B       : nstate = ((inputX_COS > inputX0_COS) && (inputX_COS < COS_DATA[95:48])) ? GOT_COS_B : CAL_COS_B;
        GOT_COS_B       : nstate = PREPARE_ASIN;
        PREPARE_ASIN    : nstate = CAL_ASIN;
        CAL_ASIN        : nstate = (a == 64'b0) ? FINISH : (((a > inputX0_ASIN) && (a < ASIN_DATA[127:64])) ? GOT_ASIN : CAL_ASIN);
        GOT_ASIN        : nstate = FINISH;
        FINISH          : nstate = IDLE;
        default         : nstate = IDLE;
    endcase
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= IDLE;
    end
    else begin
        state <= nstate;
    end
end

endmodule

module FUNC_SIN2(A, B, out);
    
    input   [23:0]  A; // Q8.16
    input   [23:0]  B; // Q8.16

    output  [63:0]  out; // Q0.64
    
    wire    [23:0]  minus_AB;   // Q8.16
    wire    [47:0]  multi;      // Q16.32
    wire    [47:0]  div2;       // Q16.32
    wire    [95:0]  multi_div2; // Q32.64

    assign minus_AB = (A > B) ? (A - B) : (B - A);
    assign multi = (minus_AB << 10) + (minus_AB << 6) + (minus_AB << 5) + (minus_AB << 4) + (minus_AB << 2) + (minus_AB << 1) + minus_AB;
    assign div2 = {1'b0, multi[47:1]};
    assign multi_div2 = div2 * div2;
    assign out = multi_div2[63:0];

endmodule

module FUNC_MULTI(a, b, c, out);

    input   [63:0]  a; // Q0.64
    input   [63:0]  b; // Q0.64
    input   [63:0]  c; // Q0.64

    output  [63:0]  out; // Q0.64

    wire    [127:0] multi_ab; // Q0.128
    wire    [255:0] multi_abc; // Q0.256

    assign multi_ab = a * b;
    assign multi_abc = multi_ab * {c, 64'b0};

    assign out = multi_abc[255:192];
endmodule


module FUNC_INTERPOLATION_COS(x0, y0, x1, y1, x, y);

    input   [47:0]  x0; // Q16.32
    input   [47:0]  y0; // Q16.32
    input   [47:0]  x1; // Q16.32
    input   [47:0]  y1; // Q16.32
    input   [47:0]  x;  // Q16.32

    output  [63:0]  y;  // Q0.64

    wire    [31:0]  minus_x1_x0; // Q0.32
    wire    [31:0]  minus_x_x0;  // Q0.32
    wire    [31:0]  minus_y1_y0; // Q0.32

    wire    [63:0]  multi1; // Q0.64
    wire    [63:0]  multi2; // Q0.64
    wire    [63:0]  add;    // Q0.64
    wire    [95:0]  buff;  // Q0.96

    assign minus_x1_x0 = x1 - x0;
    assign minus_x_x0  = x  - x0;
    assign minus_y1_y0 = y1 - y0;

    assign multi1 = y0 * minus_x1_x0;
    assign multi2 = minus_x_x0 * minus_y1_y0;

    assign add = multi1 + multi2;
    assign buff = {add, 32'b0};

    assign y = buff / minus_x1_x0;


endmodule


module FUNC_INTERPOLATION_ASIN(x0, y0, x1, y1, x, y);

    input   [63:0]  x0; // Q0.64
    input   [63:0]  y0; // Q0.64
    input   [63:0]  x1; // Q0.64
    input   [63:0]  y1; // Q0.64
    input   [63:0]  x; // Q0.64

    output  [39:0]  y;  // Q8.32

    wire    [63:0]  minus_x1_x0; // Q0.64
    wire    [63:0]  minus_x_x0;  // Q0.64
    wire    [63:0]  minus_y1_y0; // Q0.64

    wire    [127:0] multi1; // Q0.128
    wire    [127:0] multi2; // Q0.128
    wire    [127:0] add;    // Q0.128
    wire    [303:0] buff1;  // Q24.128 * Q24.128 = Q48.256
    wire    [303:0] buff2;  // Q48.256


    assign minus_x1_x0 = x1 - x0;
    assign minus_x_x0  = x  - x0;
    assign minus_y1_y0 = y1 - y0;

    assign multi1 = y0 * minus_x1_x0;
    assign multi2 = minus_x_x0 * minus_y1_y0;
    assign add = multi1 + multi2;

    assign buff1 = {24'b0, add} * {24'hC2A532, 128'h0};
    assign buff2 = {buff1, 64'b0} / minus_x1_x0;

    assign y = buff2[263:224];

endmodule
