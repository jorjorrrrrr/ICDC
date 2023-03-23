/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03
// Date      : Sat Dec 31 21:32:44 2022
/////////////////////////////////////////////////////////////


module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, 
        lbp_valid, lbp_data, finish );
  output [13:0] gray_addr;
  input [7:0] gray_data;
  output [13:0] lbp_addr;
  output [7:0] lbp_data;
  input clk, reset, gray_ready;
  output gray_req, lbp_valid, finish;
  wire   n467, n468, n469, n470, n471, n472, n473, n474, n475, n476, n477,
         n478, n479, n480, n481, n482, n483, n484, n485, n486, n487, n488,
         n489, n490, n491, n492, n493, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n154, n155, n156, n157, n158,
         n159, n160, n161, n162, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n183, n184, n185, n186, n187, n188,
         n189, n200, n203, n205, n207, n209, n211, n213, n215, n217, n219,
         n221, n223, n225, n227, n229, n232, n234, n236, n238, n240, n242,
         n249, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259,
         n260, n261, n262, n263, n264, n265, n266, n267, n268, n269, n270,
         n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, n281,
         n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292,
         n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, n314,
         n315, n316, n317, n318, n319, n320, n321, n322, n323, n324, n325,
         n326, n327, n328, n329, n330, n331, n332, n333, n334, n335, n336,
         n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, n347,
         n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358,
         n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369,
         n370, n371, n372, n373, n374, n375, n376, n377, n378, n379, n380,
         n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, n391,
         n392, n393, n394, n395, n396, n397, n398, n399, n400, n401, n402,
         n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, n413,
         n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424,
         n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435,
         n436, n437, n438, n439, n440, n441, n442, n443, n444, n445, n446,
         n447, n448, n449, n450, n451, n452, n453, n454, n455, n456, n457,
         n458, n459, n460, n461, n462, n463, n464, n465;
  wire   [7:0] gc;
  wire   [3:0] state;
  wire   [3:0] nstate;

  DFFRX1 \gc_reg[0]  ( .D(n138), .CK(clk), .RN(n464), .Q(gc[0]) );
  DFFRX1 \gc_reg[7]  ( .D(n137), .CK(clk), .RN(n465), .Q(gc[7]) );
  DFFRX1 \gc_reg[6]  ( .D(n136), .CK(clk), .RN(n463), .Q(gc[6]) );
  DFFRX1 \gc_reg[5]  ( .D(n135), .CK(clk), .RN(n464), .QN(n249) );
  DFFRX1 \gc_reg[4]  ( .D(n134), .CK(clk), .RN(n465), .Q(gc[4]) );
  DFFRX1 \gc_reg[3]  ( .D(n133), .CK(clk), .RN(n463), .QN(n453) );
  DFFRX1 \gc_reg[2]  ( .D(n132), .CK(clk), .RN(n328), .Q(gc[2]) );
  DFFRX1 \gc_reg[1]  ( .D(n131), .CK(clk), .RN(n328), .Q(gc[1]) );
  DFFRX1 lbp_valid_reg ( .D(n175), .CK(clk), .RN(n465), .QN(n221) );
  DFFRX1 gray_req_reg ( .D(n174), .CK(clk), .RN(n464), .Q(n481), .QN(n232) );
  DFFRX1 \gray_addr_reg[0]  ( .D(n164), .CK(clk), .RN(n463), .Q(n480), .QN(
        n234) );
  DFFRX1 \gray_addr_reg[9]  ( .D(n155), .CK(clk), .RN(n464), .Q(n471), .QN(
        n236) );
  DFFRX1 \gray_addr_reg[11]  ( .D(n153), .CK(clk), .RN(n328), .Q(n469), .QN(
        n238) );
  DFFRX1 \gray_addr_reg[8]  ( .D(n156), .CK(clk), .RN(n464), .Q(n472), .QN(
        n240) );
  DFFRX1 \gray_addr_reg[10]  ( .D(n154), .CK(clk), .RN(n464), .Q(n470), .QN(
        n242) );
  DFFRX1 \state_reg[0]  ( .D(nstate[0]), .CK(clk), .RN(n465), .Q(state[0]), 
        .QN(n251) );
  DFFRX1 \state_reg[1]  ( .D(nstate[1]), .CK(clk), .RN(n465), .Q(state[1]), 
        .QN(n449) );
  DFFRX1 \lbp_addr_reg[9]  ( .D(n143), .CK(clk), .RN(n463), .Q(n485), .QN(n454) );
  DFFRX1 \lbp_addr_reg[13]  ( .D(n139), .CK(clk), .RN(n464), .Q(n482), .QN(
        n458) );
  DFFRX1 \lbp_addr_reg[12]  ( .D(n140), .CK(clk), .RN(n463), .Q(n483), .QN(
        n456) );
  DFFRX1 \lbp_addr_reg[10]  ( .D(n142), .CK(clk), .RN(n463), .Q(n484), .QN(
        n457) );
  DFFRX1 \lbp_addr_reg[6]  ( .D(n145), .CK(clk), .RN(n463), .Q(n486), .QN(n459) );
  DFFRX1 \lbp_addr_reg[5]  ( .D(n146), .CK(clk), .RN(n463), .Q(n487), .QN(n451) );
  DFFRX1 \lbp_data_reg[7]  ( .D(n173), .CK(clk), .RN(n465), .Q(n490), .QN(n229) );
  DFFRX1 \lbp_data_reg[1]  ( .D(n167), .CK(clk), .RN(n465), .Q(n493), .QN(n227) );
  DFFRX1 \lbp_data_reg[3]  ( .D(n169), .CK(clk), .RN(n465), .Q(n492), .QN(n225) );
  DFFRX1 \lbp_data_reg[5]  ( .D(n171), .CK(clk), .RN(n465), .Q(n491), .QN(n223) );
  DFFRX1 \lbp_addr_reg[0]  ( .D(n150), .CK(clk), .RN(n463), .Q(n489), .QN(n219) );
  DFFRX1 \gray_addr_reg[12]  ( .D(n152), .CK(clk), .RN(n465), .Q(n468), .QN(
        n217) );
  DFFRX1 \gray_addr_reg[6]  ( .D(n158), .CK(clk), .RN(n464), .Q(n474), .QN(
        n215) );
  DFFRX1 \gray_addr_reg[7]  ( .D(n157), .CK(clk), .RN(n464), .Q(n473), .QN(
        n213) );
  DFFRX1 \gray_addr_reg[5]  ( .D(n159), .CK(clk), .RN(n464), .Q(n475), .QN(
        n211) );
  DFFRX1 \gray_addr_reg[4]  ( .D(n160), .CK(clk), .RN(n464), .Q(n476), .QN(
        n209) );
  DFFRX1 \gray_addr_reg[13]  ( .D(n165), .CK(clk), .RN(n464), .Q(n467), .QN(
        n207) );
  DFFRX1 \gray_addr_reg[3]  ( .D(n161), .CK(clk), .RN(n464), .Q(n477), .QN(
        n205) );
  DFFRX1 \gray_addr_reg[2]  ( .D(n162), .CK(clk), .RN(n464), .Q(n478), .QN(
        n203) );
  DFFRX1 \lbp_addr_reg[3]  ( .D(n148), .CK(clk), .RN(n463), .Q(n488), .QN(n461) );
  DFFSX1 \gray_addr_reg[1]  ( .D(n250), .CK(clk), .SN(n464), .Q(n200), .QN(
        n479) );
  DFFRX1 \lbp_addr_reg[11]  ( .D(n141), .CK(clk), .RN(n463), .QN(n452) );
  DFFRX1 \lbp_addr_reg[8]  ( .D(n144), .CK(clk), .RN(n463), .QN(n455) );
  DFFRX1 \lbp_addr_reg[1]  ( .D(n151), .CK(clk), .RN(n463), .QN(n446) );
  DFFRX1 \lbp_data_reg[6]  ( .D(n172), .CK(clk), .RN(n465), .QN(n186) );
  DFFRX1 \lbp_data_reg[4]  ( .D(n170), .CK(clk), .RN(n465), .QN(n185) );
  DFFRX1 \lbp_data_reg[2]  ( .D(n168), .CK(clk), .RN(n465), .QN(n187) );
  DFFRX1 \lbp_data_reg[0]  ( .D(n166), .CK(clk), .RN(n464), .QN(n184) );
  DFFRX1 \lbp_addr_reg[7]  ( .D(n445), .CK(clk), .RN(n465), .Q(n447) );
  DFFRX1 \lbp_addr_reg[4]  ( .D(n147), .CK(clk), .RN(n463), .QN(n460) );
  DFFRX1 \lbp_addr_reg[2]  ( .D(n149), .CK(clk), .RN(n463), .QN(n462) );
  DFFRX1 \state_reg[3]  ( .D(nstate[3]), .CK(clk), .RN(n465), .Q(state[3]), 
        .QN(n448) );
  DFFRX2 \state_reg[2]  ( .D(nstate[2]), .CK(clk), .RN(n465), .Q(state[2]), 
        .QN(n450) );
  OR2X1 U190 ( .A(n341), .B(n364), .Y(n321) );
  OR2X1 U191 ( .A(n362), .B(n309), .Y(n364) );
  OAI21XL U192 ( .A0(n338), .A1(n351), .B0(n444), .Y(n283) );
  INVXL U193 ( .A(n351), .Y(n253) );
  ADDFX2 U194 ( .A(n426), .B(lbp_addr[1]), .CI(n287), .CO(n425), .S(n268) );
  NAND2XL U195 ( .A(n434), .B(n288), .Y(n291) );
  NAND2XL U196 ( .A(n434), .B(n302), .Y(n305) );
  INVX3 U197 ( .A(n342), .Y(n381) );
  AO21X1 U198 ( .A0(n336), .A1(n434), .B0(n335), .Y(n165) );
  OAI211X1 U199 ( .A0(n350), .A1(n292), .B0(n291), .C0(n290), .Y(n152) );
  OAI211X1 U200 ( .A0(n350), .A1(n299), .B0(n298), .C0(n297), .Y(n154) );
  NAND2X1 U201 ( .A(n434), .B(n295), .Y(n298) );
  ADDFX2 U202 ( .A(n252), .B(lbp_addr[11]), .CI(n382), .CO(n329), .S(n387) );
  ADDFHX1 U203 ( .A(n252), .B(lbp_addr[8]), .CI(n301), .CO(n388), .S(n302) );
  ADDFX1 U204 ( .A(n426), .B(lbp_addr[2]), .CI(n425), .CO(n419), .S(n435) );
  AO21X1 U205 ( .A0(n280), .A1(n434), .B0(n279), .Y(n164) );
  INVX1 U206 ( .A(n352), .Y(n363) );
  NOR2X1 U207 ( .A(n345), .B(n341), .Y(n271) );
  NAND4BX2 U208 ( .AN(n256), .B(n255), .C(n284), .D(n444), .Y(n252) );
  NAND2X1 U209 ( .A(n255), .B(n254), .Y(n257) );
  INVX2 U210 ( .A(n350), .Y(n427) );
  NAND2X1 U211 ( .A(n261), .B(n282), .Y(n255) );
  INVX1 U212 ( .A(n188), .Y(n189) );
  NAND2X1 U213 ( .A(n261), .B(n346), .Y(n284) );
  INVX1 U214 ( .A(n282), .Y(n339) );
  INVX1 U215 ( .A(n343), .Y(n188) );
  CLKBUFX3 U216 ( .A(n269), .Y(n183) );
  INVX1 U217 ( .A(n438), .Y(n261) );
  OR2X2 U218 ( .A(gray_ready), .B(n481), .Y(n174) );
  INVX1 U219 ( .A(gray_data[4]), .Y(n440) );
  INVX1 U220 ( .A(gray_data[6]), .Y(n376) );
  INVX1 U221 ( .A(gray_data[2]), .Y(n442) );
  INVX2 U222 ( .A(gray_data[1]), .Y(n443) );
  ADDFX2 U223 ( .A(n252), .B(n485), .CI(n388), .CO(n294), .S(n393) );
  NAND2XL U224 ( .A(n253), .B(n346), .Y(n254) );
  OAI211XL U225 ( .A0(n351), .A1(n339), .B0(n285), .C0(n284), .Y(n286) );
  XOR2X1 U226 ( .A(n252), .B(n482), .Y(n330) );
  NAND2XL U227 ( .A(n332), .B(n427), .Y(n334) );
  ADDHXL U228 ( .A(lbp_addr[7]), .B(n281), .CO(n300), .S(n396) );
  NOR2XL U229 ( .A(n364), .B(n452), .Y(n358) );
  NOR4X1 U230 ( .A(n489), .B(n451), .C(n446), .D(n270), .Y(n345) );
  NAND2X1 U231 ( .A(lbp_addr[7]), .B(lbp_addr[8]), .Y(n362) );
  CLKBUFX3 U232 ( .A(n271), .Y(n367) );
  ADDHXL U233 ( .A(lbp_addr[8]), .B(n300), .CO(n324), .S(n354) );
  ADDHXL U234 ( .A(lbp_addr[11]), .B(n320), .CO(n307), .S(n383) );
  INVXL U235 ( .A(n338), .Y(n260) );
  XOR2X1 U236 ( .A(n252), .B(n258), .Y(n275) );
  BUFX2 U237 ( .A(n264), .Y(n429) );
  INVXL U238 ( .A(n183), .Y(n263) );
  BUFX2 U239 ( .A(n259), .Y(n434) );
  NAND2X2 U240 ( .A(n183), .B(n439), .Y(n444) );
  NAND2XL U241 ( .A(n349), .B(n188), .Y(n436) );
  INVX16 U242 ( .A(n462), .Y(lbp_addr[2]) );
  INVX16 U243 ( .A(n447), .Y(lbp_addr[7]) );
  INVXL U244 ( .A(n274), .Y(n445) );
  OAI211XL U245 ( .A0(lbp_addr[7]), .A1(n352), .B0(n273), .C0(n272), .Y(n274)
         );
  NAND2XL U246 ( .A(n396), .B(n367), .Y(n273) );
  OAI211XL U247 ( .A0(n370), .A1(n455), .B0(n356), .C0(n355), .Y(n144) );
  NAND2XL U248 ( .A(n353), .B(n363), .Y(n356) );
  NAND2XL U249 ( .A(n367), .B(n354), .Y(n355) );
  XOR2X1 U250 ( .A(lbp_addr[7]), .B(lbp_addr[8]), .Y(n353) );
  NAND2XL U251 ( .A(n321), .B(lbp_addr[11]), .Y(n322) );
  NAND2XL U252 ( .A(n414), .B(n427), .Y(n416) );
  NAND2XL U253 ( .A(n408), .B(n427), .Y(n410) );
  NAND2XL U254 ( .A(n402), .B(n427), .Y(n404) );
  INVXL U255 ( .A(n357), .Y(n292) );
  XNOR2X1 U256 ( .A(n341), .B(n489), .Y(n150) );
  OAI211XL U257 ( .A0(n370), .A1(n457), .B0(n369), .C0(n368), .Y(n142) );
  NAND2XL U258 ( .A(n367), .B(n366), .Y(n368) );
  NOR2XL U259 ( .A(n362), .B(n454), .Y(n365) );
  OAI211XL U260 ( .A0(n370), .A1(n456), .B0(n361), .C0(n360), .Y(n140) );
  NAND2XL U261 ( .A(n359), .B(n363), .Y(n360) );
  NAND2XL U262 ( .A(n367), .B(n357), .Y(n361) );
  XOR2X1 U263 ( .A(n483), .B(n358), .Y(n359) );
  OAI2BB1XL U264 ( .A0N(n312), .A1N(n345), .B0(n370), .Y(n310) );
  NAND3XL U265 ( .A(n351), .B(n436), .C(n350), .Y(nstate[3]) );
  NAND2XL U266 ( .A(n344), .B(n189), .Y(nstate[0]) );
  INVXL U267 ( .A(n366), .Y(n299) );
  OAI211XL U268 ( .A0(n350), .A1(n306), .B0(n305), .C0(n304), .Y(n156) );
  INVXL U269 ( .A(n354), .Y(n306) );
  XOR2X1 U270 ( .A(n331), .B(n330), .Y(n336) );
  ADDFX2 U271 ( .A(n252), .B(n483), .CI(n329), .CO(n331), .S(n288) );
  CLKXOR2X2 U272 ( .A(n252), .B(n257), .Y(n426) );
  NAND2X2 U273 ( .A(n438), .B(n351), .Y(n342) );
  INVX12 U274 ( .A(n184), .Y(lbp_data[0]) );
  INVX16 U275 ( .A(n187), .Y(lbp_data[2]) );
  INVX16 U276 ( .A(n185), .Y(lbp_data[4]) );
  INVX16 U277 ( .A(n186), .Y(lbp_data[6]) );
  INVX16 U278 ( .A(n446), .Y(lbp_addr[1]) );
  INVX16 U279 ( .A(n460), .Y(lbp_addr[4]) );
  INVX16 U280 ( .A(n455), .Y(lbp_addr[8]) );
  INVX16 U281 ( .A(n452), .Y(lbp_addr[11]) );
  OAI211XL U282 ( .A0(n432), .A1(n458), .B0(n334), .C0(n333), .Y(n335) );
  OAI211XL U283 ( .A0(n432), .A1(n462), .B0(n431), .C0(n430), .Y(n433) );
  OAI211XL U284 ( .A0(n432), .A1(n461), .B0(n422), .C0(n421), .Y(n423) );
  OAI211XL U285 ( .A0(n432), .A1(n460), .B0(n416), .C0(n415), .Y(n417) );
  OAI211XL U286 ( .A0(n432), .A1(n451), .B0(n410), .C0(n409), .Y(n411) );
  OAI211XL U287 ( .A0(n432), .A1(n459), .B0(n404), .C0(n403), .Y(n405) );
  OAI211XL U288 ( .A0(n432), .A1(n447), .B0(n398), .C0(n397), .Y(n399) );
  OAI211XL U289 ( .A0(n432), .A1(n454), .B0(n391), .C0(n390), .Y(n392) );
  OAI211XL U290 ( .A0(n432), .A1(n452), .B0(n385), .C0(n384), .Y(n386) );
  NAND2XL U291 ( .A(n389), .B(n427), .Y(n391) );
  NAND2XL U292 ( .A(n383), .B(n427), .Y(n385) );
  INVX12 U293 ( .A(n200), .Y(gray_addr[1]) );
  INVX12 U294 ( .A(n461), .Y(lbp_addr[3]) );
  ADDFXL U295 ( .A(n426), .B(n488), .CI(n419), .CO(n413), .S(n424) );
  INVX12 U296 ( .A(n203), .Y(gray_addr[2]) );
  NAND2XL U297 ( .A(n429), .B(n478), .Y(n430) );
  INVX12 U298 ( .A(n205), .Y(gray_addr[3]) );
  NAND2XL U299 ( .A(n429), .B(n477), .Y(n421) );
  INVX12 U300 ( .A(n207), .Y(gray_addr[13]) );
  NAND2XL U301 ( .A(n467), .B(n429), .Y(n333) );
  INVX12 U302 ( .A(n209), .Y(gray_addr[4]) );
  NAND2XL U303 ( .A(n429), .B(n476), .Y(n415) );
  INVX12 U304 ( .A(n211), .Y(gray_addr[5]) );
  NAND2XL U305 ( .A(n429), .B(n475), .Y(n409) );
  INVX12 U306 ( .A(n213), .Y(gray_addr[7]) );
  NAND2XL U307 ( .A(n429), .B(n473), .Y(n397) );
  INVX12 U308 ( .A(n215), .Y(gray_addr[6]) );
  NAND2XL U309 ( .A(n429), .B(n474), .Y(n403) );
  INVX12 U310 ( .A(n217), .Y(gray_addr[12]) );
  NAND2XL U311 ( .A(n468), .B(n429), .Y(n289) );
  INVX12 U312 ( .A(n219), .Y(lbp_addr[0]) );
  NAND2XL U313 ( .A(n276), .B(n489), .Y(n277) );
  OAI211XL U314 ( .A0(n489), .A1(n350), .B0(n278), .C0(n277), .Y(n279) );
  INVX12 U315 ( .A(n221), .Y(lbp_valid) );
  INVX12 U316 ( .A(n223), .Y(lbp_data[5]) );
  INVX12 U317 ( .A(n225), .Y(lbp_data[3]) );
  INVX12 U318 ( .A(n227), .Y(lbp_data[1]) );
  INVX12 U319 ( .A(n229), .Y(lbp_data[7]) );
  INVX12 U320 ( .A(n451), .Y(lbp_addr[5]) );
  ADDHXL U321 ( .A(n487), .B(n318), .CO(n319), .S(n408) );
  ADDFXL U322 ( .A(n426), .B(n487), .CI(n407), .CO(n401), .S(n412) );
  INVX12 U323 ( .A(n232), .Y(gray_req) );
  INVX12 U324 ( .A(n234), .Y(gray_addr[0]) );
  NAND2XL U325 ( .A(n429), .B(n480), .Y(n278) );
  INVX12 U326 ( .A(n236), .Y(gray_addr[9]) );
  NAND2XL U327 ( .A(n429), .B(n471), .Y(n390) );
  INVX12 U328 ( .A(n238), .Y(gray_addr[11]) );
  NAND2XL U329 ( .A(n429), .B(n469), .Y(n384) );
  INVX12 U330 ( .A(n240), .Y(gray_addr[8]) );
  NAND2XL U331 ( .A(n429), .B(n472), .Y(n303) );
  INVX12 U332 ( .A(n242), .Y(gray_addr[10]) );
  NAND2XL U333 ( .A(n429), .B(n470), .Y(n296) );
  INVX12 U334 ( .A(n459), .Y(lbp_addr[6]) );
  ADDHXL U335 ( .A(n486), .B(n319), .CO(n281), .S(n402) );
  NAND4XL U336 ( .A(lbp_addr[4]), .B(n486), .C(n488), .D(lbp_addr[2]), .Y(n270) );
  INVX12 U337 ( .A(n457), .Y(lbp_addr[10]) );
  OAI211XL U338 ( .A0(n484), .A1(n365), .B0(n364), .C0(n363), .Y(n369) );
  ADDHXL U339 ( .A(n484), .B(n293), .CO(n320), .S(n366) );
  ADDFXL U340 ( .A(n252), .B(n484), .CI(n294), .CO(n382), .S(n295) );
  INVX12 U341 ( .A(n456), .Y(lbp_addr[12]) );
  ADDHXL U342 ( .A(n483), .B(n307), .CO(n308), .S(n357) );
  NAND2XL U343 ( .A(n483), .B(n358), .Y(n312) );
  NAND4XL U344 ( .A(n484), .B(n345), .C(n483), .D(n447), .Y(n347) );
  INVX12 U345 ( .A(n458), .Y(lbp_addr[13]) );
  OAI31XL U346 ( .A0(n482), .A1(n352), .A2(n312), .B0(n311), .Y(n313) );
  NAND2XL U347 ( .A(n310), .B(n482), .Y(n311) );
  INVX12 U348 ( .A(n454), .Y(lbp_addr[9]) );
  ADDHXL U349 ( .A(n485), .B(n324), .CO(n293), .S(n389) );
  NAND2XL U350 ( .A(n484), .B(n485), .Y(n309) );
  NAND4XL U351 ( .A(n482), .B(lbp_addr[8]), .C(n485), .D(lbp_addr[11]), .Y(
        n348) );
  AOI21XL U352 ( .A0(n268), .A1(n434), .B0(n267), .Y(n250) );
  OAI21XL U353 ( .A0(gc[1]), .A1(n443), .B0(gc[0]), .Y(n371) );
  OAI2BB2XL U354 ( .B0(gray_data[0]), .B1(n371), .A0N(gc[1]), .A1N(n443), .Y(
        n372) );
  INVXL U355 ( .A(n283), .Y(n285) );
  NAND2XL U356 ( .A(n429), .B(n479), .Y(n265) );
  NAND2XL U357 ( .A(lbp_addr[7]), .B(n341), .Y(n272) );
  NAND2XL U358 ( .A(n396), .B(n427), .Y(n398) );
  NAND2XL U359 ( .A(n325), .B(n485), .Y(n326) );
  ADDFXL U360 ( .A(n395), .B(lbp_addr[7]), .CI(n394), .CO(n301), .S(n400) );
  NOR2XL U361 ( .A(n339), .B(n189), .Y(n340) );
  NAND2X1 U362 ( .A(n448), .B(state[2]), .Y(n438) );
  NAND2X1 U363 ( .A(n251), .B(state[1]), .Y(n338) );
  NOR2X1 U364 ( .A(n438), .B(n338), .Y(n256) );
  NOR2X1 U365 ( .A(state[1]), .B(n251), .Y(n282) );
  NOR2X1 U366 ( .A(state[1]), .B(state[0]), .Y(n346) );
  NOR2X1 U367 ( .A(state[3]), .B(state[2]), .Y(n269) );
  NOR2X2 U368 ( .A(n449), .B(n251), .Y(n439) );
  NAND2X1 U369 ( .A(n450), .B(state[3]), .Y(n351) );
  OR3X2 U370 ( .A(n257), .B(n256), .C(n283), .Y(n258) );
  OAI21XL U371 ( .A0(n439), .A1(n381), .B0(n444), .Y(n259) );
  NAND2X2 U372 ( .A(n260), .B(n183), .Y(n432) );
  NAND2X1 U373 ( .A(n261), .B(n439), .Y(n350) );
  NAND2XL U374 ( .A(n314), .B(n427), .Y(n266) );
  OAI21XL U375 ( .A0(state[2]), .A1(n439), .B0(state[3]), .Y(n262) );
  OAI21XL U376 ( .A0(n263), .A1(state[1]), .B0(n262), .Y(n264) );
  OAI211XL U377 ( .A0(n432), .A1(n446), .B0(n266), .C0(n265), .Y(n267) );
  NAND2X2 U378 ( .A(n183), .B(n282), .Y(n341) );
  CLKINVX1 U379 ( .A(n341), .Y(n370) );
  NAND2X1 U380 ( .A(n370), .B(n345), .Y(n352) );
  ADDHXL U381 ( .A(lbp_addr[1]), .B(n489), .CO(n316), .S(n314) );
  ADDFXL U382 ( .A(n489), .B(n252), .CI(n275), .CO(n287), .S(n280) );
  INVXL U383 ( .A(n432), .Y(n276) );
  XOR2X1 U384 ( .A(n252), .B(n286), .Y(n395) );
  OA21XL U385 ( .A0(n432), .A1(n456), .B0(n289), .Y(n290) );
  OA21XL U386 ( .A0(n432), .A1(n457), .B0(n296), .Y(n297) );
  OA21XL U387 ( .A0(n432), .A1(n455), .B0(n303), .Y(n304) );
  AOI2BB2X1 U388 ( .B0(n308), .B1(n482), .A0N(n308), .A1N(n482), .Y(n332) );
  AO21X1 U389 ( .A0(n332), .A1(n367), .B0(n313), .Y(n139) );
  OA22X1 U390 ( .A0(n381), .A1(n493), .B0(n342), .B1(lbp_data[0]), .Y(n166) );
  AO22X1 U391 ( .A0(n367), .A1(n314), .B0(lbp_addr[1]), .B1(n341), .Y(n151) );
  ADDHXL U392 ( .A(n488), .B(n315), .CO(n317), .S(n420) );
  AO22X1 U393 ( .A0(n367), .A1(n420), .B0(n488), .B1(n341), .Y(n148) );
  ADDHXL U394 ( .A(lbp_addr[2]), .B(n316), .CO(n315), .S(n428) );
  AO22X1 U395 ( .A0(n367), .A1(n428), .B0(lbp_addr[2]), .B1(n341), .Y(n149) );
  ADDHXL U396 ( .A(lbp_addr[4]), .B(n317), .CO(n318), .S(n414) );
  AO22X1 U397 ( .A0(n414), .A1(n367), .B0(lbp_addr[4]), .B1(n341), .Y(n147) );
  AO22X1 U398 ( .A0(n408), .A1(n367), .B0(n487), .B1(n341), .Y(n146) );
  AO22X1 U399 ( .A0(n402), .A1(n367), .B0(n486), .B1(n341), .Y(n145) );
  AO22X1 U400 ( .A0(n342), .A1(n491), .B0(n381), .B1(lbp_data[4]), .Y(n170) );
  AO22X1 U401 ( .A0(n342), .A1(n490), .B0(n381), .B1(lbp_data[6]), .Y(n172) );
  AO22X1 U402 ( .A0(n342), .A1(n492), .B0(n381), .B1(lbp_data[2]), .Y(n168) );
  AO22X1 U403 ( .A0(n342), .A1(lbp_data[4]), .B0(n381), .B1(n492), .Y(n169) );
  AO22X1 U404 ( .A0(n342), .A1(lbp_data[6]), .B0(n381), .B1(n491), .Y(n171) );
  AO22X1 U405 ( .A0(n342), .A1(lbp_data[2]), .B0(n381), .B1(n493), .Y(n167) );
  OAI31XL U406 ( .A0(n352), .A1(lbp_addr[11]), .A2(n364), .B0(n322), .Y(n323)
         );
  AO21X1 U407 ( .A0(n383), .A1(n367), .B0(n323), .Y(n141) );
  NAND2BX1 U408 ( .AN(n362), .B(n370), .Y(n325) );
  OAI31XL U409 ( .A0(n352), .A1(n485), .A2(n362), .B0(n326), .Y(n327) );
  AO21X1 U410 ( .A0(n389), .A1(n367), .B0(n327), .Y(n143) );
  INVX1 U411 ( .A(reset), .Y(n328) );
  CLKBUFX3 U412 ( .A(n328), .Y(n463) );
  CLKBUFX3 U413 ( .A(n328), .Y(n464) );
  CLKBUFX3 U414 ( .A(n328), .Y(n465) );
  NAND2XL U415 ( .A(state[3]), .B(state[2]), .Y(n343) );
  INVXL U416 ( .A(n346), .Y(n337) );
  NOR2XL U417 ( .A(n189), .B(n337), .Y(n175) );
  AOI21XL U418 ( .A0(n339), .A1(n338), .B0(n188), .Y(nstate[1]) );
  BUFX12 U419 ( .A(n340), .Y(finish) );
  OAI31XL U420 ( .A0(state[1]), .A1(gray_ready), .A2(n342), .B0(n251), .Y(n344) );
  OAI21XL U421 ( .A0(n348), .A1(n347), .B0(n346), .Y(n349) );
  AOI222X1 U422 ( .A0(gc[2]), .A1(n372), .B0(gc[2]), .B1(n442), .C0(n372), 
        .C1(n442), .Y(n373) );
  AOI222X1 U423 ( .A0(gray_data[3]), .A1(n373), .B0(gray_data[3]), .B1(n453), 
        .C0(n373), .C1(n453), .Y(n374) );
  AOI222X1 U424 ( .A0(gc[4]), .A1(n374), .B0(gc[4]), .B1(n440), .C0(n374), 
        .C1(n440), .Y(n375) );
  AOI222X1 U425 ( .A0(gray_data[5]), .A1(n375), .B0(gray_data[5]), .B1(n249), 
        .C0(n375), .C1(n249), .Y(n377) );
  AOI222X1 U426 ( .A0(gc[6]), .A1(n377), .B0(gc[6]), .B1(n376), .C0(n377), 
        .C1(n376), .Y(n379) );
  OAI2BB1X1 U427 ( .A0N(gray_data[7]), .A1N(n379), .B0(gc[7]), .Y(n378) );
  OAI21X1 U428 ( .A0(gray_data[7]), .A1(n379), .B0(n378), .Y(n380) );
  OAI2BB2X1 U429 ( .B0(n381), .B1(n380), .A0N(n381), .A1N(n490), .Y(n173) );
  AO21X1 U430 ( .A0(n387), .A1(n434), .B0(n386), .Y(n153) );
  AO21X1 U431 ( .A0(n393), .A1(n434), .B0(n392), .Y(n155) );
  AO21X1 U432 ( .A0(n400), .A1(n434), .B0(n399), .Y(n157) );
  ADDFXL U433 ( .A(n426), .B(n486), .CI(n401), .CO(n394), .S(n406) );
  AO21X1 U434 ( .A0(n406), .A1(n434), .B0(n405), .Y(n158) );
  AO21X1 U435 ( .A0(n412), .A1(n434), .B0(n411), .Y(n159) );
  ADDFXL U436 ( .A(n426), .B(lbp_addr[4]), .CI(n413), .CO(n407), .S(n418) );
  AO21X1 U437 ( .A0(n418), .A1(n434), .B0(n417), .Y(n160) );
  NAND2XL U438 ( .A(n420), .B(n427), .Y(n422) );
  AO21X1 U439 ( .A0(n424), .A1(n434), .B0(n423), .Y(n161) );
  NAND2XL U440 ( .A(n428), .B(n427), .Y(n431) );
  AO21X1 U441 ( .A0(n435), .A1(n434), .B0(n433), .Y(n162) );
  INVXL U442 ( .A(n439), .Y(n437) );
  OAI221XL U443 ( .A0(n439), .A1(n438), .B0(n437), .B1(state[2]), .C0(n436), 
        .Y(nstate[2]) );
  CLKINVX1 U444 ( .A(n444), .Y(n441) );
  AO22X1 U445 ( .A0(n441), .A1(gray_data[0]), .B0(n444), .B1(gc[0]), .Y(n138)
         );
  AO22X1 U446 ( .A0(n441), .A1(gray_data[7]), .B0(n444), .B1(gc[7]), .Y(n137)
         );
  OA22X1 U447 ( .A0(n444), .A1(gray_data[6]), .B0(n441), .B1(gc[6]), .Y(n136)
         );
  OAI2BB2XL U448 ( .B0(n441), .B1(n249), .A0N(n441), .A1N(gray_data[5]), .Y(
        n135) );
  OAI2BB2XL U449 ( .B0(n444), .B1(n440), .A0N(n444), .A1N(gc[4]), .Y(n134) );
  OAI2BB2XL U450 ( .B0(n441), .B1(n453), .A0N(n441), .A1N(gray_data[3]), .Y(
        n133) );
  OAI2BB2XL U451 ( .B0(n444), .B1(n442), .A0N(n444), .A1N(gc[2]), .Y(n132) );
  OAI2BB2XL U452 ( .B0(n444), .B1(n443), .A0N(n444), .A1N(gc[1]), .Y(n131) );
endmodule

