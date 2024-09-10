// ======================================================================
//
// Module Name  : Multiplier & Divider
//
// Function Description:
//      dout = (a * b) / c
//
// Author       : jorjor
// Company      : NKUST NCLAB
// Created Date : 2024.09.09
//
// ======================================================================

`timescale 1ns/100ps

module multi_div #(
    parameter FBIT = 15
) (
    input   [6:0]           a,  // Q7.0
    input   [4:0]           b,  // Q5.0
    input   [5:0]           c,  // Q6.0
    output  [FBIT+7-1:0]    d   // Q7.15
);


wire [11:0] multi_ab;

assign multi_ab = a * b;
assign d = {multi_ab, {FBIT{1'b0}}} / c;

endmodule
