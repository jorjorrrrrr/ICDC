// ======================================================================
//
// Module Name  : 1D Interpolation
//
// Author       : jorjor
// Company      : NKUST NCLAB
// Created Date : 2024.09.09
//
// ======================================================================

`timescale 1ns/100ps

module interpolation1d #(
    parameter FBIT = 15
) (
    input               CLK,
    input               RST,
    input   [7:0]       ip0,    // Q8.0
    input   [7:0]       ip1,    // Q8.0 
    input   [7:0]       ip2,    // Q8.0 
    input   [7:0]       ipn,    // Q8.0 
    input   [FBIT-1:0]  x,      // Q0.15
    output  [7:0]       dout    // Q8.0
);

wire signed [8:0]           p0;     // QS.8.0
wire signed [8:0]           p1;     // QS.8.0
wire signed [8:0]           p2;     // QS.8.0
wire signed [8:0]           pn;     // QS.8.0

wire signed [10:0]          a;      // QS.9.1
wire signed [10:0]          b;      // QS.9.1
wire signed [10:0]          c;      // QS.9.1
wire signed [10:0]          d;      // QS.9.1

wire        [FBIT*2-1:0]    x2;     // Q0.30
wire        [FBIT*3-1:0]    x3;     // Q0.45

wire signed [FBIT*1:0]      sx;     // QS.0.15
wire signed [FBIT*2:0]      sx2;    // QS.0.30
wire signed [FBIT*3:0]      sx3;    // QS.0.45

wire signed [FBIT*1+10:0]   scx;    // QS.9.16
wire signed [FBIT*2+10:0]   sbx2;   // QS.9.31
wire signed [FBIT*3+10:0]   sax3;   // QS.9.46

wire signed [FBIT*3+10:0]   sum;    // QS.9.46
wire signed [9:0]           round;  // QS.9.0

// for pipeline
reg  signed [10:0]          a_r;    // QS.9.1
reg  signed [10:0]          b_r;    // QS.9.1
reg  signed [10:0]          c_r;    // QS.9.1
reg  signed [10:0]          d_r;    // QS.9.1

reg         [FBIT*1-1:0]    x_r;    // Q0.30
reg         [FBIT*2-1:0]    x2_r;   // Q0.30
reg         [FBIT*3-1:0]    x3_r;   // Q0.45

// Convert them into signed representation
assign p0 = ip0;
assign p1 = ip1;
assign p2 = ip2;
assign pn = ipn;

// Bicubic Interpolation Calculation
//assign a = 3 * p0 + p2 - pn - 3 * p1;
assign a = (p0 << 1) + p0 + p2 - pn - (p1 << 1) - p1;
//assign b = 2 * pn + 4 * p1 - 5 * p0 - p2;
assign b = (pn << 1) + (p1 << 2) - (p0 << 2) - p0 - p2;
assign c = p1 - pn;
assign d = {p0, 1'b0};

assign x2 = x * x;
assign x3 = x2 * x;

// pipeline --------------------------------------------------
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        a_r  <= 0;
        b_r  <= 0;
        c_r  <= 0;
        d_r  <= 0;
        x_r  <= 0;
        x2_r <= 0;
        x3_r <= 0;
    end
    else begin
        a_r  <= a;
        b_r  <= b;
        c_r  <= c;
        d_r  <= d;
        x_r  <= x;
        x2_r <= x2;
        x3_r <= x3;
    end
end


assign sx  = {1'b0, x_r};
assign sx2 = {1'b0, x2_r};
assign sx3 = {1'b0, x3_r};

assign scx  = c_r * sx; 
assign sbx2 = b_r * sx2; 
assign sax3 = a_r * sx3; 

assign sum = sax3 + {sbx2, {(FBIT){1'b0}}} + {scx, {(FBIT*2){1'b0}}} + {d_r, {(FBIT*3){1'b0}}};

// Rounding
assign round = sum[FBIT*3+10-:10] + sum[FBIT*3];

// Determine that it is positive integer
assign dout = (round < 0) ? 0 : round[7:0];

endmodule
