/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : T-2022.03
// Date      : Wed Jan 18 10:56:35 2023
/////////////////////////////////////////////////////////////


module STI_DAC_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2X1 U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module STI_DAC ( clk, reset, load, pi_data, pi_length, pi_fill, pi_msb, pi_low, 
        pi_end, so_data, so_valid, oem_finish, oem_dataout, oem_addr, odd1_wr, 
        odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr );
  input [15:0] pi_data;
  input [1:0] pi_length;
  output [7:0] oem_dataout;
  output [4:0] oem_addr;
  input clk, reset, load, pi_fill, pi_msb, pi_low, pi_end;
  output so_data, so_valid, oem_finish, odd1_wr, odd2_wr, odd3_wr, odd4_wr,
         even1_wr, even2_wr, even3_wr, even4_wr;
  wire   n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, N105, N106, N107, N108, N109, N110, N111,
         N112, N361, N362, N363, N364, N365, N402, N403, N404, N405, N412, n1,
         n3, n10, n11, n12, n17, n18, n21, n23, n25, n27, n29, n30, n32, n34,
         n35, n36, n38, n42, n43, n45, n47, n49, n51, n53, n55, n56, n58, n59,
         n60, n62, n64, n66, n68, n70, n72, n74, n76, n77, n79, n81, n83, n85,
         n87, n89, n91, n92, n93, n95, n96, n98, n104, n108, n112, n116, n120,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n134, n136,
         n137, n139, n144, n145, n146, n147, n148, n149, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n207,
         n208, n209, n211, n214, n215, n216, n217, n218, n219, n220, n221,
         n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232,
         n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254,
         n255, n256, n257, n258, n259, n260, n261, n262, n263, n264, n265,
         n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n276,
         n277, n278, n279, n280, n281, n282, n283, n284, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366,
         n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377,
         n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388,
         n389, n390, n391, n392, n393, n394, n395, n396, n397, n398;
  wire   [2:0] state;
  wire   [7:0] oem_count;
  wire   [4:0] count;
  wire   [2:0] nstate;

  AOI31X2 U197 ( .A0(n137), .A1(n350), .A2(n352), .B0(n312), .Y(n96) );
  STI_DAC_DW01_inc_0 r399 ( .A(oem_count), .SUM({N112, N111, N110, N109, N108, 
        N107, N106, N105}) );
  DFFRX1 \data_reg[31]  ( .D(n175), .CK(clk), .RN(n317), .QN(n176) );
  DFFRX1 \data_reg[30]  ( .D(n235), .CK(clk), .RN(n318), .QN(n177) );
  DFFRX1 \data_reg[9]  ( .D(n256), .CK(clk), .RN(n319), .Q(n369), .QN(n198) );
  DFFRX1 \data_reg[10]  ( .D(n255), .CK(clk), .RN(n319), .Q(n370), .QN(n197)
         );
  DFFRX1 \data_reg[11]  ( .D(n254), .CK(clk), .RN(n319), .Q(n371), .QN(n196)
         );
  DFFRX1 \data_reg[12]  ( .D(n253), .CK(clk), .RN(n319), .Q(n372), .QN(n195)
         );
  DFFRX1 \data_reg[13]  ( .D(n252), .CK(clk), .RN(n319), .Q(n373), .QN(n194)
         );
  DFFRX1 \data_reg[14]  ( .D(n251), .CK(clk), .RN(n319), .Q(n374), .QN(n193)
         );
  DFFRX1 \data_reg[15]  ( .D(n250), .CK(clk), .RN(n319), .Q(n284), .QN(n192)
         );
  DFFRX1 \data_reg[16]  ( .D(n249), .CK(clk), .RN(n319), .Q(n283), .QN(n191)
         );
  DFFRX1 \data_reg[17]  ( .D(n248), .CK(clk), .RN(n319), .Q(n375), .QN(n190)
         );
  DFFRX1 \data_reg[18]  ( .D(n247), .CK(clk), .RN(n319), .Q(n376), .QN(n189)
         );
  DFFRX1 \data_reg[19]  ( .D(n246), .CK(clk), .RN(n318), .Q(n377), .QN(n188)
         );
  DFFRX1 \data_reg[20]  ( .D(n245), .CK(clk), .RN(n318), .Q(n378), .QN(n187)
         );
  DFFRX1 \data_reg[21]  ( .D(n244), .CK(clk), .RN(n318), .Q(n379), .QN(n186)
         );
  DFFRX1 \data_reg[22]  ( .D(n243), .CK(clk), .RN(n318), .Q(n380), .QN(n185)
         );
  DFFRX1 \data_reg[23]  ( .D(n242), .CK(clk), .RN(n318), .Q(n381), .QN(n184)
         );
  DFFRX1 \data_reg[24]  ( .D(n241), .CK(clk), .RN(n318), .Q(n382), .QN(n183)
         );
  DFFRX1 \data_reg[25]  ( .D(n240), .CK(clk), .RN(n318), .Q(n383), .QN(n182)
         );
  DFFRX1 \data_reg[26]  ( .D(n239), .CK(clk), .RN(n318), .Q(n384), .QN(n181)
         );
  DFFRX1 \data_reg[27]  ( .D(n238), .CK(clk), .RN(n318), .Q(n385), .QN(n180)
         );
  DFFRX1 \data_reg[28]  ( .D(n237), .CK(clk), .RN(n318), .Q(n386), .QN(n179)
         );
  DFFRX1 \data_reg[29]  ( .D(n236), .CK(clk), .RN(n318), .Q(n387), .QN(n178)
         );
  DFFRX1 \data_reg[1]  ( .D(n264), .CK(clk), .RN(n319), .Q(n362) );
  DFFRX1 \data_reg[2]  ( .D(n263), .CK(clk), .RN(n318), .Q(n363) );
  DFFRX1 \data_reg[3]  ( .D(n262), .CK(clk), .RN(n316), .Q(n364) );
  DFFRX1 \data_reg[4]  ( .D(n261), .CK(clk), .RN(n317), .Q(n365) );
  DFFRX1 \data_reg[5]  ( .D(n260), .CK(clk), .RN(n319), .Q(n366) );
  DFFRX1 \data_reg[6]  ( .D(n259), .CK(clk), .RN(n318), .Q(n367) );
  DFFRX1 \data_reg[7]  ( .D(n258), .CK(clk), .RN(n319), .Q(n368) );
  DFFRX1 \data_reg[8]  ( .D(n257), .CK(clk), .RN(n319), .Q(n282), .QN(n199) );
  DFFRX1 \count_reg[4]  ( .D(n265), .CK(clk), .RN(n316), .Q(count[4]), .QN(
        n208) );
  DFFRX1 \count_reg[3]  ( .D(n266), .CK(clk), .RN(n331), .Q(count[3]), .QN(
        n209) );
  DFFRX1 \count_reg[1]  ( .D(n268), .CK(clk), .RN(n317), .Q(count[1]), .QN(
        n211) );
  DFFRX1 \count_reg[0]  ( .D(n269), .CK(clk), .RN(n317), .Q(count[0]), .QN(
        N361) );
  DFFRX1 \count_reg[2]  ( .D(n267), .CK(clk), .RN(n331), .QN(n330) );
  DFFRX1 \state_reg[2]  ( .D(nstate[2]), .CK(clk), .RN(n318), .Q(state[2]), 
        .QN(n279) );
  TLATX1 \nstate_reg[2]  ( .G(N402), .D(N405), .Q(nstate[2]) );
  TLATX1 \nstate_reg[1]  ( .G(N402), .D(N404), .Q(nstate[1]) );
  TLATX1 \nstate_reg[0]  ( .G(N402), .D(N403), .Q(nstate[0]) );
  DFFRX1 \state_reg[0]  ( .D(nstate[0]), .CK(clk), .RN(n316), .Q(state[0]), 
        .QN(n280) );
  DFFRX1 \state_reg[1]  ( .D(nstate[1]), .CK(clk), .RN(n317), .Q(state[1]), 
        .QN(n278) );
  DFFRX1 \oem_dataout_reg[6]  ( .D(n215), .CK(clk), .RN(n317), .QN(n394) );
  DFFRX1 \oem_dataout_reg[5]  ( .D(n216), .CK(clk), .RN(n317), .QN(n393) );
  DFFRX1 \oem_dataout_reg[4]  ( .D(n217), .CK(clk), .RN(n317), .QN(n392) );
  DFFRX1 \oem_dataout_reg[3]  ( .D(n218), .CK(clk), .RN(n317), .QN(n391) );
  DFFRX1 \oem_dataout_reg[2]  ( .D(n219), .CK(clk), .RN(n317), .QN(n390) );
  DFFRX1 \oem_dataout_reg[1]  ( .D(n220), .CK(clk), .RN(n317), .QN(n389) );
  DFFRX1 \oem_dataout_reg[0]  ( .D(n221), .CK(clk), .RN(n317), .QN(n388) );
  DFFRX1 odd2_wr_reg ( .D(n233), .CK(clk), .RN(n316), .Q(n407), .QN(n158) );
  DFFRX1 even2_wr_reg ( .D(n229), .CK(clk), .RN(n316), .Q(n411), .QN(n162) );
  DFFRX1 odd3_wr_reg ( .D(n232), .CK(clk), .RN(n316), .Q(n408), .QN(n159) );
  DFFRX1 odd4_wr_reg ( .D(n231), .CK(clk), .RN(n316), .Q(n409), .QN(n160) );
  DFFRX1 even3_wr_reg ( .D(n228), .CK(clk), .RN(n316), .Q(n412), .QN(n163) );
  DFFRX1 even4_wr_reg ( .D(n227), .CK(clk), .RN(n316), .Q(n413), .QN(n164) );
  DFFRX1 \oem_addr_reg[0]  ( .D(n226), .CK(clk), .RN(n316), .Q(n405), .QN(n165) );
  DFFRX1 odd1_wr_reg ( .D(n234), .CK(clk), .RN(n316), .Q(n406), .QN(n157) );
  DFFRX1 even1_wr_reg ( .D(n230), .CK(clk), .RN(n316), .Q(n410), .QN(n161) );
  DFFRX1 \oem_addr_reg[4]  ( .D(n225), .CK(clk), .RN(n316), .Q(n401), .QN(n166) );
  DFFRX1 \oem_addr_reg[3]  ( .D(n224), .CK(clk), .RN(n331), .Q(n402), .QN(n167) );
  DFFRX1 \oem_addr_reg[2]  ( .D(n223), .CK(clk), .RN(n331), .Q(n403), .QN(n168) );
  DFFRX1 \oem_addr_reg[1]  ( .D(n222), .CK(clk), .RN(n331), .Q(n404), .QN(n169) );
  DFFRX1 \oem_dataout_reg[7]  ( .D(n214), .CK(clk), .RN(n317), .Q(n400), .QN(
        n174) );
  DFFRX1 so_data_reg ( .D(n172), .CK(clk), .RN(n317), .Q(n399), .QN(n171) );
  DFFRX1 so_valid_reg ( .D(n361), .CK(clk), .RN(n316), .QN(n281) );
  DFFRX1 \oem_count_reg[4]  ( .D(n273), .CK(clk), .RN(n331), .Q(oem_count[4]), 
        .QN(n396) );
  DFFRX1 \oem_count_reg[3]  ( .D(n274), .CK(clk), .RN(n331), .Q(oem_count[3]), 
        .QN(n395) );
  DFFRX1 \oem_count_reg[6]  ( .D(n271), .CK(clk), .RN(n331), .Q(oem_count[6]), 
        .QN(n397) );
  DFFRX1 \oem_count_reg[5]  ( .D(n272), .CK(clk), .RN(n331), .Q(oem_count[5])
         );
  DFFRX1 \oem_count_reg[2]  ( .D(n275), .CK(clk), .RN(n331), .Q(oem_count[2])
         );
  DFFRX1 \oem_count_reg[1]  ( .D(n277), .CK(clk), .RN(n331), .Q(oem_count[1])
         );
  DFFRX1 \oem_count_reg[0]  ( .D(n276), .CK(clk), .RN(n331), .Q(oem_count[0])
         );
  DFFRX1 \oem_count_reg[7]  ( .D(n270), .CK(clk), .RN(n331), .Q(oem_count[7]), 
        .QN(n398) );
  DFFRX1 \data_reg[0]  ( .D(n207), .CK(clk), .RN(n331), .Q(n170) );
  NAND2X1 U233 ( .A(state[2]), .B(n278), .Y(n146) );
  INVX12 U234 ( .A(n281), .Y(so_valid) );
  INVX3 U235 ( .A(reset), .Y(n331) );
  BUFX12 U236 ( .A(n399), .Y(so_data) );
  BUFX12 U237 ( .A(n400), .Y(oem_dataout[7]) );
  BUFX12 U238 ( .A(n404), .Y(oem_addr[1]) );
  BUFX12 U239 ( .A(n403), .Y(oem_addr[2]) );
  BUFX12 U240 ( .A(n402), .Y(oem_addr[3]) );
  BUFX12 U241 ( .A(n401), .Y(oem_addr[4]) );
  BUFX12 U242 ( .A(n410), .Y(even1_wr) );
  BUFX12 U243 ( .A(n406), .Y(odd1_wr) );
  BUFX12 U244 ( .A(n405), .Y(oem_addr[0]) );
  BUFX12 U245 ( .A(n413), .Y(even4_wr) );
  BUFX12 U246 ( .A(n412), .Y(even3_wr) );
  BUFX12 U247 ( .A(n409), .Y(odd4_wr) );
  BUFX12 U248 ( .A(n408), .Y(odd3_wr) );
  BUFX12 U249 ( .A(n411), .Y(even2_wr) );
  BUFX12 U250 ( .A(n407), .Y(odd2_wr) );
  INVX12 U251 ( .A(n388), .Y(oem_dataout[0]) );
  INVX12 U252 ( .A(n389), .Y(oem_dataout[1]) );
  INVX12 U253 ( .A(n390), .Y(oem_dataout[2]) );
  INVX12 U254 ( .A(n391), .Y(oem_dataout[3]) );
  INVX12 U255 ( .A(n392), .Y(oem_dataout[4]) );
  INVX12 U256 ( .A(n393), .Y(oem_dataout[5]) );
  INVX12 U257 ( .A(n394), .Y(oem_dataout[6]) );
  OR2X1 U258 ( .A(n146), .B(n280), .Y(N412) );
  INVX12 U259 ( .A(N412), .Y(oem_finish) );
  CLKINVX1 U260 ( .A(n36), .Y(n325) );
  NAND2X1 U261 ( .A(n29), .B(n17), .Y(n21) );
  CLKINVX1 U262 ( .A(n125), .Y(n351) );
  CLKBUFX3 U263 ( .A(n59), .Y(n315) );
  INVX3 U264 ( .A(n325), .Y(n324) );
  CLKINVX1 U265 ( .A(n21), .Y(n353) );
  INVX3 U266 ( .A(n309), .Y(n322) );
  INVX3 U267 ( .A(n309), .Y(n323) );
  CLKBUFX3 U268 ( .A(n351), .Y(n320) );
  CLKBUFX3 U269 ( .A(n351), .Y(n321) );
  CLKINVX1 U270 ( .A(n36), .Y(n326) );
  CLKBUFX3 U271 ( .A(n331), .Y(n316) );
  CLKBUFX3 U272 ( .A(n331), .Y(n317) );
  CLKBUFX3 U273 ( .A(n331), .Y(n318) );
  CLKBUFX3 U274 ( .A(n331), .Y(n319) );
  CLKINVX1 U275 ( .A(n55), .Y(n348) );
  NAND2X1 U276 ( .A(n361), .B(n350), .Y(n36) );
  OAI21XL U277 ( .A0(n3), .A1(n388), .B0(n10), .Y(n221) );
  OAI22XL U278 ( .A0(n310), .A1(n393), .B0(n3), .B1(n394), .Y(n215) );
  OAI22XL U279 ( .A0(n310), .A1(n392), .B0(n3), .B1(n393), .Y(n216) );
  OAI22XL U280 ( .A0(n310), .A1(n391), .B0(n3), .B1(n392), .Y(n217) );
  OAI22XL U281 ( .A0(n310), .A1(n390), .B0(n3), .B1(n391), .Y(n218) );
  OAI22XL U282 ( .A0(n310), .A1(n389), .B0(n3), .B1(n390), .Y(n219) );
  OAI22XL U283 ( .A0(n310), .A1(n388), .B0(n3), .B1(n389), .Y(n220) );
  CLKINVX1 U284 ( .A(n314), .Y(n360) );
  OR2X2 U285 ( .A(n35), .B(n360), .Y(n29) );
  NAND2X2 U286 ( .A(n314), .B(n35), .Y(n17) );
  INVX3 U287 ( .A(n310), .Y(n361) );
  AND2X2 U288 ( .A(n311), .B(n310), .Y(n309) );
  OAI2BB2XL U289 ( .B0(n314), .B1(n397), .A0N(N111), .A1N(n314), .Y(n271) );
  NAND2X2 U290 ( .A(n310), .B(n11), .Y(n3) );
  OAI2BB2XL U291 ( .B0(n314), .B1(n396), .A0N(N109), .A1N(n314), .Y(n273) );
  OAI2BB2XL U292 ( .B0(n314), .B1(n395), .A0N(N108), .A1N(n314), .Y(n274) );
  NAND2X1 U293 ( .A(n397), .B(n398), .Y(n27) );
  NAND2BXL U294 ( .AN(oem_finish), .B(n11), .Y(N405) );
  OAI221XL U295 ( .A0(n332), .A1(n95), .B0(n96), .B1(n340), .C0(n98), .Y(n258)
         );
  CLKINVX1 U296 ( .A(pi_data[7]), .Y(n340) );
  AOI222XL U297 ( .A0(n309), .A1(n368), .B0(n321), .B1(n367), .C0(n326), .C1(
        n282), .Y(n98) );
  OAI221XL U298 ( .A0(n333), .A1(n95), .B0(n96), .B1(n341), .C0(n104), .Y(n259) );
  CLKINVX1 U299 ( .A(pi_data[14]), .Y(n333) );
  CLKINVX1 U300 ( .A(pi_data[6]), .Y(n341) );
  AOI222XL U301 ( .A0(n309), .A1(n367), .B0(n321), .B1(n366), .C0(n326), .C1(
        n368), .Y(n104) );
  OAI221XL U302 ( .A0(n334), .A1(n95), .B0(n96), .B1(n342), .C0(n108), .Y(n260) );
  CLKINVX1 U303 ( .A(pi_data[13]), .Y(n334) );
  CLKINVX1 U304 ( .A(pi_data[5]), .Y(n342) );
  AOI222XL U305 ( .A0(n309), .A1(n366), .B0(n320), .B1(n365), .C0(n325), .C1(
        n367), .Y(n108) );
  OAI221XL U306 ( .A0(n335), .A1(n95), .B0(n96), .B1(n343), .C0(n112), .Y(n261) );
  CLKINVX1 U307 ( .A(pi_data[12]), .Y(n335) );
  CLKINVX1 U308 ( .A(pi_data[4]), .Y(n343) );
  AOI222XL U309 ( .A0(n309), .A1(n365), .B0(n321), .B1(n364), .C0(n325), .C1(
        n366), .Y(n112) );
  OAI221XL U310 ( .A0(n336), .A1(n95), .B0(n96), .B1(n344), .C0(n116), .Y(n262) );
  CLKINVX1 U311 ( .A(pi_data[11]), .Y(n336) );
  CLKINVX1 U312 ( .A(pi_data[3]), .Y(n344) );
  AOI222XL U313 ( .A0(n309), .A1(n364), .B0(n320), .B1(n363), .C0(n326), .C1(
        n365), .Y(n116) );
  OAI221XL U314 ( .A0(n337), .A1(n95), .B0(n96), .B1(n345), .C0(n120), .Y(n263) );
  CLKINVX1 U315 ( .A(pi_data[10]), .Y(n337) );
  CLKINVX1 U316 ( .A(pi_data[2]), .Y(n345) );
  AOI222XL U317 ( .A0(n309), .A1(n363), .B0(n321), .B1(n362), .C0(n326), .C1(
        n364), .Y(n120) );
  OAI221XL U318 ( .A0(n338), .A1(n95), .B0(n96), .B1(n346), .C0(n124), .Y(n264) );
  CLKINVX1 U319 ( .A(pi_data[9]), .Y(n338) );
  CLKINVX1 U320 ( .A(pi_data[1]), .Y(n346) );
  AOI222XL U321 ( .A0(n309), .A1(n362), .B0(n170), .B1(n320), .C0(n326), .C1(
        n363), .Y(n124) );
  OAI221XL U322 ( .A0(n339), .A1(n95), .B0(n96), .B1(n347), .C0(n144), .Y(n207) );
  CLKINVX1 U323 ( .A(pi_data[8]), .Y(n339) );
  CLKINVX1 U324 ( .A(pi_data[0]), .Y(n347) );
  AOI22X1 U325 ( .A0(n170), .A1(n309), .B0(n325), .B1(n362), .Y(n144) );
  NAND2BX1 U326 ( .AN(pi_length[0]), .B(pi_length[1]), .Y(n93) );
  CLKBUFX3 U327 ( .A(n76), .Y(n312) );
  OAI32X1 U328 ( .A0(n311), .A1(pi_msb), .A2(n145), .B0(pi_fill), .B1(n126), 
        .Y(n76) );
  OA21XL U329 ( .A0(n93), .A1(pi_fill), .B0(n128), .Y(n145) );
  AOI31X1 U330 ( .A0(pi_low), .A1(pi_msb), .A2(n137), .B0(n313), .Y(n55) );
  OAI221XL U331 ( .A0(n176), .A1(n324), .B0(n177), .B1(n322), .C0(n38), .Y(
        n235) );
  AOI222XL U332 ( .A0(pi_data[14]), .A1(n348), .B0(n321), .B1(n387), .C0(
        pi_data[6]), .C1(n42), .Y(n38) );
  OAI221XL U333 ( .A0(n177), .A1(n324), .B0(n178), .B1(n323), .C0(n43), .Y(
        n236) );
  AOI222XL U334 ( .A0(pi_data[13]), .A1(n348), .B0(n321), .B1(n386), .C0(
        pi_data[5]), .C1(n42), .Y(n43) );
  OAI221XL U335 ( .A0(n178), .A1(n324), .B0(n179), .B1(n323), .C0(n45), .Y(
        n237) );
  AOI222XL U336 ( .A0(pi_data[12]), .A1(n348), .B0(n321), .B1(n385), .C0(
        pi_data[4]), .C1(n42), .Y(n45) );
  OAI221XL U337 ( .A0(n179), .A1(n324), .B0(n180), .B1(n323), .C0(n47), .Y(
        n238) );
  AOI222XL U338 ( .A0(pi_data[11]), .A1(n348), .B0(n321), .B1(n384), .C0(
        pi_data[3]), .C1(n42), .Y(n47) );
  OAI221XL U339 ( .A0(n180), .A1(n324), .B0(n181), .B1(n323), .C0(n49), .Y(
        n239) );
  AOI222XL U340 ( .A0(pi_data[10]), .A1(n348), .B0(n321), .B1(n383), .C0(
        pi_data[2]), .C1(n42), .Y(n49) );
  OAI221XL U341 ( .A0(n181), .A1(n324), .B0(n182), .B1(n323), .C0(n51), .Y(
        n240) );
  AOI222XL U342 ( .A0(pi_data[9]), .A1(n348), .B0(n321), .B1(n382), .C0(
        pi_data[1]), .C1(n42), .Y(n51) );
  OAI221XL U343 ( .A0(n182), .A1(n324), .B0(n183), .B1(n323), .C0(n53), .Y(
        n241) );
  AOI222XL U344 ( .A0(pi_data[8]), .A1(n348), .B0(n321), .B1(n381), .C0(
        pi_data[0]), .C1(n42), .Y(n53) );
  CLKBUFX3 U345 ( .A(n58), .Y(n313) );
  OAI32X1 U346 ( .A0(n311), .A1(n139), .A2(n350), .B0(n349), .B1(n126), .Y(n58) );
  OA21XL U347 ( .A0(n349), .A1(n93), .B0(n128), .Y(n139) );
  CLKINVX1 U348 ( .A(pi_fill), .Y(n349) );
  NAND2BX1 U349 ( .AN(pi_length[1]), .B(pi_length[0]), .Y(n128) );
  NAND3BX1 U350 ( .AN(n311), .B(pi_length[1]), .C(pi_length[0]), .Y(n126) );
  CLKINVX1 U351 ( .A(pi_msb), .Y(n350) );
  OAI221XL U352 ( .A0(n55), .A1(n332), .B0(n176), .B1(n322), .C0(n136), .Y(
        n175) );
  AOI2BB2X1 U353 ( .B0(pi_data[7]), .B1(n42), .A0N(n125), .A1N(n177), .Y(n136)
         );
  OAI221XL U354 ( .A0(n191), .A1(n324), .B0(n192), .B1(n322), .C0(n74), .Y(
        n250) );
  AOI222XL U355 ( .A0(n320), .A1(n374), .B0(n315), .B1(pi_data[7]), .C0(
        pi_data[15]), .C1(n312), .Y(n74) );
  OAI221XL U356 ( .A0(n192), .A1(n324), .B0(n193), .B1(n322), .C0(n77), .Y(
        n251) );
  AOI222XL U357 ( .A0(n320), .A1(n373), .B0(n315), .B1(pi_data[6]), .C0(
        pi_data[14]), .C1(n312), .Y(n77) );
  OAI221XL U358 ( .A0(n193), .A1(n324), .B0(n194), .B1(n322), .C0(n79), .Y(
        n252) );
  AOI222XL U359 ( .A0(n320), .A1(n372), .B0(n315), .B1(pi_data[5]), .C0(
        pi_data[13]), .C1(n312), .Y(n79) );
  OAI221XL U360 ( .A0(n194), .A1(n324), .B0(n195), .B1(n322), .C0(n81), .Y(
        n253) );
  AOI222XL U361 ( .A0(n320), .A1(n371), .B0(n315), .B1(pi_data[4]), .C0(
        pi_data[12]), .C1(n312), .Y(n81) );
  OAI221XL U362 ( .A0(n195), .A1(n324), .B0(n196), .B1(n322), .C0(n83), .Y(
        n254) );
  AOI222XL U363 ( .A0(n320), .A1(n370), .B0(n315), .B1(pi_data[3]), .C0(
        pi_data[11]), .C1(n312), .Y(n83) );
  OAI221XL U364 ( .A0(n196), .A1(n324), .B0(n197), .B1(n322), .C0(n85), .Y(
        n255) );
  AOI222XL U365 ( .A0(n320), .A1(n369), .B0(n315), .B1(pi_data[2]), .C0(
        pi_data[10]), .C1(n312), .Y(n85) );
  OAI221XL U366 ( .A0(n197), .A1(n324), .B0(n198), .B1(n322), .C0(n87), .Y(
        n256) );
  AOI222XL U367 ( .A0(n320), .A1(n282), .B0(n315), .B1(pi_data[1]), .C0(
        pi_data[9]), .C1(n312), .Y(n87) );
  OAI221XL U368 ( .A0(n198), .A1(n324), .B0(n199), .B1(n322), .C0(n89), .Y(
        n257) );
  AOI222XL U369 ( .A0(n320), .A1(n368), .B0(n315), .B1(pi_data[0]), .C0(
        pi_data[8]), .C1(n312), .Y(n89) );
  OAI221XL U370 ( .A0(n183), .A1(n324), .B0(n184), .B1(n323), .C0(n56), .Y(
        n242) );
  AOI222XL U371 ( .A0(n320), .A1(n380), .B0(pi_data[7]), .B1(n313), .C0(
        pi_data[15]), .C1(n315), .Y(n56) );
  OAI221XL U372 ( .A0(n184), .A1(n324), .B0(n185), .B1(n323), .C0(n60), .Y(
        n243) );
  AOI222XL U373 ( .A0(n321), .A1(n379), .B0(pi_data[6]), .B1(n313), .C0(n315), 
        .C1(pi_data[14]), .Y(n60) );
  OAI221XL U374 ( .A0(n185), .A1(n324), .B0(n186), .B1(n323), .C0(n62), .Y(
        n244) );
  AOI222XL U375 ( .A0(n321), .A1(n378), .B0(pi_data[5]), .B1(n313), .C0(n315), 
        .C1(pi_data[13]), .Y(n62) );
  OAI221XL U376 ( .A0(n186), .A1(n324), .B0(n187), .B1(n323), .C0(n64), .Y(
        n245) );
  AOI222XL U377 ( .A0(n321), .A1(n377), .B0(pi_data[4]), .B1(n313), .C0(n315), 
        .C1(pi_data[12]), .Y(n64) );
  OAI221XL U378 ( .A0(n187), .A1(n324), .B0(n188), .B1(n323), .C0(n66), .Y(
        n246) );
  AOI222XL U379 ( .A0(n320), .A1(n376), .B0(pi_data[3]), .B1(n313), .C0(n315), 
        .C1(pi_data[11]), .Y(n66) );
  OAI221XL U380 ( .A0(n188), .A1(n324), .B0(n189), .B1(n322), .C0(n68), .Y(
        n247) );
  AOI222XL U381 ( .A0(n321), .A1(n375), .B0(pi_data[2]), .B1(n313), .C0(n315), 
        .C1(pi_data[10]), .Y(n68) );
  OAI221XL U382 ( .A0(n189), .A1(n36), .B0(n190), .B1(n322), .C0(n70), .Y(n248) );
  AOI222XL U383 ( .A0(n320), .A1(n283), .B0(pi_data[1]), .B1(n313), .C0(n315), 
        .C1(pi_data[9]), .Y(n70) );
  OAI221XL U384 ( .A0(n190), .A1(n36), .B0(n191), .B1(n322), .C0(n72), .Y(n249) );
  AOI222XL U385 ( .A0(n320), .A1(n284), .B0(pi_data[0]), .B1(n313), .C0(n315), 
        .C1(pi_data[8]), .Y(n72) );
  NOR3X2 U386 ( .A(pi_length[0]), .B(pi_length[1]), .C(n311), .Y(n137) );
  CLKINVX1 U387 ( .A(pi_low), .Y(n352) );
  NOR3BXL U388 ( .AN(n91), .B(n311), .C(n93), .Y(n59) );
  XOR2X1 U389 ( .A(pi_msb), .B(pi_fill), .Y(n91) );
  NAND2X1 U390 ( .A(pi_msb), .B(n361), .Y(n125) );
  AND3X2 U391 ( .A(n137), .B(pi_msb), .C(n352), .Y(n42) );
  NAND3X2 U392 ( .A(n137), .B(n350), .C(pi_low), .Y(n95) );
  AOI2BB2X1 U393 ( .B0(n325), .B1(n170), .A0N(n176), .A1N(n125), .Y(n10) );
  OAI21XL U394 ( .A0(n361), .A1(n171), .B0(n10), .Y(n172) );
  OAI211X1 U395 ( .A0(n311), .A1(n93), .B0(n126), .C0(n127), .Y(n265) );
  AOI2BB2X1 U396 ( .B0(N365), .B1(n361), .A0N(n208), .A1N(n322), .Y(n127) );
  OAI211X1 U397 ( .A0(n311), .A1(n128), .B0(n126), .C0(n129), .Y(n266) );
  AOI2BB2X1 U398 ( .B0(N364), .B1(n361), .A0N(n209), .A1N(n322), .Y(n129) );
  CLKINVX1 U399 ( .A(pi_data[15]), .Y(n332) );
  CLKBUFX3 U400 ( .A(n92), .Y(n311) );
  NAND3X1 U401 ( .A(n278), .B(n279), .C(state[0]), .Y(n92) );
  OAI22XL U402 ( .A0(n310), .A1(n394), .B0(n3), .B1(n174), .Y(n214) );
  OAI22XL U403 ( .A0(n357), .A1(n17), .B0(n162), .B1(n25), .Y(n229) );
  CLKINVX1 U404 ( .A(n25), .Y(n357) );
  OAI31XL U405 ( .A0(n397), .A1(oem_count[7]), .A2(n17), .B0(n21), .Y(n25) );
  OAI22XL U406 ( .A0(n358), .A1(n17), .B0(n163), .B1(n23), .Y(n228) );
  CLKINVX1 U407 ( .A(n23), .Y(n358) );
  OAI31XL U408 ( .A0(n398), .A1(oem_count[6]), .A2(n17), .B0(n21), .Y(n23) );
  BUFX4 U409 ( .A(n12), .Y(n314) );
  AOI211X1 U410 ( .A0(n280), .A1(n134), .B0(state[2]), .C0(n278), .Y(n12) );
  OAI22XL U411 ( .A0(n359), .A1(n17), .B0(n164), .B1(n18), .Y(n227) );
  CLKINVX1 U412 ( .A(n18), .Y(n359) );
  OAI31XL U413 ( .A0(n398), .A1(n17), .A2(n397), .B0(n21), .Y(n18) );
  OAI22XL U414 ( .A0(n354), .A1(n29), .B0(n34), .B1(n158), .Y(n233) );
  CLKINVX1 U415 ( .A(n34), .Y(n354) );
  OAI31XL U416 ( .A0(n29), .A1(oem_count[7]), .A2(n397), .B0(n21), .Y(n34) );
  OAI22XL U417 ( .A0(n355), .A1(n29), .B0(n32), .B1(n159), .Y(n232) );
  CLKINVX1 U418 ( .A(n32), .Y(n355) );
  OAI31XL U419 ( .A0(n29), .A1(oem_count[6]), .A2(n398), .B0(n21), .Y(n32) );
  OAI22XL U420 ( .A0(n356), .A1(n29), .B0(n30), .B1(n160), .Y(n231) );
  CLKINVX1 U421 ( .A(n30), .Y(n356) );
  OAI31XL U422 ( .A0(n29), .A1(n397), .A2(n398), .B0(n21), .Y(n30) );
  OAI22XL U423 ( .A0(n161), .A1(n353), .B0(n17), .B1(n27), .Y(n230) );
  OAI22XL U424 ( .A0(n353), .A1(n157), .B0(n27), .B1(n29), .Y(n234) );
  NAND3X1 U425 ( .A(n211), .B(N361), .C(n330), .Y(n134) );
  OAI211X1 U426 ( .A0(n330), .A1(n323), .B0(n311), .C0(n130), .Y(n267) );
  NAND2X1 U427 ( .A(N363), .B(n361), .Y(n130) );
  CLKBUFX3 U428 ( .A(n1), .Y(n310) );
  NAND3X1 U429 ( .A(n280), .B(n279), .C(state[1]), .Y(n1) );
  XOR2X1 U430 ( .A(oem_count[0]), .B(oem_count[3]), .Y(n35) );
  OAI2BB2XL U431 ( .B0(n314), .B1(n398), .A0N(N112), .A1N(n314), .Y(n270) );
  OAI22XL U432 ( .A0(n314), .A1(n167), .B0(n360), .B1(n396), .Y(n224) );
  OAI22XL U433 ( .A0(n314), .A1(n168), .B0(n360), .B1(n395), .Y(n223) );
  OAI211X1 U434 ( .A0(n211), .A1(n323), .B0(n311), .C0(n131), .Y(n268) );
  NAND2X1 U435 ( .A(N362), .B(n361), .Y(n131) );
  OAI211X1 U436 ( .A0(N361), .A1(n323), .B0(n311), .C0(n132), .Y(n269) );
  NAND2X1 U437 ( .A(N361), .B(n361), .Y(n132) );
  AO22X1 U438 ( .A0(n360), .A1(oem_count[5]), .B0(N110), .B1(n314), .Y(n272)
         );
  AO22X1 U439 ( .A0(n360), .A1(oem_count[2]), .B0(N107), .B1(n314), .Y(n275)
         );
  AO22X1 U440 ( .A0(n360), .A1(oem_count[0]), .B0(N105), .B1(n314), .Y(n276)
         );
  AO22X1 U441 ( .A0(n360), .A1(oem_count[1]), .B0(N106), .B1(n314), .Y(n277)
         );
  OAI2BB2XL U442 ( .B0(n314), .B1(n165), .A0N(n314), .A1N(oem_count[1]), .Y(
        n226) );
  OAI2BB2XL U443 ( .B0(n314), .B1(n166), .A0N(n314), .A1N(oem_count[5]), .Y(
        n225) );
  OAI2BB2XL U444 ( .B0(n314), .B1(n169), .A0N(n314), .A1N(oem_count[2]), .Y(
        n222) );
  NAND3X1 U445 ( .A(state[0]), .B(n279), .C(state[1]), .Y(n11) );
  OAI211X1 U446 ( .A0(state[0]), .A1(n146), .B0(n147), .C0(n148), .Y(N404) );
  AND2X2 U447 ( .A(n149), .B(n311), .Y(n148) );
  OAI31XL U448 ( .A0(count[4]), .A1(n134), .A2(count[3]), .B0(n361), .Y(n147)
         );
  NOR4X1 U449 ( .A(oem_count[2]), .B(oem_count[1]), .C(oem_count[0]), .D(n11), 
        .Y(n156) );
  NAND2X1 U450 ( .A(state[2]), .B(state[1]), .Y(N402) );
  NAND3X1 U451 ( .A(n280), .B(n278), .C(pi_end), .Y(n149) );
  NAND4X1 U452 ( .A(n153), .B(n154), .C(n146), .D(n149), .Y(N403) );
  NAND3X1 U453 ( .A(n280), .B(n278), .C(load), .Y(n153) );
  NAND4X1 U454 ( .A(n395), .B(n396), .C(n155), .D(n156), .Y(n154) );
  NOR3X1 U455 ( .A(oem_count[5]), .B(oem_count[7]), .C(oem_count[6]), .Y(n155)
         );
  NOR2X1 U456 ( .A(count[1]), .B(count[0]), .Y(n327) );
  AO21X1 U457 ( .A0(count[0]), .A1(count[1]), .B0(n327), .Y(N362) );
  NAND2X1 U458 ( .A(n327), .B(n330), .Y(n328) );
  OAI21XL U459 ( .A0(n327), .A1(n330), .B0(n328), .Y(N363) );
  XNOR2X1 U460 ( .A(count[3]), .B(n328), .Y(N364) );
  NOR2X1 U461 ( .A(count[3]), .B(n328), .Y(n329) );
  XOR2X1 U462 ( .A(count[4]), .B(n329), .Y(N365) );
endmodule

