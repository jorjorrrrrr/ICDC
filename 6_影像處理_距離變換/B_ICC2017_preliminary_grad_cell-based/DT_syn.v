/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : T-2022.03
// Date      : Wed Jan  4 10:48:29 2023
/////////////////////////////////////////////////////////////


module DT_DW01_inc_0_DW01_inc_1 ( A, SUM );
  input [9:0] A;
  output [9:0] SUM;

  wire   [9:2] carry;

  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2X1 U1 ( .A(carry[9]), .B(A[9]), .Y(SUM[9]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module DT_DW01_inc_1_DW01_inc_2 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  XOR2X1 U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module DT_DW01_inc_2_DW01_inc_3 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INVXL U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2XL U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
endmodule


module DT_DW01_inc_3_DW01_inc_4 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;

  wire   [13:2] carry;

  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  CLKINVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[13]), .B(A[13]), .Y(SUM[13]) );
endmodule


module DT_DW01_dec_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16;

  CLKINVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKINVX1 U2 ( .A(n16), .Y(n2) );
  CLKINVX1 U3 ( .A(A[10]), .Y(n4) );
  CLKINVX1 U4 ( .A(A[11]), .Y(n3) );
  AO21X1 U5 ( .A0(n5), .A1(A[9]), .B0(n6), .Y(SUM[9]) );
  OAI2BB1X1 U6 ( .A0N(n7), .A1N(A[8]), .B0(n5), .Y(SUM[8]) );
  OAI2BB1X1 U7 ( .A0N(n8), .A1N(A[7]), .B0(n7), .Y(SUM[7]) );
  OAI2BB1X1 U8 ( .A0N(n9), .A1N(A[6]), .B0(n8), .Y(SUM[6]) );
  OAI2BB1X1 U9 ( .A0N(n10), .A1N(A[5]), .B0(n9), .Y(SUM[5]) );
  OAI2BB1X1 U10 ( .A0N(n11), .A1N(A[4]), .B0(n10), .Y(SUM[4]) );
  OAI2BB1X1 U11 ( .A0N(n12), .A1N(A[3]), .B0(n11), .Y(SUM[3]) );
  OAI2BB1X1 U12 ( .A0N(n13), .A1N(A[2]), .B0(n12), .Y(SUM[2]) );
  OAI2BB1X1 U13 ( .A0N(A[0]), .A1N(A[1]), .B0(n13), .Y(SUM[1]) );
  XOR2X1 U14 ( .A(A[13]), .B(n14), .Y(SUM[13]) );
  NOR2X1 U15 ( .A(A[12]), .B(n15), .Y(n14) );
  XNOR2X1 U16 ( .A(A[12]), .B(n15), .Y(SUM[12]) );
  OAI21XL U17 ( .A0(n2), .A1(n3), .B0(n15), .Y(SUM[11]) );
  NAND2X1 U18 ( .A(n2), .B(n3), .Y(n15) );
  OAI21XL U19 ( .A0(n6), .A1(n4), .B0(n16), .Y(SUM[10]) );
  NAND2X1 U20 ( .A(n6), .B(n4), .Y(n16) );
  NOR2X1 U21 ( .A(n5), .B(A[9]), .Y(n6) );
  OR2X1 U22 ( .A(n7), .B(A[8]), .Y(n5) );
  OR2X1 U23 ( .A(n8), .B(A[7]), .Y(n7) );
  OR2X1 U24 ( .A(n9), .B(A[6]), .Y(n8) );
  OR2X1 U25 ( .A(n10), .B(A[5]), .Y(n9) );
  OR2X1 U26 ( .A(n11), .B(A[4]), .Y(n10) );
  OR2X1 U27 ( .A(n12), .B(A[3]), .Y(n11) );
  OR2X1 U28 ( .A(n13), .B(A[2]), .Y(n12) );
  NAND2BX1 U29 ( .AN(A[1]), .B(SUM[0]), .Y(n13) );
endmodule


module DT ( clk, reset, done, sti_rd, sti_addr, sti_di, res_wr, res_rd, 
        res_addr, res_do, res_di );
  output [9:0] sti_addr;
  input [15:0] sti_di;
  output [13:0] res_addr;
  output [7:0] res_do;
  input [7:0] res_di;
  input clk, reset;
  output done, sti_rd, res_wr, res_rd;
  wire   n668, n669, n670, n671, n672, N76, N78, N80, N82, N83, N84, N85, N86,
         N87, N88, N89, N90, N91, N92, N93, N94, N95, N96, N97, N98, N105,
         N106, N107, N108, N109, N110, N111, N112, N113, N114, N119, N207,
         N208, N209, N210, N211, N212, N213, N214, N215, N216, N217, N218,
         N219, N221, N222, N223, N224, N225, N226, N228, N229, N230, N231,
         N232, N233, N235, N236, N237, N238, N239, N240, N241, N242, N243,
         N244, N245, N246, N247, N248, N249, N250, N251, N252, N253, N254,
         N255, N256, N257, N258, N259, N260, N261, N262, N263, N264, N265,
         N266, N267, N268, N269, N270, N271, N272, N273, N274, N275, N277,
         N278, N279, N280, N281, N282, N283, N284, N285, N286, N287, N288,
         N289, N298, N299, N300, N301, N302, N303, N305, N306, N307, N308,
         N309, N310, N311, N312, N313, N314, N315, N316, N317, N336, N337,
         N338, N339, N340, N341, N342, N343, N344, N345, N346, N347, N348,
         N379, N380, N381, N382, N383, N384, N385, N386, N387, N388, N389,
         N390, N391, N505, N687, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n48, n49, n51, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n66, n67, n68, n69, n70, n72, n73, n75, n78, n81, n82, n83, n84,
         n85, n86, n88, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n102, n103, n104, n105, n108, n109, n110, n111, n114, n115, n116,
         n117, n120, n121, n122, n123, n126, n127, n128, n129, n132, n133,
         n134, n135, n137, n138, n139, n140, n142, n143, n144, n145, n147,
         n149, n150, n151, n152, n153, n155, n157, n159, n161, n163, n165,
         n167, n169, n171, n173, n175, n177, n179, n180, n181, n182, n183,
         n186, n189, n191, n193, n194, n195, n196, n197, n198, n200, n201,
         n202, n204, n205, n207, n208, n209, n210, n211, n212, n213, n215,
         n216, n217, n219, n220, n221, n223, n224, n225, n226, n227, n228,
         n229, n230, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245, n246, n247, n266, n276, n284, n294, n296, n297, n298,
         n299, n300, n304, n305, n309, n311, n312, n313, n314, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327,
         n328, n329, n330, n331, n332, n333, n334, n335, n336, n337, n338,
         n339, n340, n343, n345, n347, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419,
         \lt_86/A[7] , \lt_86/A[5] , \lt_86/A[4] , \lt_86/A[3] , \lt_86/A[2] ,
         \lt_86/A[1] , \lt_86/A[0] , \sub_182/carry[2] , \sub_182/carry[3] ,
         \sub_182/carry[4] , \sub_182/carry[5] , \sub_182/carry[6] ,
         \sub_182/carry[7] , \sub_182/carry[8] , \sub_182/carry[9] ,
         \sub_182/carry[10] , \sub_182/carry[11] , \sub_182/carry[12] ,
         \sub_182/carry[13] , \add_174/carry[2] , \add_174/carry[3] ,
         \add_174/carry[4] , \add_174/carry[5] , \add_174/carry[6] ,
         \add_174/carry[7] , \add_174/carry[8] , \add_174/carry[9] ,
         \add_174/carry[10] , \add_174/carry[11] , \add_174/carry[12] ,
         \add_174/carry[13] , \add_161/carry[2] , \add_161/carry[3] ,
         \add_161/carry[4] , \add_161/carry[5] , \add_161/carry[6] ,
         \add_161/carry[7] , \add_161/carry[8] , \add_161/carry[9] ,
         \add_161/carry[10] , \add_161/carry[11] , \add_161/carry[12] ,
         \add_161/carry[13] , \add_159/carry[2] , \add_159/carry[3] ,
         \add_159/carry[4] , \add_159/carry[5] , \add_159/carry[6] ,
         \add_159/carry[7] , \add_159/carry[8] , \add_159/carry[9] ,
         \add_159/carry[10] , \add_159/carry[11] , \add_159/carry[12] ,
         \add_159/carry[13] , \sub_154/carry[2] , \sub_154/carry[3] ,
         \sub_154/carry[4] , \sub_154/carry[5] , \sub_154/carry[6] ,
         \sub_154/carry[7] , \sub_154/carry[8] , \sub_154/carry[9] ,
         \sub_154/carry[10] , \sub_154/carry[11] , \sub_154/carry[12] ,
         \sub_154/carry[13] , \sub_152/carry[2] , \sub_152/carry[3] ,
         \sub_152/carry[4] , \sub_152/carry[5] , \sub_152/carry[6] ,
         \sub_152/carry[7] , \sub_152/carry[8] , \sub_152/carry[9] ,
         \sub_152/carry[10] , \sub_152/carry[11] , \sub_152/carry[12] ,
         \sub_152/carry[13] , n420, n421, n422, n423, n424, n425, n426, n427,
         n428, n429, n430, n431, n432, n433, n434, n435, n436, n437, n438,
         n439, n440, n441, n442, n443, n444, n445, n446, n447, n453, n454,
         n455, n456, n457, n458, n459, n460, n461, n462, n463, n464, n465,
         n466, n467, n468, n469, n470, n471, n472, n473, n474, n475, n476,
         n477, n478, n479, n480, n481, n482, n483, n484, n485, n486, n487,
         n488, n489, n490, n491, n492, n493, n494, n495, n496, n497, n498,
         n499, n500, n501, n502, n503, n504, n505, n506, n507, n508, n509,
         n510, n511, n512, n513, n514, n515, n516, n517, n518, n519, n520,
         n521, n522, n523, n524, n525, n526, n527, n528, n529, n530, n531,
         n532, n533, n534, n535, n536, n537, n538, n539, n540, n541, n542,
         n543, n544, n545, n546, n547, n548, n549, n550, n551, n552, n553,
         n554, n555, n556, n557, n558, n559, n560, n561, n562, n563, n564,
         n565, n566, n567, n568, n569, n570, n571, n572, n573, n574, n575,
         n576, n577, n578, n579, n580, n581, n582, n583, n584, n585, n586,
         n587, n588, n589, n590, n591, n592, n593, n594, n595, n596, n597,
         n598, n599, n600, n601, n602, n603, n604, n605, n606, n607, n608,
         n609, n610, n611, n612, n613, n614, n615, n616, n617, n618, n619,
         n620, n621, n622, n623, n624, n625, n626, n627, n628, n629, n630,
         n631, n632, n633, n634, n635, n636, n637, n638, n639, n640, n641,
         n642, n643, n644, n645, n646, n647, n648, n649, n650, n651, n652,
         n653, n654, n655, n656, n657, n658, n659, n660, n661, n662, n663,
         n664, n665, n666, n667;
  wire   [7:0] val1;
  wire   [7:0] val2;
  wire   [7:0] cmp1;
  wire   [7:0] val3;
  wire   [7:0] val4;
  wire   [7:0] cmp2;
  wire   [7:0] mid_val;
  wire   [4:0] state;
  wire   [3:0] sti_count;
  wire   [13:0] count_addr;
  wire   [4:0] nstate;
  wire   [13:1] \add_160/carry ;
  wire   [14:0] \sub_153/carry ;
  assign done = N687;

  DT_DW01_inc_0_DW01_inc_1 add_107 ( .A({sti_addr[9:8], n668, n669, n670, n671, 
        n672, sti_addr[2:0]}), .SUM({N114, N113, N112, N111, N110, N109, N108, 
        N107, N106, N105}) );
  DT_DW01_inc_1_DW01_inc_2 add_85_2 ( .A(cmp2), .SUM({N97, N96, N95, N94, N93, 
        N92, N91, N90}) );
  DT_DW01_inc_2_DW01_inc_3 add_85 ( .A(cmp1), .SUM({N89, N88, N87, N86, N85, 
        N84, N83, N82}) );
  DT_DW01_inc_3_DW01_inc_4 r429 ( .A({n453, n527, n526, n519, n520, n521, n517, 
        n522, n523, n524, n525, n528, n531, n533}), .SUM({N275, N274, N273, 
        N272, N271, N270, N269, N268, N267, N266, N265, N264, N263, N262}) );
  DT_DW01_dec_0 r428 ( .A({n453, n527, n526, n519, n520, n521, n517, n522, 
        n523, n524, n525, n528, n531, n533}), .SUM({N261, N260, N259, N258, 
        N257, N256, N255, N254, N253, N252, N251, N250, N249, N248}) );
  DFFRX1 \sti_count_reg[3]  ( .D(n314), .CK(clk), .RN(n541), .Q(sti_count[3])
         );
  DFFRX1 \sti_count_reg[2]  ( .D(n315), .CK(clk), .RN(n540), .Q(n312), .QN(
        n447) );
  DFFRX1 \sti_count_reg[1]  ( .D(n316), .CK(clk), .RN(n540), .Q(sti_count[1])
         );
  DFFRX1 \sti_count_reg[0]  ( .D(n317), .CK(clk), .RN(n540), .Q(n313) );
  DFFRX1 \state_reg[2]  ( .D(nstate[2]), .CK(clk), .RN(n535), .Q(state[2]), 
        .QN(n428) );
  DFFRX1 \state_reg[1]  ( .D(nstate[1]), .CK(clk), .RN(n535), .Q(state[1]), 
        .QN(n429) );
  DFFRX1 \state_reg[3]  ( .D(nstate[3]), .CK(clk), .RN(n535), .Q(state[3]), 
        .QN(n446) );
  DFFRX1 \val4_reg[7]  ( .D(n385), .CK(clk), .RN(n540), .QN(n443) );
  DFFRX1 \val3_reg[7]  ( .D(n393), .CK(clk), .RN(n538), .Q(val3[7]), .QN(n430)
         );
  DFFRX1 \val2_reg[7]  ( .D(n401), .CK(clk), .RN(n537), .Q(val2[7]), .QN(n445)
         );
  DFFRX1 \val3_reg[6]  ( .D(n392), .CK(clk), .RN(n538), .QN(n444) );
  DFFRX1 \val2_reg[6]  ( .D(n400), .CK(clk), .RN(n537), .Q(val2[6]), .QN(n425)
         );
  DFFRX1 \val1_reg[6]  ( .D(n408), .CK(clk), .RN(n536), .QN(n440) );
  DFFRX1 \val4_reg[5]  ( .D(n383), .CK(clk), .RN(n540), .QN(n442) );
  DFFRX1 \val4_reg[0]  ( .D(n386), .CK(clk), .RN(n540), .Q(val4[0]), .QN(n439)
         );
  DFFRX1 \val2_reg[0]  ( .D(n402), .CK(clk), .RN(n537), .Q(val2[0]), .QN(n435)
         );
  DFFRX1 \val3_reg[3]  ( .D(n389), .CK(clk), .RN(n537), .Q(val3[3]), .QN(n423)
         );
  DFFRX1 \val3_reg[0]  ( .D(n394), .CK(clk), .RN(n538), .Q(val3[0]), .QN(n427)
         );
  DFFRX1 \val4_reg[3]  ( .D(n381), .CK(clk), .RN(n540), .QN(n437) );
  DFFRX1 \val1_reg[0]  ( .D(n410), .CK(clk), .RN(n536), .Q(val1[0]), .QN(n436)
         );
  DFFRX1 \val2_reg[1]  ( .D(n395), .CK(clk), .RN(n536), .QN(n434) );
  DFFRX1 \val1_reg[1]  ( .D(n403), .CK(clk), .RN(n536), .Q(val1[1]), .QN(n433)
         );
  DFFRX1 \val2_reg[3]  ( .D(n397), .CK(clk), .RN(n537), .QN(n438) );
  DFFRX1 \val2_reg[5]  ( .D(n399), .CK(clk), .RN(n537), .QN(n441) );
  DFFRX1 \val2_reg[2]  ( .D(n396), .CK(clk), .RN(n537), .Q(val2[2]), .QN(n424)
         );
  DFFRX1 \state_reg[0]  ( .D(nstate[0]), .CK(clk), .RN(n535), .Q(state[0]), 
        .QN(n422) );
  DFFRX1 \val1_reg[2]  ( .D(n404), .CK(clk), .RN(n536), .Q(val1[2]), .QN(n432)
         );
  DFFRX1 \val3_reg[5]  ( .D(n391), .CK(clk), .RN(n537), .Q(val3[5]), .QN(n426)
         );
  DFFSX1 \count_addr_reg[7]  ( .D(n367), .CK(clk), .SN(reset), .Q(
        count_addr[7]), .QN(n334) );
  DFFRX1 \val1_reg[7]  ( .D(n409), .CK(clk), .RN(reset), .Q(val1[7]), .QN(n649) );
  DFFRX1 \mid_val_reg[7]  ( .D(n411), .CK(clk), .RN(n535), .Q(mid_val[7]), 
        .QN(n603) );
  DFFRX1 \mid_val_reg[6]  ( .D(n412), .CK(clk), .RN(n535), .Q(mid_val[6]), 
        .QN(n343) );
  DFFRX1 \mid_val_reg[4]  ( .D(n414), .CK(clk), .RN(n535), .Q(mid_val[4]), 
        .QN(n345) );
  DFFRX1 \mid_val_reg[3]  ( .D(n415), .CK(clk), .RN(n535), .QN(n601) );
  DFFRX1 \mid_val_reg[2]  ( .D(n416), .CK(clk), .RN(n536), .Q(mid_val[2]), 
        .QN(n347) );
  DFFRX1 \mid_val_reg[1]  ( .D(n417), .CK(clk), .RN(n536), .QN(n600) );
  DFFRX1 \mid_val_reg[0]  ( .D(n418), .CK(clk), .RN(n536), .Q(mid_val[0]), 
        .QN(n349) );
  DFFRX1 \val4_reg[4]  ( .D(n382), .CK(clk), .RN(n540), .Q(val4[4]), .QN(n663)
         );
  DFFRX1 \val3_reg[1]  ( .D(n387), .CK(clk), .RN(n537), .Q(val3[1]), .QN(n652)
         );
  DFFRX1 \val2_reg[4]  ( .D(n398), .CK(clk), .RN(n537), .Q(val2[4]), .QN(n650)
         );
  DFFRX1 \count_addr_reg[10]  ( .D(n364), .CK(clk), .RN(n540), .Q(
        count_addr[10]), .QN(n331) );
  DFFRX1 \count_addr_reg[9]  ( .D(n365), .CK(clk), .RN(n539), .Q(count_addr[9]), .QN(n332) );
  DFFRX1 \count_addr_reg[8]  ( .D(n366), .CK(clk), .RN(n539), .Q(count_addr[8]), .QN(n333) );
  DFFRX1 \count_addr_reg[6]  ( .D(n368), .CK(clk), .RN(n539), .Q(N226), .QN(
        n335) );
  DFFRX1 \count_addr_reg[5]  ( .D(n369), .CK(clk), .RN(n539), .Q(N225), .QN(
        n336) );
  DFFRX1 \count_addr_reg[4]  ( .D(n370), .CK(clk), .RN(n539), .Q(N224), .QN(
        n337) );
  DFFRX1 \count_addr_reg[3]  ( .D(n371), .CK(clk), .RN(n539), .Q(N223), .QN(
        n338) );
  DFFRX1 \count_addr_reg[2]  ( .D(n372), .CK(clk), .RN(n539), .Q(N222), .QN(
        n339) );
  DFFRX1 \count_addr_reg[1]  ( .D(n374), .CK(clk), .RN(n535), .Q(N221), .QN(
        n340) );
  DFFRX1 \count_addr_reg[11]  ( .D(n363), .CK(clk), .RN(n539), .Q(
        count_addr[11]), .QN(n330) );
  DFFRX1 \count_addr_reg[12]  ( .D(n362), .CK(clk), .RN(n539), .Q(
        count_addr[12]), .QN(n329) );
  DFFRX1 \sti_addr_reg[7]  ( .D(n320), .CK(clk), .RN(n538), .Q(n668), .QN(n660) );
  DFFRX1 \sti_addr_reg[6]  ( .D(n321), .CK(clk), .RN(n538), .Q(n669), .QN(n659) );
  DFFRX1 \sti_addr_reg[5]  ( .D(n322), .CK(clk), .RN(n538), .Q(n670), .QN(n658) );
  DFFRX1 \sti_addr_reg[4]  ( .D(n323), .CK(clk), .RN(n538), .Q(n671), .QN(n657) );
  DFFRX1 \sti_addr_reg[3]  ( .D(n324), .CK(clk), .RN(n538), .Q(n672), .QN(n656) );
  DFFRX1 \val4_reg[6]  ( .D(n384), .CK(clk), .RN(n540), .Q(val4[6]), .QN(n664)
         );
  DFFRX1 \val1_reg[5]  ( .D(n407), .CK(clk), .RN(n536), .Q(val1[5]), .QN(n648)
         );
  DFFRX1 \val1_reg[3]  ( .D(n405), .CK(clk), .RN(n536), .Q(val1[3]), .QN(n646)
         );
  DFFRX1 \val4_reg[2]  ( .D(n380), .CK(clk), .RN(n540), .Q(val4[2]), .QN(n662)
         );
  DFFRX1 \val3_reg[2]  ( .D(n388), .CK(clk), .RN(n537), .Q(val3[2]), .QN(n653)
         );
  DFFRX1 \val1_reg[4]  ( .D(n406), .CK(clk), .RN(n536), .Q(val1[4]), .QN(n647)
         );
  DFFRX1 \val4_reg[1]  ( .D(n379), .CK(clk), .RN(n540), .Q(val4[1]), .QN(n661)
         );
  DFFRX1 \val3_reg[4]  ( .D(n390), .CK(clk), .RN(n537), .Q(val3[4]), .QN(n654)
         );
  DFFRX1 \count_addr_reg[13]  ( .D(n361), .CK(clk), .RN(n539), .Q(n431), .QN(
        n328) );
  DFFRX4 \sti_addr_reg[0]  ( .D(n327), .CK(clk), .RN(n538), .Q(sti_addr[0]) );
  DFFRX2 \count_addr_reg[0]  ( .D(n373), .CK(clk), .RN(n535), .Q(n642), .QN(
        n534) );
  DFFRX2 \sti_addr_reg[9]  ( .D(n318), .CK(clk), .RN(n539), .Q(sti_addr[9]) );
  DFFRX2 \res_addr_reg[2]  ( .D(n376), .CK(clk), .RN(reset), .Q(res_addr[2]), 
        .QN(n665) );
  DFFRX2 \sti_addr_reg[8]  ( .D(n319), .CK(clk), .RN(n538), .Q(sti_addr[8]) );
  DFFRX2 \sti_addr_reg[1]  ( .D(n326), .CK(clk), .RN(n538), .Q(sti_addr[1]) );
  DFFRX2 \sti_addr_reg[2]  ( .D(n325), .CK(clk), .RN(n538), .Q(sti_addr[2]) );
  DFFRX2 \res_addr_reg[0]  ( .D(n378), .CK(clk), .RN(reset), .Q(res_addr[0]), 
        .QN(n666) );
  DFFRX2 \res_addr_reg[3]  ( .D(n419), .CK(clk), .RN(n541), .Q(res_addr[3]), 
        .QN(n478) );
  DFFRX2 \res_addr_reg[1]  ( .D(n377), .CK(clk), .RN(reset), .Q(res_addr[1]), 
        .QN(n667) );
  DFFRX2 \res_addr_reg[7]  ( .D(n357), .CK(clk), .RN(n541), .Q(res_addr[7]) );
  DFFRX2 \res_addr_reg[8]  ( .D(n356), .CK(clk), .RN(n541), .Q(res_addr[8]) );
  DFFRX2 \res_addr_reg[9]  ( .D(n355), .CK(clk), .RN(n541), .Q(res_addr[9]) );
  DFFRX2 \res_addr_reg[10]  ( .D(n354), .CK(clk), .RN(n541), .Q(res_addr[10])
         );
  DFFRX2 \res_addr_reg[11]  ( .D(n353), .CK(clk), .RN(n541), .Q(res_addr[11])
         );
  DFFRX2 \res_addr_reg[4]  ( .D(n360), .CK(clk), .RN(n541), .Q(res_addr[4]) );
  DFFRX2 \res_addr_reg[5]  ( .D(n359), .CK(clk), .RN(n541), .Q(res_addr[5]) );
  DFFRX2 \res_addr_reg[6]  ( .D(n358), .CK(clk), .RN(n541), .Q(res_addr[6]) );
  DFFRX2 \res_addr_reg[12]  ( .D(n352), .CK(clk), .RN(n541), .Q(res_addr[12])
         );
  DFFRX2 \res_addr_reg[13]  ( .D(n351), .CK(clk), .RN(n541), .Q(res_addr[13])
         );
  DFFRX2 res_rd_reg ( .D(n375), .CK(clk), .RN(reset), .Q(res_rd) );
  DFFRX2 \state_reg[4]  ( .D(nstate[4]), .CK(clk), .RN(n535), .Q(state[4]), 
        .QN(n643) );
  DFFRX2 res_wr_reg ( .D(N119), .CK(clk), .RN(reset), .Q(res_wr) );
  DFFRX2 sti_rd_reg ( .D(n350), .CK(clk), .RN(reset), .Q(sti_rd), .QN(n311) );
  DFFRX2 \mid_val_reg[5]  ( .D(n413), .CK(clk), .RN(n535), .QN(n602) );
  INVX3 U417 ( .A(n458), .Y(n542) );
  OAI22X1 U418 ( .A0(n575), .A1(n574), .B0(n573), .B1(n584), .Y(n578) );
  BUFX4 U419 ( .A(n43), .Y(n420) );
  OR2X2 U420 ( .A(n41), .B(n38), .Y(n462) );
  OR2X2 U421 ( .A(n44), .B(n38), .Y(n469) );
  OAI21X4 U422 ( .A0(N98), .A1(N505), .B0(n627), .Y(n38) );
  AOI22X1 U423 ( .A0(N86), .A1(n494), .B0(N94), .B1(n644), .Y(n42) );
  CLKBUFX3 U424 ( .A(n45), .Y(n421) );
  NAND3X4 U425 ( .A(n479), .B(n480), .C(n481), .Y(n556) );
  OR2X4 U426 ( .A(n442), .B(n555), .Y(n481) );
  OR2X2 U427 ( .A(val3[5]), .B(n442), .Y(n479) );
  INVX3 U428 ( .A(n44), .Y(\lt_86/A[2] ) );
  OR2X1 U429 ( .A(val1[7]), .B(n445), .Y(n459) );
  AOI2BB1X1 U430 ( .A0N(n652), .A1N(val4[1]), .B0(val3[0]), .Y(n558) );
  CLKINVX1 U431 ( .A(n473), .Y(n555) );
  NOR2BX1 U432 ( .AN(n647), .B(n650), .Y(n458) );
  NOR2BX2 U433 ( .AN(cmp1[2]), .B(cmp2[2]), .Y(n571) );
  INVX1 U434 ( .A(cmp2[3]), .Y(n584) );
  NAND2BX1 U435 ( .AN(cmp1[2]), .B(cmp2[2]), .Y(n573) );
  OAI21X2 U436 ( .A0(val3[7]), .A1(n443), .B0(n568), .Y(N78) );
  OR2X1 U437 ( .A(cmp1[5]), .B(n569), .Y(n483) );
  OR2X1 U438 ( .A(n455), .B(n569), .Y(n484) );
  NAND2X1 U439 ( .A(n464), .B(n465), .Y(cmp1[1]) );
  INVX3 U440 ( .A(n493), .Y(n651) );
  OAI221X1 U441 ( .A0(mid_val[6]), .A1(n40), .B0(n597), .B1(n596), .C0(n595), 
        .Y(n598) );
  NAND2X1 U442 ( .A(n456), .B(n457), .Y(cmp1[0]) );
  NAND2X2 U443 ( .A(n471), .B(n472), .Y(res_do[3]) );
  AOI22X1 U444 ( .A0(N88), .A1(n494), .B0(N96), .B1(n644), .Y(n40) );
  NAND2X2 U445 ( .A(n474), .B(n475), .Y(cmp2[2]) );
  INVX3 U446 ( .A(n656), .Y(sti_addr[3]) );
  INVX3 U447 ( .A(n657), .Y(sti_addr[4]) );
  INVX3 U448 ( .A(n658), .Y(sti_addr[5]) );
  INVX3 U449 ( .A(n659), .Y(sti_addr[6]) );
  INVX3 U450 ( .A(n660), .Y(sti_addr[7]) );
  AOI22XL U451 ( .A0(res_addr[6]), .A1(n497), .B0(n496), .B1(sti_addr[2]), .Y(
        n132) );
  AOI22XL U452 ( .A0(res_addr[5]), .A1(n497), .B0(n496), .B1(sti_addr[1]), .Y(
        n137) );
  AOI22XL U453 ( .A0(res_addr[12]), .A1(n497), .B0(n496), .B1(sti_addr[8]), 
        .Y(n97) );
  NAND4XL U454 ( .A(n66), .B(res_addr[3]), .C(res_addr[2]), .D(n55), .Y(n207)
         );
  AOI22XL U455 ( .A0(res_addr[13]), .A1(n497), .B0(n496), .B1(sti_addr[9]), 
        .Y(n82) );
  NAND4XL U456 ( .A(sti_addr[9]), .B(sti_addr[8]), .C(n219), .D(n220), .Y(n200) );
  AOI22XL U457 ( .A0(res_addr[4]), .A1(n497), .B0(n496), .B1(sti_addr[0]), .Y(
        n142) );
  NAND3XL U458 ( .A(sti_addr[1]), .B(sti_addr[0]), .C(sti_addr[2]), .Y(n221)
         );
  INVX3 U459 ( .A(n328), .Y(n453) );
  AOI2BB2X1 U460 ( .B0(n454), .B1(val2[0]), .A0N(val1[1]), .A1N(n434), .Y(n546) );
  AOI21X1 U461 ( .A0(val1[1]), .A1(n434), .B0(val1[0]), .Y(n454) );
  INVX1 U462 ( .A(n42), .Y(\lt_86/A[4] ) );
  AOI21X1 U463 ( .A0(cmp1[1]), .A1(n583), .B0(cmp1[0]), .Y(n572) );
  INVX1 U464 ( .A(n420), .Y(\lt_86/A[3] ) );
  OAI222X1 U465 ( .A0(val1[5]), .A1(n441), .B0(val1[5]), .B1(n542), .C0(n441), 
        .C1(n542), .Y(n543) );
  NAND2BX1 U466 ( .AN(val3[2]), .B(val4[2]), .Y(n559) );
  AOI2BB2X4 U467 ( .B0(n590), .B1(mid_val[0]), .A0N(\lt_86/A[1] ), .A1N(n600), 
        .Y(n592) );
  AOI21X4 U468 ( .A0(\lt_86/A[1] ), .A1(n600), .B0(\lt_86/A[0] ), .Y(n590) );
  INVX4 U469 ( .A(n491), .Y(n645) );
  CLKINVX1 U470 ( .A(n455), .Y(cmp2[5]) );
  OAI22X1 U471 ( .A0(val3[3]), .A1(n437), .B0(val3[3]), .B1(n559), .Y(n565) );
  OA22X1 U472 ( .A0(n426), .A1(n651), .B0(n492), .B1(n442), .Y(n455) );
  OAI22X4 U473 ( .A0(n593), .A1(n592), .B0(n591), .B1(n601), .Y(n596) );
  OR2XL U474 ( .A(n436), .B(n645), .Y(n456) );
  OR2XL U475 ( .A(n491), .B(n435), .Y(n457) );
  BUFX20 U476 ( .A(N76), .Y(n491) );
  NAND2X8 U477 ( .A(n459), .B(n554), .Y(N76) );
  OR2XL U478 ( .A(n491), .B(n434), .Y(n465) );
  OAI2BB1X4 U479 ( .A0N(n37), .A1N(mid_val[7]), .B0(n476), .Y(N98) );
  AO22X4 U480 ( .A0(n603), .A1(\lt_86/A[7] ), .B0(n599), .B1(n598), .Y(n476)
         );
  OR2X1 U481 ( .A(val2[6]), .B(n440), .Y(n460) );
  OR2X2 U482 ( .A(n551), .B(n550), .Y(n461) );
  NAND3X2 U483 ( .A(n460), .B(n461), .C(n549), .Y(n552) );
  OAI22X1 U484 ( .A0(n547), .A1(n546), .B0(n545), .B1(n438), .Y(n550) );
  OAI2BB2X4 U485 ( .B0(val2[7]), .B1(n649), .A0N(n553), .A1N(n552), .Y(n554)
         );
  AOI22X1 U486 ( .A0(N84), .A1(n495), .B0(N92), .B1(n644), .Y(n44) );
  AOI2BB2X1 U487 ( .B0(n572), .B1(cmp2[0]), .A0N(cmp1[1]), .A1N(n583), .Y(n574) );
  OR3X2 U488 ( .A(N505), .B(N98), .C(n66), .Y(n39) );
  OAI22X1 U489 ( .A0(n561), .A1(n560), .B0(n559), .B1(n437), .Y(n564) );
  OR2XL U490 ( .A(n420), .B(n38), .Y(n471) );
  OR2X1 U491 ( .A(n602), .B(n39), .Y(n463) );
  NAND2X2 U492 ( .A(n462), .B(n463), .Y(res_do[5]) );
  AOI22XL U493 ( .A0(N87), .A1(n494), .B0(N95), .B1(n644), .Y(n41) );
  OR2XL U494 ( .A(n433), .B(n645), .Y(n464) );
  NOR2X1 U495 ( .A(val2[6]), .B(n543), .Y(n466) );
  NOR2X1 U496 ( .A(n440), .B(n543), .Y(n467) );
  NOR2X1 U497 ( .A(val2[6]), .B(n440), .Y(n468) );
  OR3X2 U498 ( .A(n466), .B(n467), .C(n468), .Y(n553) );
  AO22X4 U499 ( .A0(n443), .A1(val3[7]), .B0(n567), .B1(n566), .Y(n568) );
  NAND2BX2 U500 ( .AN(\lt_86/A[4] ), .B(mid_val[4]), .Y(n587) );
  NOR2X4 U501 ( .A(\lt_86/A[5] ), .B(n602), .Y(n485) );
  OR3X8 U502 ( .A(n485), .B(n486), .C(n487), .Y(n588) );
  OR2X2 U503 ( .A(val3[5]), .B(n555), .Y(n480) );
  NAND2BXL U504 ( .AN(val1[2]), .B(val2[2]), .Y(n545) );
  OA22X4 U505 ( .A0(n557), .A1(val3[3]), .B0(n557), .B1(n437), .Y(n561) );
  NOR2BX4 U506 ( .AN(val3[2]), .B(val4[2]), .Y(n557) );
  INVX3 U507 ( .A(n41), .Y(\lt_86/A[5] ) );
  NAND3X1 U508 ( .A(n482), .B(n483), .C(n484), .Y(n570) );
  NOR2BX1 U509 ( .AN(cmp1[4]), .B(cmp2[4]), .Y(n576) );
  OAI22X1 U510 ( .A0(n647), .A1(n645), .B0(n490), .B1(n650), .Y(cmp1[4]) );
  CLKBUFX3 U511 ( .A(N78), .Y(n493) );
  OAI222X2 U512 ( .A0(mid_val[6]), .A1(n588), .B0(n40), .B1(n588), .C0(
        mid_val[6]), .C1(n40), .Y(n599) );
  NOR2X4 U513 ( .A(\lt_86/A[5] ), .B(n587), .Y(n486) );
  NOR2X4 U514 ( .A(n602), .B(n587), .Y(n487) );
  NOR2BX1 U515 ( .AN(val1[2]), .B(val2[2]), .Y(n544) );
  OR2X1 U516 ( .A(n347), .B(n39), .Y(n470) );
  NAND2X2 U517 ( .A(n469), .B(n470), .Y(res_do[2]) );
  OR2X1 U518 ( .A(n601), .B(n39), .Y(n472) );
  NOR2BX4 U519 ( .AN(n654), .B(n663), .Y(n473) );
  OR2XL U520 ( .A(n653), .B(n651), .Y(n474) );
  OR2XL U521 ( .A(n493), .B(n662), .Y(n475) );
  INVX12 U522 ( .A(n495), .Y(n644) );
  AOI22XL U523 ( .A0(N85), .A1(n495), .B0(N93), .B1(n644), .Y(n43) );
  AOI22XL U524 ( .A0(N83), .A1(n495), .B0(N91), .B1(n644), .Y(n45) );
  OAI21X4 U525 ( .A0(cmp1[7]), .A1(n585), .B0(n582), .Y(N80) );
  INVX3 U526 ( .A(cmp2[1]), .Y(n583) );
  AOI22XL U527 ( .A0(N82), .A1(n495), .B0(N90), .B1(n644), .Y(n48) );
  CLKBUFX2 U528 ( .A(N76), .Y(n490) );
  CLKBUFX2 U529 ( .A(N78), .Y(n492) );
  OAI22X1 U530 ( .A0(n646), .A1(n645), .B0(n491), .B1(n438), .Y(cmp1[3]) );
  OAI22XL U531 ( .A0(n440), .A1(n645), .B0(n490), .B1(n425), .Y(cmp1[6]) );
  OAI22X1 U532 ( .A0(n444), .A1(n651), .B0(n492), .B1(n664), .Y(cmp2[6]) );
  OAI22XL U533 ( .A0(n430), .A1(n651), .B0(n492), .B1(n443), .Y(cmp2[7]) );
  NOR2X1 U534 ( .A(n429), .B(n422), .Y(n216) );
  OAI221X1 U535 ( .A0(val4[6]), .A1(n444), .B0(n565), .B1(n564), .C0(n563), 
        .Y(n566) );
  OAI22X1 U536 ( .A0(n562), .A1(n442), .B0(val3[5]), .B1(n562), .Y(n563) );
  AOI22X1 U537 ( .A0(res_addr[3]), .A1(n49), .B0(n477), .B1(n478), .Y(n46) );
  OAI22XL U538 ( .A0(n51), .A1(n665), .B0(res_addr[2]), .B1(n53), .Y(n477) );
  OAI22X2 U539 ( .A0(n594), .A1(n602), .B0(\lt_86/A[5] ), .B1(n594), .Y(n595)
         );
  INVX1 U540 ( .A(n48), .Y(\lt_86/A[0] ) );
  NOR2X1 U541 ( .A(n428), .B(state[4]), .Y(n213) );
  NOR2X1 U542 ( .A(n304), .B(state[0]), .Y(n226) );
  CLKINVX1 U543 ( .A(res_di[0]), .Y(n611) );
  CLKINVX1 U544 ( .A(res_di[1]), .Y(n610) );
  CLKINVX1 U545 ( .A(res_di[2]), .Y(n609) );
  CLKINVX1 U546 ( .A(res_di[3]), .Y(n608) );
  CLKINVX1 U547 ( .A(res_di[4]), .Y(n607) );
  CLKINVX1 U548 ( .A(res_di[5]), .Y(n606) );
  CLKINVX1 U549 ( .A(res_di[6]), .Y(n605) );
  CLKINVX1 U550 ( .A(res_di[7]), .Y(n604) );
  CLKBUFX3 U551 ( .A(count_addr[7]), .Y(n517) );
  CLKBUFX3 U552 ( .A(n95), .Y(n497) );
  CLKBUFX3 U553 ( .A(count_addr[12]), .Y(n527) );
  OAI222X1 U554 ( .A0(val4[6]), .A1(n556), .B0(n444), .B1(n556), .C0(val4[6]), 
        .C1(n444), .Y(n567) );
  OR2X1 U555 ( .A(cmp1[5]), .B(n455), .Y(n482) );
  OAI22X1 U556 ( .A0(n648), .A1(n645), .B0(n490), .B1(n441), .Y(cmp1[5]) );
  OAI222X1 U557 ( .A0(cmp2[6]), .A1(n570), .B0(n586), .B1(n570), .C0(cmp2[6]), 
        .C1(n586), .Y(n581) );
  CLKINVX1 U558 ( .A(n421), .Y(\lt_86/A[1] ) );
  CLKBUFX3 U559 ( .A(N80), .Y(n495) );
  CLKBUFX3 U560 ( .A(N80), .Y(n494) );
  INVX3 U561 ( .A(n509), .Y(n617) );
  INVX3 U562 ( .A(n510), .Y(n619) );
  INVX3 U563 ( .A(n516), .Y(n620) );
  CLKINVX1 U564 ( .A(cmp2[7]), .Y(n585) );
  NAND2BX1 U565 ( .AN(cmp1[4]), .B(cmp2[4]), .Y(n569) );
  CLKINVX1 U566 ( .A(cmp1[6]), .Y(n586) );
  AOI22X1 U567 ( .A0(N89), .A1(n494), .B0(N97), .B1(n644), .Y(n37) );
  CLKBUFX3 U568 ( .A(n618), .Y(n518) );
  CLKINVX1 U569 ( .A(n507), .Y(n618) );
  CLKBUFX3 U570 ( .A(n147), .Y(n511) );
  NAND2X1 U571 ( .A(n183), .B(n180), .Y(n147) );
  CLKINVX1 U572 ( .A(n217), .Y(n628) );
  INVX3 U573 ( .A(n225), .Y(n624) );
  CLKINVX1 U574 ( .A(n212), .Y(n625) );
  CLKINVX1 U575 ( .A(n506), .Y(n616) );
  CLKINVX1 U576 ( .A(n202), .Y(n613) );
  CLKBUFX3 U577 ( .A(n88), .Y(n508) );
  NAND2X1 U578 ( .A(n507), .B(n210), .Y(n88) );
  CLKBUFX3 U579 ( .A(n276), .Y(n509) );
  NOR2X1 U580 ( .A(n503), .B(n500), .Y(n276) );
  CLKINVX1 U581 ( .A(n216), .Y(n621) );
  CLKBUFX3 U582 ( .A(n266), .Y(n510) );
  NOR2X1 U583 ( .A(n504), .B(n501), .Y(n266) );
  NAND2X1 U584 ( .A(n626), .B(n211), .Y(N119) );
  CLKBUFX3 U585 ( .A(n78), .Y(n516) );
  NOR2X1 U586 ( .A(n621), .B(n627), .Y(n78) );
  CLKBUFX3 U587 ( .A(n67), .Y(n502) );
  NOR2X1 U588 ( .A(n446), .B(n498), .Y(n67) );
  INVX3 U589 ( .A(n498), .Y(n622) );
  INVX3 U590 ( .A(n505), .Y(n614) );
  OAI22X1 U591 ( .A0(n432), .A1(n645), .B0(n491), .B1(n424), .Y(cmp1[2]) );
  OAI22X1 U592 ( .A0(n423), .A1(n651), .B0(n493), .B1(n437), .Y(cmp2[3]) );
  OAI22X1 U593 ( .A0(n652), .A1(n651), .B0(n493), .B1(n661), .Y(cmp2[1]) );
  OAI22X1 U594 ( .A0(n654), .A1(n651), .B0(n492), .B1(n663), .Y(cmp2[4]) );
  OAI22X1 U595 ( .A0(n427), .A1(n651), .B0(n493), .B1(n439), .Y(cmp2[0]) );
  OAI22X1 U596 ( .A0(n649), .A1(n645), .B0(n490), .B1(n445), .Y(cmp1[7]) );
  INVX3 U597 ( .A(n534), .Y(n533) );
  AOI222XL U598 ( .A0(N231), .A1(n499), .B0(N245), .B1(n500), .C0(N259), .C1(
        n501), .Y(n103) );
  AOI222XL U599 ( .A0(N232), .A1(n499), .B0(N246), .B1(n500), .C0(N260), .C1(
        n501), .Y(n98) );
  AOI222XL U600 ( .A0(N230), .A1(n499), .B0(N244), .B1(n500), .C0(N258), .C1(
        n501), .Y(n109) );
  AOI222XL U601 ( .A0(N229), .A1(n499), .B0(N243), .B1(n500), .C0(N257), .C1(
        n501), .Y(n115) );
  OAI22XL U602 ( .A0(n619), .A1(n427), .B0(n510), .B1(n611), .Y(n394) );
  OAI22XL U603 ( .A0(n619), .A1(n430), .B0(n510), .B1(n604), .Y(n393) );
  OAI22XL U604 ( .A0(n619), .A1(n444), .B0(n510), .B1(n605), .Y(n392) );
  OAI22XL U605 ( .A0(n619), .A1(n426), .B0(n510), .B1(n606), .Y(n391) );
  OAI22XL U606 ( .A0(n619), .A1(n654), .B0(n510), .B1(n607), .Y(n390) );
  OAI22XL U607 ( .A0(n619), .A1(n423), .B0(n510), .B1(n608), .Y(n389) );
  OAI22XL U608 ( .A0(n619), .A1(n653), .B0(n510), .B1(n609), .Y(n388) );
  OAI22XL U609 ( .A0(n619), .A1(n652), .B0(n510), .B1(n610), .Y(n387) );
  OAI22XL U610 ( .A0(n617), .A1(n435), .B0(n509), .B1(n611), .Y(n402) );
  OAI22XL U611 ( .A0(n617), .A1(n445), .B0(n509), .B1(n604), .Y(n401) );
  OAI22XL U612 ( .A0(n617), .A1(n425), .B0(n509), .B1(n605), .Y(n400) );
  OAI22XL U613 ( .A0(n617), .A1(n441), .B0(n509), .B1(n606), .Y(n399) );
  OAI22XL U614 ( .A0(n617), .A1(n650), .B0(n509), .B1(n607), .Y(n398) );
  OAI22XL U615 ( .A0(n617), .A1(n438), .B0(n509), .B1(n608), .Y(n397) );
  OAI22XL U616 ( .A0(n617), .A1(n424), .B0(n509), .B1(n609), .Y(n396) );
  OAI22XL U617 ( .A0(n617), .A1(n434), .B0(n509), .B1(n610), .Y(n395) );
  OAI22XL U618 ( .A0(n498), .A1(n611), .B0(n622), .B1(n436), .Y(n410) );
  OAI22XL U619 ( .A0(n498), .A1(n604), .B0(n622), .B1(n649), .Y(n409) );
  OAI22XL U620 ( .A0(n498), .A1(n605), .B0(n622), .B1(n440), .Y(n408) );
  OAI22XL U621 ( .A0(n498), .A1(n606), .B0(n622), .B1(n648), .Y(n407) );
  OAI22XL U622 ( .A0(n498), .A1(n607), .B0(n622), .B1(n647), .Y(n406) );
  OAI22XL U623 ( .A0(n498), .A1(n608), .B0(n622), .B1(n646), .Y(n405) );
  OAI22XL U624 ( .A0(n498), .A1(n609), .B0(n622), .B1(n432), .Y(n404) );
  OAI22XL U625 ( .A0(n498), .A1(n610), .B0(n622), .B1(n433), .Y(n403) );
  OAI22XL U626 ( .A0(n507), .A1(n605), .B0(n518), .B1(n664), .Y(n384) );
  OAI22XL U627 ( .A0(n507), .A1(n607), .B0(n518), .B1(n663), .Y(n382) );
  OAI22XL U628 ( .A0(n507), .A1(n609), .B0(n518), .B1(n662), .Y(n380) );
  OAI22XL U629 ( .A0(n507), .A1(n604), .B0(n518), .B1(n443), .Y(n385) );
  OAI22XL U630 ( .A0(n507), .A1(n606), .B0(n518), .B1(n442), .Y(n383) );
  OAI22XL U631 ( .A0(n507), .A1(n608), .B0(n518), .B1(n437), .Y(n381) );
  OAI22XL U632 ( .A0(n507), .A1(n610), .B0(n518), .B1(n661), .Y(n379) );
  OAI22XL U633 ( .A0(n507), .A1(n611), .B0(n518), .B1(n439), .Y(n386) );
  AOI222XL U634 ( .A0(N228), .A1(n499), .B0(N242), .B1(n500), .C0(N256), .C1(
        n501), .Y(n121) );
  AOI222XL U635 ( .A0(n334), .A1(n499), .B0(N241), .B1(n500), .C0(N255), .C1(
        n501), .Y(n127) );
  AOI222XL U636 ( .A0(n522), .A1(n499), .B0(N240), .B1(n500), .C0(N254), .C1(
        n501), .Y(n133) );
  AOI222XL U637 ( .A0(n523), .A1(n499), .B0(N239), .B1(n500), .C0(N253), .C1(
        n501), .Y(n138) );
  CLKBUFX3 U638 ( .A(n247), .Y(n507) );
  OAI211X1 U639 ( .A0(n300), .A1(n226), .B0(n428), .C0(n530), .Y(n247) );
  NOR2X1 U640 ( .A(n529), .B(n70), .Y(n300) );
  NAND4X1 U641 ( .A(nstate[2]), .B(nstate[3]), .C(n612), .D(n615), .Y(n180) );
  NAND2X1 U642 ( .A(n529), .B(n643), .Y(n304) );
  CLKINVX1 U643 ( .A(nstate[0]), .Y(n612) );
  CLKBUFX3 U644 ( .A(n152), .Y(n514) );
  NOR2BX1 U645 ( .AN(n181), .B(n180), .Y(n152) );
  CLKBUFX3 U646 ( .A(n153), .Y(n515) );
  NOR2X1 U647 ( .A(n180), .B(n181), .Y(n153) );
  CLKINVX1 U648 ( .A(nstate[1]), .Y(n615) );
  NAND4BX1 U649 ( .AN(nstate[3]), .B(nstate[2]), .C(n612), .D(n615), .Y(n183)
         );
  CLKBUFX3 U650 ( .A(n149), .Y(n512) );
  NAND2BX1 U651 ( .AN(n183), .B(n182), .Y(n149) );
  CLKBUFX3 U652 ( .A(n151), .Y(n513) );
  NOR2X1 U653 ( .A(n182), .B(n183), .Y(n151) );
  AOI222XL U654 ( .A0(n524), .A1(n499), .B0(N238), .B1(n500), .C0(N252), .C1(
        n501), .Y(n143) );
  CLKBUFX3 U655 ( .A(n284), .Y(n498) );
  NAND2X1 U656 ( .A(n216), .B(n213), .Y(n284) );
  CLKBUFX3 U657 ( .A(n92), .Y(n499) );
  NOR2X1 U658 ( .A(n498), .B(n529), .Y(n92) );
  CLKINVX1 U659 ( .A(n66), .Y(n627) );
  NOR2X1 U660 ( .A(n532), .B(n529), .Y(n217) );
  NAND3X1 U661 ( .A(n532), .B(n530), .C(n226), .Y(n225) );
  CLKBUFX3 U662 ( .A(n86), .Y(n506) );
  NOR2X1 U663 ( .A(n505), .B(n529), .Y(n86) );
  CLKBUFX3 U664 ( .A(n294), .Y(n505) );
  NAND3X1 U665 ( .A(n530), .B(n422), .C(n213), .Y(n294) );
  NAND3X1 U666 ( .A(n532), .B(n429), .C(n226), .Y(n197) );
  NAND3X1 U667 ( .A(n197), .B(n193), .C(n225), .Y(n212) );
  NAND3X1 U668 ( .A(n208), .B(n625), .C(n209), .Y(nstate[2]) );
  AOI33X1 U669 ( .A0(n213), .A1(n446), .A2(n215), .B0(n216), .B1(n217), .B2(
        n655), .Y(n208) );
  AND4X1 U670 ( .A(n210), .B(n202), .C(n211), .D(n616), .Y(n209) );
  CLKINVX1 U671 ( .A(n200), .Y(n655) );
  NOR2X1 U672 ( .A(n667), .B(n666), .Y(n55) );
  AOI222XL U673 ( .A0(n525), .A1(n499), .B0(N237), .B1(n500), .C0(N251), .C1(
        n501), .Y(n297) );
  NAND4X1 U674 ( .A(n213), .B(n422), .C(n429), .D(n446), .Y(n202) );
  NAND3X1 U675 ( .A(n309), .B(n428), .C(n216), .Y(n211) );
  OAI21XL U676 ( .A0(n529), .A1(n643), .B0(n304), .Y(n309) );
  NOR2X1 U677 ( .A(n422), .B(n530), .Y(n81) );
  NAND2X1 U678 ( .A(n81), .B(n213), .Y(n210) );
  INVX3 U679 ( .A(n496), .Y(n626) );
  AOI221XL U680 ( .A0(n508), .A1(n642), .B0(N262), .B1(n624), .C0(n75), .Y(
        n246) );
  AOI222XL U681 ( .A0(N207), .A1(n506), .B0(N263), .B1(n624), .C0(n508), .C1(
        N221), .Y(n242) );
  AOI222XL U682 ( .A0(N208), .A1(n506), .B0(N264), .B1(n624), .C0(n508), .C1(
        N222), .Y(n238) );
  CLKBUFX3 U683 ( .A(n93), .Y(n500) );
  NOR3BXL U684 ( .AN(n226), .B(n530), .C(n532), .Y(n93) );
  NOR4X4 U685 ( .A(n428), .B(n621), .C(n446), .D(n643), .Y(N687) );
  CLKBUFX3 U686 ( .A(n94), .Y(n501) );
  NOR3BXL U687 ( .AN(n81), .B(n304), .C(n532), .Y(n94) );
  CLKBUFX3 U688 ( .A(n90), .Y(n503) );
  NOR3X1 U689 ( .A(n628), .B(n530), .C(n70), .Y(n90) );
  CLKBUFX3 U690 ( .A(n91), .Y(n504) );
  NOR3BXL U691 ( .AN(n81), .B(n643), .C(n628), .Y(n91) );
  CLKBUFX3 U692 ( .A(reset), .Y(n541) );
  CLKBUFX3 U693 ( .A(n536), .Y(n540) );
  CLKBUFX3 U694 ( .A(reset), .Y(n539) );
  CLKBUFX3 U695 ( .A(reset), .Y(n538) );
  CLKBUFX3 U696 ( .A(reset), .Y(n537) );
  CLKBUFX3 U697 ( .A(reset), .Y(n536) );
  CLKBUFX3 U698 ( .A(reset), .Y(n535) );
  OAI22XL U699 ( .A0(n60), .A1(n665), .B0(res_addr[2]), .B1(n61), .Y(n49) );
  CLKINVX1 U700 ( .A(n37), .Y(\lt_86/A[7] ) );
  OAI22X2 U701 ( .A0(n421), .A1(n38), .B0(n600), .B1(n39), .Y(res_do[1]) );
  OAI22X2 U702 ( .A0(n42), .A1(n38), .B0(n345), .B1(n39), .Y(res_do[4]) );
  OAI22X2 U703 ( .A0(n40), .A1(n38), .B0(n343), .B1(n39), .Y(res_do[6]) );
  OAI22X2 U704 ( .A0(n37), .A1(n38), .B0(n603), .B1(n39), .Y(res_do[7]) );
  NAND4X1 U705 ( .A(n102), .B(n103), .C(n104), .D(n105), .Y(n353) );
  AOI2BB2X1 U706 ( .B0(res_addr[11]), .B1(n497), .A0N(n626), .A1N(n660), .Y(
        n102) );
  AOI222XL U707 ( .A0(N287), .A1(n502), .B0(N301), .B1(n503), .C0(N315), .C1(
        n504), .Y(n104) );
  AOI222XL U708 ( .A0(N217), .A1(n506), .B0(N273), .B1(n624), .C0(n508), .C1(
        count_addr[11]), .Y(n105) );
  AOI222XL U709 ( .A0(N233), .A1(n499), .B0(N247), .B1(n500), .C0(N261), .C1(
        n501), .Y(n83) );
  NAND4X1 U710 ( .A(n82), .B(n83), .C(n84), .D(n85), .Y(n351) );
  AOI222XL U711 ( .A0(N289), .A1(n502), .B0(N303), .B1(n503), .C0(N317), .C1(
        n504), .Y(n84) );
  AOI222XL U712 ( .A0(N219), .A1(n506), .B0(N275), .B1(n624), .C0(n508), .C1(
        n453), .Y(n85) );
  OAI221XL U713 ( .A0(n330), .A1(n511), .B0(n631), .B1(n512), .C0(n157), .Y(
        n363) );
  CLKINVX1 U714 ( .A(N273), .Y(n631) );
  AOI222XL U715 ( .A0(N346), .A1(n513), .B0(n514), .B1(N259), .C0(N389), .C1(
        n515), .Y(n157) );
  CLKBUFX3 U716 ( .A(N221), .Y(n531) );
  OAI221XL U717 ( .A0(n328), .A1(n511), .B0(n629), .B1(n512), .C0(n150), .Y(
        n361) );
  CLKINVX1 U718 ( .A(N275), .Y(n629) );
  AOI222XL U719 ( .A0(N348), .A1(n513), .B0(n514), .B1(N261), .C0(N391), .C1(
        n515), .Y(n150) );
  AOI221XL U720 ( .A0(sti_di[13]), .A1(n54), .B0(sti_di[12]), .B1(n55), .C0(
        n56), .Y(n53) );
  AO22X1 U721 ( .A0(sti_di[14]), .A1(n57), .B0(sti_di[15]), .B1(n58), .Y(n56)
         );
  AOI221XL U722 ( .A0(sti_di[9]), .A1(n54), .B0(sti_di[8]), .B1(n55), .C0(n59), 
        .Y(n51) );
  AO22X1 U723 ( .A0(sti_di[10]), .A1(n57), .B0(sti_di[11]), .B1(n58), .Y(n59)
         );
  AOI221XL U724 ( .A0(sti_di[5]), .A1(n54), .B0(sti_di[4]), .B1(n55), .C0(n62), 
        .Y(n61) );
  AO22X1 U725 ( .A0(sti_di[6]), .A1(n57), .B0(sti_di[7]), .B1(n58), .Y(n62) );
  NAND4X1 U726 ( .A(n97), .B(n98), .C(n99), .D(n100), .Y(n352) );
  AOI222XL U727 ( .A0(N288), .A1(n502), .B0(N302), .B1(n503), .C0(N316), .C1(
        n504), .Y(n99) );
  AOI222XL U728 ( .A0(N218), .A1(n506), .B0(N274), .B1(n624), .C0(n508), .C1(
        count_addr[12]), .Y(n100) );
  AOI221XL U729 ( .A0(sti_di[1]), .A1(n54), .B0(sti_di[0]), .B1(n55), .C0(n63), 
        .Y(n60) );
  AO22X1 U730 ( .A0(sti_di[2]), .A1(n57), .B0(sti_di[3]), .B1(n58), .Y(n63) );
  NAND4X1 U731 ( .A(n108), .B(n109), .C(n110), .D(n111), .Y(n354) );
  AOI2BB2X1 U732 ( .B0(res_addr[10]), .B1(n497), .A0N(n626), .A1N(n659), .Y(
        n108) );
  AOI222XL U733 ( .A0(N286), .A1(n502), .B0(N300), .B1(n503), .C0(N314), .C1(
        n504), .Y(n110) );
  AOI222XL U734 ( .A0(N216), .A1(n506), .B0(N272), .B1(n624), .C0(n508), .C1(
        count_addr[10]), .Y(n111) );
  OAI221XL U735 ( .A0(n329), .A1(n511), .B0(n630), .B1(n512), .C0(n155), .Y(
        n362) );
  CLKINVX1 U736 ( .A(N274), .Y(n630) );
  AOI222XL U737 ( .A0(N347), .A1(n513), .B0(n514), .B1(N260), .C0(N390), .C1(
        n515), .Y(n155) );
  OAI221XL U738 ( .A0(n331), .A1(n511), .B0(n632), .B1(n512), .C0(n159), .Y(
        n364) );
  CLKINVX1 U739 ( .A(N272), .Y(n632) );
  AOI222XL U740 ( .A0(N345), .A1(n513), .B0(n514), .B1(N258), .C0(N388), .C1(
        n515), .Y(n159) );
  CLKBUFX3 U741 ( .A(N222), .Y(n528) );
  CLKBUFX3 U742 ( .A(N223), .Y(n525) );
  NAND4X1 U743 ( .A(n114), .B(n115), .C(n116), .D(n117), .Y(n355) );
  AOI2BB2X1 U744 ( .B0(res_addr[9]), .B1(n497), .A0N(n626), .A1N(n658), .Y(
        n114) );
  AOI222XL U745 ( .A0(N285), .A1(n502), .B0(N299), .B1(n503), .C0(N313), .C1(
        n504), .Y(n116) );
  AOI222XL U746 ( .A0(N215), .A1(n506), .B0(N271), .B1(n624), .C0(n508), .C1(
        count_addr[9]), .Y(n117) );
  OAI221XL U747 ( .A0(n332), .A1(n511), .B0(n633), .B1(n512), .C0(n161), .Y(
        n365) );
  CLKINVX1 U748 ( .A(N271), .Y(n633) );
  AOI222XL U749 ( .A0(N344), .A1(n513), .B0(n514), .B1(N257), .C0(N387), .C1(
        n515), .Y(n161) );
  CLKBUFX3 U750 ( .A(N224), .Y(n524) );
  OAI22XL U751 ( .A0(n505), .A1(n611), .B0(n349), .B1(n614), .Y(n418) );
  OAI22XL U752 ( .A0(n505), .A1(n610), .B0(n600), .B1(n614), .Y(n417) );
  OAI22XL U753 ( .A0(n505), .A1(n609), .B0(n347), .B1(n614), .Y(n416) );
  OAI22XL U754 ( .A0(n505), .A1(n608), .B0(n601), .B1(n614), .Y(n415) );
  OAI22XL U755 ( .A0(n505), .A1(n607), .B0(n345), .B1(n614), .Y(n414) );
  OAI22XL U756 ( .A0(n505), .A1(n606), .B0(n602), .B1(n614), .Y(n413) );
  OAI22XL U757 ( .A0(n505), .A1(n605), .B0(n343), .B1(n614), .Y(n412) );
  OAI22XL U758 ( .A0(n505), .A1(n604), .B0(n603), .B1(n614), .Y(n411) );
  NAND4X1 U759 ( .A(n120), .B(n121), .C(n122), .D(n123), .Y(n356) );
  AOI2BB2X1 U760 ( .B0(res_addr[8]), .B1(n497), .A0N(n626), .A1N(n657), .Y(
        n120) );
  AOI222XL U761 ( .A0(N214), .A1(n506), .B0(N270), .B1(n624), .C0(n508), .C1(
        count_addr[8]), .Y(n123) );
  AOI222XL U762 ( .A0(N284), .A1(n502), .B0(N298), .B1(n503), .C0(N312), .C1(
        n504), .Y(n122) );
  OAI221XL U763 ( .A0(n333), .A1(n511), .B0(n634), .B1(n512), .C0(n163), .Y(
        n366) );
  CLKINVX1 U764 ( .A(N270), .Y(n634) );
  AOI222XL U765 ( .A0(N343), .A1(n513), .B0(n514), .B1(N256), .C0(N386), .C1(
        n515), .Y(n163) );
  CLKBUFX3 U766 ( .A(N225), .Y(n523) );
  NAND4X1 U767 ( .A(n126), .B(n127), .C(n128), .D(n129), .Y(n357) );
  AOI2BB2X1 U768 ( .B0(res_addr[7]), .B1(n497), .A0N(n626), .A1N(n656), .Y(
        n126) );
  AOI222XL U769 ( .A0(N283), .A1(n502), .B0(n334), .B1(n503), .C0(N311), .C1(
        n504), .Y(n128) );
  AOI222XL U770 ( .A0(N213), .A1(n506), .B0(N269), .B1(n624), .C0(n508), .C1(
        count_addr[7]), .Y(n129) );
  OAI221XL U771 ( .A0(n334), .A1(n511), .B0(n635), .B1(n512), .C0(n165), .Y(
        n367) );
  CLKINVX1 U772 ( .A(N269), .Y(n635) );
  AOI222XL U773 ( .A0(N342), .A1(n513), .B0(n514), .B1(N255), .C0(N385), .C1(
        n515), .Y(n165) );
  CLKBUFX3 U774 ( .A(N226), .Y(n522) );
  NAND4X1 U775 ( .A(n132), .B(n133), .C(n134), .D(n135), .Y(n358) );
  AOI222XL U776 ( .A0(N282), .A1(n502), .B0(n522), .B1(n503), .C0(N310), .C1(
        n504), .Y(n134) );
  AOI222XL U777 ( .A0(N212), .A1(n506), .B0(N268), .B1(n624), .C0(n508), .C1(
        N226), .Y(n135) );
  OAI221XL U778 ( .A0(n335), .A1(n511), .B0(n636), .B1(n512), .C0(n167), .Y(
        n368) );
  CLKINVX1 U779 ( .A(N268), .Y(n636) );
  AOI222XL U780 ( .A0(N341), .A1(n513), .B0(n514), .B1(N254), .C0(N384), .C1(
        n515), .Y(n167) );
  NAND4X1 U781 ( .A(n137), .B(n138), .C(n139), .D(n140), .Y(n359) );
  AOI222XL U782 ( .A0(N281), .A1(n502), .B0(n523), .B1(n503), .C0(N309), .C1(
        n504), .Y(n139) );
  AOI222XL U783 ( .A0(N211), .A1(n506), .B0(N267), .B1(n624), .C0(n508), .C1(
        N225), .Y(n140) );
  OAI221XL U784 ( .A0(n336), .A1(n511), .B0(n637), .B1(n512), .C0(n169), .Y(
        n369) );
  CLKINVX1 U785 ( .A(N267), .Y(n637) );
  AOI222XL U786 ( .A0(N340), .A1(n513), .B0(n514), .B1(N253), .C0(N383), .C1(
        n515), .Y(n169) );
  CLKBUFX3 U787 ( .A(count_addr[8]), .Y(n521) );
  OAI211X1 U788 ( .A0(n201), .A1(n202), .B0(n625), .C0(n204), .Y(nstate[0]) );
  AOI211X1 U789 ( .A0(n205), .A1(n422), .B0(n518), .C0(n506), .Y(n204) );
  OAI21XL U790 ( .A0(n532), .A1(n530), .B0(n207), .Y(n205) );
  OAI221XL U791 ( .A0(n340), .A1(n511), .B0(n512), .B1(n641), .C0(n179), .Y(
        n374) );
  CLKINVX1 U792 ( .A(N263), .Y(n641) );
  AOI222XL U793 ( .A0(N336), .A1(n513), .B0(N249), .B1(n514), .C0(N379), .C1(
        n515), .Y(n179) );
  OAI221XL U794 ( .A0(n338), .A1(n511), .B0(n512), .B1(n639), .C0(n173), .Y(
        n371) );
  CLKINVX1 U795 ( .A(N265), .Y(n639) );
  AOI222XL U796 ( .A0(N338), .A1(n513), .B0(N251), .B1(n514), .C0(N381), .C1(
        n515), .Y(n173) );
  OAI221XL U797 ( .A0(n339), .A1(n511), .B0(n512), .B1(n640), .C0(n175), .Y(
        n372) );
  CLKINVX1 U798 ( .A(N264), .Y(n640) );
  AOI222XL U799 ( .A0(N337), .A1(n513), .B0(N250), .B1(n514), .C0(N380), .C1(
        n515), .Y(n175) );
  OAI221XL U800 ( .A0(n337), .A1(n511), .B0(n638), .B1(n512), .C0(n171), .Y(
        n370) );
  CLKINVX1 U801 ( .A(N266), .Y(n638) );
  AOI222XL U802 ( .A0(N339), .A1(n513), .B0(n514), .B1(N252), .C0(N382), .C1(
        n515), .Y(n171) );
  OAI221XL U803 ( .A0(n534), .A1(n511), .B0(n512), .B1(n533), .C0(n177), .Y(
        n373) );
  AOI222XL U804 ( .A0(n534), .A1(n513), .B0(N248), .B1(n514), .C0(n534), .C1(
        n515), .Y(n177) );
  NAND4X1 U805 ( .A(n189), .B(n616), .C(n68), .D(n191), .Y(nstate[1]) );
  NAND3X1 U806 ( .A(n66), .B(n200), .C(state[0]), .Y(n189) );
  NOR4X1 U807 ( .A(n496), .B(n518), .C(n81), .D(n624), .Y(n191) );
  NAND2X1 U808 ( .A(state[4]), .B(n422), .Y(n70) );
  CLKBUFX3 U809 ( .A(state[3]), .Y(n529) );
  NAND4X1 U810 ( .A(n142), .B(n143), .C(n144), .D(n145), .Y(n360) );
  AOI222XL U811 ( .A0(N280), .A1(n502), .B0(n524), .B1(n503), .C0(N308), .C1(
        n504), .Y(n144) );
  AOI222XL U812 ( .A0(N210), .A1(n506), .B0(N266), .B1(n624), .C0(n508), .C1(
        N224), .Y(n145) );
  OAI211X1 U813 ( .A0(n215), .A1(n623), .B0(n223), .C0(n224), .Y(nstate[3]) );
  AOI21X1 U814 ( .A0(n613), .A1(n201), .B0(n226), .Y(n223) );
  AOI221XL U815 ( .A0(state[4]), .A1(n216), .B0(n529), .B1(n429), .C0(n212), 
        .Y(n224) );
  CLKINVX1 U816 ( .A(n499), .Y(n623) );
  CLKBUFX3 U817 ( .A(state[1]), .Y(n530) );
  NOR2X2 U818 ( .A(n628), .B(state[4]), .Y(n66) );
  CLKBUFX3 U819 ( .A(n96), .Y(n496) );
  NOR3X1 U820 ( .A(n627), .B(state[0]), .C(n429), .Y(n96) );
  CLKBUFX3 U821 ( .A(state[2]), .Y(n532) );
  CLKBUFX3 U822 ( .A(count_addr[9]), .Y(n520) );
  AND2X2 U823 ( .A(n193), .B(n194), .Y(n68) );
  NAND4X1 U824 ( .A(n332), .B(n333), .C(n195), .D(n196), .Y(n194) );
  NOR4X1 U825 ( .A(count_addr[10]), .B(count_addr[11]), .C(count_addr[12]), 
        .D(n431), .Y(n196) );
  NOR3X1 U826 ( .A(n197), .B(n334), .C(n181), .Y(n195) );
  NAND4X1 U827 ( .A(n296), .B(n297), .C(n298), .D(n299), .Y(n419) );
  AOI222XL U828 ( .A0(N279), .A1(n502), .B0(n525), .B1(n503), .C0(N307), .C1(
        n504), .Y(n298) );
  AOI22X1 U829 ( .A0(res_addr[3]), .A1(n497), .B0(sti_count[3]), .B1(n496), 
        .Y(n296) );
  AOI222XL U830 ( .A0(N209), .A1(n506), .B0(N265), .B1(n624), .C0(n508), .C1(
        N223), .Y(n299) );
  NAND2X1 U831 ( .A(state[4]), .B(n628), .Y(n193) );
  NOR2X1 U832 ( .A(n666), .B(res_addr[1]), .Y(n57) );
  NAND4X1 U833 ( .A(n336), .B(n337), .C(n335), .D(n198), .Y(n181) );
  NOR4X1 U834 ( .A(n534), .B(N221), .C(N222), .D(N223), .Y(n198) );
  NOR3X1 U835 ( .A(n660), .B(n658), .C(n659), .Y(n219) );
  NOR3X1 U836 ( .A(n221), .B(n656), .C(n657), .Y(n220) );
  NOR2X1 U837 ( .A(n667), .B(res_addr[0]), .Y(n54) );
  NOR2X1 U838 ( .A(res_addr[0]), .B(res_addr[1]), .Y(n58) );
  CLKBUFX3 U839 ( .A(count_addr[10]), .Y(n519) );
  NOR2BX1 U840 ( .AN(n313), .B(n626), .Y(n75) );
  NAND2X1 U841 ( .A(sti_count[1]), .B(n75), .Y(n73) );
  XOR2X1 U842 ( .A(sti_count[3]), .B(n72), .Y(n314) );
  NOR2X1 U843 ( .A(n73), .B(n447), .Y(n72) );
  XNOR2X1 U844 ( .A(n312), .B(n73), .Y(n315) );
  AO22X1 U845 ( .A0(n620), .A1(sti_addr[9]), .B0(N114), .B1(n516), .Y(n318) );
  NAND4X1 U846 ( .A(n243), .B(n244), .C(n245), .D(n246), .Y(n378) );
  AOI222XL U847 ( .A0(n534), .A1(n504), .B0(n534), .B1(n506), .C0(n533), .C1(
        n503), .Y(n245) );
  AOI222XL U848 ( .A0(N248), .A1(n501), .B0(n534), .B1(n502), .C0(n534), .C1(
        n500), .Y(n244) );
  AOI22X1 U849 ( .A0(n533), .A1(n499), .B0(res_addr[0]), .B1(n497), .Y(n243)
         );
  NAND4X1 U850 ( .A(n239), .B(n240), .C(n241), .D(n242), .Y(n377) );
  AOI222XL U851 ( .A0(N277), .A1(n502), .B0(n531), .B1(n503), .C0(N305), .C1(
        n504), .Y(n241) );
  AOI222XL U852 ( .A0(n531), .A1(n499), .B0(N235), .B1(n500), .C0(N249), .C1(
        n501), .Y(n240) );
  AOI22X1 U853 ( .A0(res_addr[1]), .A1(n497), .B0(sti_count[1]), .B1(n496), 
        .Y(n239) );
  NAND4X1 U854 ( .A(n235), .B(n236), .C(n237), .D(n238), .Y(n376) );
  AOI222XL U855 ( .A0(N278), .A1(n502), .B0(n528), .B1(n503), .C0(N306), .C1(
        n504), .Y(n237) );
  AOI2BB2X1 U856 ( .B0(res_addr[2]), .B1(n497), .A0N(n447), .A1N(n626), .Y(
        n235) );
  AOI222XL U857 ( .A0(n528), .A1(n499), .B0(N236), .B1(n500), .C0(N250), .C1(
        n501), .Y(n236) );
  XOR2X1 U858 ( .A(sti_count[1]), .B(n75), .Y(n316) );
  AND4X1 U859 ( .A(n227), .B(n228), .C(n229), .D(n230), .Y(n201) );
  NOR4X1 U860 ( .A(n328), .B(n329), .C(n330), .D(n331), .Y(n230) );
  NOR3X1 U861 ( .A(n334), .B(n332), .C(n333), .Y(n229) );
  NOR4X1 U862 ( .A(n335), .B(n336), .C(n338), .D(n339), .Y(n228) );
  NOR3X1 U863 ( .A(n642), .B(n340), .C(N224), .Y(n227) );
  CLKBUFX3 U864 ( .A(count_addr[11]), .Y(n526) );
  OAI221XL U865 ( .A0(n530), .A1(n305), .B0(n532), .B1(n621), .C0(n193), .Y(
        n95) );
  AOI2BB1X1 U866 ( .A0N(state[0]), .A1N(n428), .B0(n66), .Y(n305) );
  AO22X1 U867 ( .A0(n620), .A1(sti_addr[8]), .B0(N113), .B1(n516), .Y(n319) );
  NOR2X1 U868 ( .A(n488), .B(n489), .Y(n215) );
  NAND4X1 U869 ( .A(n345), .B(n602), .C(n343), .D(n603), .Y(n488) );
  NAND4X1 U870 ( .A(n349), .B(n600), .C(n347), .D(n601), .Y(n489) );
  XNOR2X1 U871 ( .A(n313), .B(n626), .Y(n317) );
  AO22X1 U872 ( .A0(n620), .A1(sti_addr[7]), .B0(N112), .B1(n516), .Y(n320) );
  NAND4BX1 U873 ( .AN(n502), .B(n68), .C(n69), .D(n70), .Y(nstate[4]) );
  NAND2X1 U874 ( .A(state[4]), .B(n429), .Y(n69) );
  AO22X1 U875 ( .A0(n620), .A1(sti_addr[0]), .B0(N105), .B1(n516), .Y(n327) );
  AO22X1 U876 ( .A0(n620), .A1(sti_addr[2]), .B0(N107), .B1(n516), .Y(n325) );
  AO22X1 U877 ( .A0(n620), .A1(sti_addr[1]), .B0(N106), .B1(n516), .Y(n326) );
  AO22X1 U878 ( .A0(n620), .A1(sti_addr[6]), .B0(N111), .B1(n516), .Y(n321) );
  AO22X1 U879 ( .A0(n620), .A1(sti_addr[5]), .B0(N110), .B1(n516), .Y(n322) );
  AO22X1 U880 ( .A0(n620), .A1(sti_addr[4]), .B0(N109), .B1(n516), .Y(n323) );
  AO22X1 U881 ( .A0(n620), .A1(sti_addr[3]), .B0(N108), .B1(n516), .Y(n324) );
  OAI2BB1X1 U882 ( .A0N(n211), .A1N(res_rd), .B0(n210), .Y(n375) );
  OAI2BB2XL U883 ( .B0(n613), .B1(n311), .A0N(n66), .A1N(n81), .Y(n350) );
  NAND4X1 U884 ( .A(N221), .B(N222), .C(n534), .D(n186), .Y(n182) );
  NOR4X1 U885 ( .A(n335), .B(n336), .C(n337), .D(n338), .Y(n186) );
  OAI222X4 U886 ( .A0(n349), .A1(n39), .B0(n46), .B1(n627), .C0(n48), .C1(n38), 
        .Y(res_do[0]) );
  XNOR2X1 U887 ( .A(n453), .B(\sub_152/carry[13] ), .Y(N219) );
  OR2X1 U888 ( .A(n527), .B(\sub_152/carry[12] ), .Y(\sub_152/carry[13] ) );
  XNOR2X1 U889 ( .A(\sub_152/carry[12] ), .B(n527), .Y(N218) );
  OR2X1 U890 ( .A(n526), .B(\sub_152/carry[11] ), .Y(\sub_152/carry[12] ) );
  XNOR2X1 U891 ( .A(\sub_152/carry[11] ), .B(n526), .Y(N217) );
  OR2X1 U892 ( .A(n519), .B(\sub_152/carry[10] ), .Y(\sub_152/carry[11] ) );
  XNOR2X1 U893 ( .A(\sub_152/carry[10] ), .B(n519), .Y(N216) );
  OR2X1 U894 ( .A(n520), .B(\sub_152/carry[9] ), .Y(\sub_152/carry[10] ) );
  XNOR2X1 U895 ( .A(\sub_152/carry[9] ), .B(n520), .Y(N215) );
  OR2X1 U896 ( .A(n521), .B(\sub_152/carry[8] ), .Y(\sub_152/carry[9] ) );
  XNOR2X1 U897 ( .A(\sub_152/carry[8] ), .B(n521), .Y(N214) );
  AND2X1 U898 ( .A(\sub_152/carry[7] ), .B(n517), .Y(\sub_152/carry[8] ) );
  XOR2X1 U899 ( .A(n517), .B(\sub_152/carry[7] ), .Y(N213) );
  OR2X1 U900 ( .A(n522), .B(\sub_152/carry[6] ), .Y(\sub_152/carry[7] ) );
  XNOR2X1 U901 ( .A(\sub_152/carry[6] ), .B(n522), .Y(N212) );
  OR2X1 U902 ( .A(n523), .B(\sub_152/carry[5] ), .Y(\sub_152/carry[6] ) );
  XNOR2X1 U903 ( .A(\sub_152/carry[5] ), .B(n523), .Y(N211) );
  OR2X1 U904 ( .A(n524), .B(\sub_152/carry[4] ), .Y(\sub_152/carry[5] ) );
  XNOR2X1 U905 ( .A(\sub_152/carry[4] ), .B(n524), .Y(N210) );
  OR2X1 U906 ( .A(n525), .B(\sub_152/carry[3] ), .Y(\sub_152/carry[4] ) );
  XNOR2X1 U907 ( .A(\sub_152/carry[3] ), .B(n525), .Y(N209) );
  OR2X1 U908 ( .A(n528), .B(\sub_152/carry[2] ), .Y(\sub_152/carry[3] ) );
  XNOR2X1 U909 ( .A(\sub_152/carry[2] ), .B(n528), .Y(N208) );
  OR2X1 U910 ( .A(n531), .B(n533), .Y(\sub_152/carry[2] ) );
  XNOR2X1 U911 ( .A(n533), .B(n531), .Y(N207) );
  XOR2X1 U912 ( .A(n453), .B(\add_161/carry[13] ), .Y(N317) );
  AND2X1 U913 ( .A(\add_161/carry[12] ), .B(n527), .Y(\add_161/carry[13] ) );
  XOR2X1 U914 ( .A(n527), .B(\add_161/carry[12] ), .Y(N316) );
  AND2X1 U915 ( .A(\add_161/carry[11] ), .B(n526), .Y(\add_161/carry[12] ) );
  XOR2X1 U916 ( .A(n526), .B(\add_161/carry[11] ), .Y(N315) );
  AND2X1 U917 ( .A(\add_161/carry[10] ), .B(n519), .Y(\add_161/carry[11] ) );
  XOR2X1 U918 ( .A(n519), .B(\add_161/carry[10] ), .Y(N314) );
  AND2X1 U919 ( .A(\add_161/carry[9] ), .B(n520), .Y(\add_161/carry[10] ) );
  XOR2X1 U920 ( .A(n520), .B(\add_161/carry[9] ), .Y(N313) );
  AND2X1 U921 ( .A(\add_161/carry[8] ), .B(n521), .Y(\add_161/carry[9] ) );
  XOR2X1 U922 ( .A(n521), .B(\add_161/carry[8] ), .Y(N312) );
  OR2X1 U923 ( .A(n517), .B(\add_161/carry[7] ), .Y(\add_161/carry[8] ) );
  XNOR2X1 U924 ( .A(\add_161/carry[7] ), .B(n517), .Y(N311) );
  AND2X1 U925 ( .A(\add_161/carry[6] ), .B(n522), .Y(\add_161/carry[7] ) );
  XOR2X1 U926 ( .A(n522), .B(\add_161/carry[6] ), .Y(N310) );
  AND2X1 U927 ( .A(\add_161/carry[5] ), .B(n523), .Y(\add_161/carry[6] ) );
  XOR2X1 U928 ( .A(n523), .B(\add_161/carry[5] ), .Y(N309) );
  AND2X1 U929 ( .A(\add_161/carry[4] ), .B(n524), .Y(\add_161/carry[5] ) );
  XOR2X1 U930 ( .A(n524), .B(\add_161/carry[4] ), .Y(N308) );
  AND2X1 U931 ( .A(\add_161/carry[3] ), .B(n525), .Y(\add_161/carry[4] ) );
  XOR2X1 U932 ( .A(n525), .B(\add_161/carry[3] ), .Y(N307) );
  AND2X1 U933 ( .A(\add_161/carry[2] ), .B(n528), .Y(\add_161/carry[3] ) );
  XOR2X1 U934 ( .A(n528), .B(\add_161/carry[2] ), .Y(N306) );
  AND2X1 U935 ( .A(n533), .B(n531), .Y(\add_161/carry[2] ) );
  XOR2X1 U936 ( .A(n531), .B(n533), .Y(N305) );
  XOR2X1 U937 ( .A(n453), .B(\add_160/carry [13]), .Y(N303) );
  AND2X1 U938 ( .A(\add_160/carry [12]), .B(n527), .Y(\add_160/carry [13]) );
  XOR2X1 U939 ( .A(n527), .B(\add_160/carry [12]), .Y(N302) );
  AND2X1 U940 ( .A(\add_160/carry [11]), .B(n526), .Y(\add_160/carry [12]) );
  XOR2X1 U941 ( .A(n526), .B(\add_160/carry [11]), .Y(N301) );
  AND2X1 U942 ( .A(\add_160/carry [10]), .B(n519), .Y(\add_160/carry [11]) );
  XOR2X1 U943 ( .A(n519), .B(\add_160/carry [10]), .Y(N300) );
  AND2X1 U944 ( .A(\add_160/carry [9]), .B(n520), .Y(\add_160/carry [10]) );
  XOR2X1 U945 ( .A(n520), .B(\add_160/carry [9]), .Y(N299) );
  AND2X1 U946 ( .A(n517), .B(n521), .Y(\add_160/carry [9]) );
  XOR2X1 U947 ( .A(n521), .B(n517), .Y(N298) );
  XOR2X1 U948 ( .A(n453), .B(\add_159/carry[13] ), .Y(N289) );
  AND2X1 U949 ( .A(\add_159/carry[12] ), .B(n527), .Y(\add_159/carry[13] ) );
  XOR2X1 U950 ( .A(n527), .B(\add_159/carry[12] ), .Y(N288) );
  AND2X1 U951 ( .A(\add_159/carry[11] ), .B(n526), .Y(\add_159/carry[12] ) );
  XOR2X1 U952 ( .A(n526), .B(\add_159/carry[11] ), .Y(N287) );
  AND2X1 U953 ( .A(\add_159/carry[10] ), .B(n519), .Y(\add_159/carry[11] ) );
  XOR2X1 U954 ( .A(n519), .B(\add_159/carry[10] ), .Y(N286) );
  AND2X1 U955 ( .A(\add_159/carry[9] ), .B(n520), .Y(\add_159/carry[10] ) );
  XOR2X1 U956 ( .A(n520), .B(\add_159/carry[9] ), .Y(N285) );
  AND2X1 U957 ( .A(\add_159/carry[8] ), .B(n521), .Y(\add_159/carry[9] ) );
  XOR2X1 U958 ( .A(n521), .B(\add_159/carry[8] ), .Y(N284) );
  AND2X1 U959 ( .A(\add_159/carry[7] ), .B(n517), .Y(\add_159/carry[8] ) );
  XOR2X1 U960 ( .A(n517), .B(\add_159/carry[7] ), .Y(N283) );
  OR2X1 U961 ( .A(n522), .B(\add_159/carry[6] ), .Y(\add_159/carry[7] ) );
  XNOR2X1 U962 ( .A(\add_159/carry[6] ), .B(n522), .Y(N282) );
  OR2X1 U963 ( .A(n523), .B(\add_159/carry[5] ), .Y(\add_159/carry[6] ) );
  XNOR2X1 U964 ( .A(\add_159/carry[5] ), .B(n523), .Y(N281) );
  OR2X1 U965 ( .A(n524), .B(\add_159/carry[4] ), .Y(\add_159/carry[5] ) );
  XNOR2X1 U966 ( .A(\add_159/carry[4] ), .B(n524), .Y(N280) );
  OR2X1 U967 ( .A(n525), .B(\add_159/carry[3] ), .Y(\add_159/carry[4] ) );
  XNOR2X1 U968 ( .A(\add_159/carry[3] ), .B(n525), .Y(N279) );
  OR2X1 U969 ( .A(n528), .B(\add_159/carry[2] ), .Y(\add_159/carry[3] ) );
  XNOR2X1 U970 ( .A(\add_159/carry[2] ), .B(n528), .Y(N278) );
  OR2X1 U971 ( .A(n531), .B(n533), .Y(\add_159/carry[2] ) );
  XNOR2X1 U972 ( .A(n533), .B(n531), .Y(N277) );
  XNOR2X1 U973 ( .A(n453), .B(\sub_154/carry[13] ), .Y(N247) );
  OR2X1 U974 ( .A(n527), .B(\sub_154/carry[12] ), .Y(\sub_154/carry[13] ) );
  XNOR2X1 U975 ( .A(\sub_154/carry[12] ), .B(n527), .Y(N246) );
  OR2X1 U976 ( .A(n526), .B(\sub_154/carry[11] ), .Y(\sub_154/carry[12] ) );
  XNOR2X1 U977 ( .A(\sub_154/carry[11] ), .B(n526), .Y(N245) );
  OR2X1 U978 ( .A(n519), .B(\sub_154/carry[10] ), .Y(\sub_154/carry[11] ) );
  XNOR2X1 U979 ( .A(\sub_154/carry[10] ), .B(n519), .Y(N244) );
  OR2X1 U980 ( .A(n520), .B(\sub_154/carry[9] ), .Y(\sub_154/carry[10] ) );
  XNOR2X1 U981 ( .A(\sub_154/carry[9] ), .B(n520), .Y(N243) );
  OR2X1 U982 ( .A(n521), .B(\sub_154/carry[8] ), .Y(\sub_154/carry[9] ) );
  XNOR2X1 U983 ( .A(\sub_154/carry[8] ), .B(n521), .Y(N242) );
  OR2X1 U984 ( .A(n517), .B(\sub_154/carry[7] ), .Y(\sub_154/carry[8] ) );
  XNOR2X1 U985 ( .A(\sub_154/carry[7] ), .B(n517), .Y(N241) );
  AND2X1 U986 ( .A(\sub_154/carry[6] ), .B(n522), .Y(\sub_154/carry[7] ) );
  XOR2X1 U987 ( .A(n522), .B(\sub_154/carry[6] ), .Y(N240) );
  AND2X1 U988 ( .A(\sub_154/carry[5] ), .B(n523), .Y(\sub_154/carry[6] ) );
  XOR2X1 U989 ( .A(n523), .B(\sub_154/carry[5] ), .Y(N239) );
  AND2X1 U990 ( .A(\sub_154/carry[4] ), .B(n524), .Y(\sub_154/carry[5] ) );
  XOR2X1 U991 ( .A(n524), .B(\sub_154/carry[4] ), .Y(N238) );
  AND2X1 U992 ( .A(\sub_154/carry[3] ), .B(n525), .Y(\sub_154/carry[4] ) );
  XOR2X1 U993 ( .A(n525), .B(\sub_154/carry[3] ), .Y(N237) );
  AND2X1 U994 ( .A(\sub_154/carry[2] ), .B(n528), .Y(\sub_154/carry[3] ) );
  XOR2X1 U995 ( .A(n528), .B(\sub_154/carry[2] ), .Y(N236) );
  AND2X1 U996 ( .A(n533), .B(n531), .Y(\sub_154/carry[2] ) );
  XOR2X1 U997 ( .A(n531), .B(n533), .Y(N235) );
  XNOR2X1 U998 ( .A(n453), .B(\sub_153/carry [13]), .Y(N233) );
  OR2X1 U999 ( .A(n527), .B(\sub_153/carry [12]), .Y(\sub_153/carry [13]) );
  XNOR2X1 U1000 ( .A(\sub_153/carry [12]), .B(n527), .Y(N232) );
  OR2X1 U1001 ( .A(n526), .B(\sub_153/carry [11]), .Y(\sub_153/carry [12]) );
  XNOR2X1 U1002 ( .A(\sub_153/carry [11]), .B(n526), .Y(N231) );
  OR2X1 U1003 ( .A(n519), .B(\sub_153/carry [10]), .Y(\sub_153/carry [11]) );
  XNOR2X1 U1004 ( .A(\sub_153/carry [10]), .B(n519), .Y(N230) );
  OR2X1 U1005 ( .A(n520), .B(\sub_153/carry [9]), .Y(\sub_153/carry [10]) );
  XNOR2X1 U1006 ( .A(\sub_153/carry [9]), .B(n520), .Y(N229) );
  OR2X1 U1007 ( .A(n521), .B(n517), .Y(\sub_153/carry [9]) );
  XNOR2X1 U1008 ( .A(n517), .B(n521), .Y(N228) );
  XNOR2X1 U1009 ( .A(n453), .B(\sub_182/carry[13] ), .Y(N391) );
  OR2X1 U1010 ( .A(n527), .B(\sub_182/carry[12] ), .Y(\sub_182/carry[13] ) );
  XNOR2X1 U1011 ( .A(\sub_182/carry[12] ), .B(n527), .Y(N390) );
  OR2X1 U1012 ( .A(n526), .B(\sub_182/carry[11] ), .Y(\sub_182/carry[12] ) );
  XNOR2X1 U1013 ( .A(\sub_182/carry[11] ), .B(n526), .Y(N389) );
  OR2X1 U1014 ( .A(n519), .B(\sub_182/carry[10] ), .Y(\sub_182/carry[11] ) );
  XNOR2X1 U1015 ( .A(\sub_182/carry[10] ), .B(n519), .Y(N388) );
  OR2X1 U1016 ( .A(n520), .B(\sub_182/carry[9] ), .Y(\sub_182/carry[10] ) );
  XNOR2X1 U1017 ( .A(\sub_182/carry[9] ), .B(n520), .Y(N387) );
  OR2X1 U1018 ( .A(n521), .B(\sub_182/carry[8] ), .Y(\sub_182/carry[9] ) );
  XNOR2X1 U1019 ( .A(\sub_182/carry[8] ), .B(n521), .Y(N386) );
  OR2X1 U1020 ( .A(n517), .B(\sub_182/carry[7] ), .Y(\sub_182/carry[8] ) );
  XNOR2X1 U1021 ( .A(\sub_182/carry[7] ), .B(n517), .Y(N385) );
  OR2X1 U1022 ( .A(n522), .B(\sub_182/carry[6] ), .Y(\sub_182/carry[7] ) );
  XNOR2X1 U1023 ( .A(\sub_182/carry[6] ), .B(n522), .Y(N384) );
  OR2X1 U1024 ( .A(n523), .B(\sub_182/carry[5] ), .Y(\sub_182/carry[6] ) );
  XNOR2X1 U1025 ( .A(\sub_182/carry[5] ), .B(n523), .Y(N383) );
  OR2X1 U1026 ( .A(n524), .B(\sub_182/carry[4] ), .Y(\sub_182/carry[5] ) );
  XNOR2X1 U1027 ( .A(\sub_182/carry[4] ), .B(n524), .Y(N382) );
  OR2X1 U1028 ( .A(n525), .B(\sub_182/carry[3] ), .Y(\sub_182/carry[4] ) );
  XNOR2X1 U1029 ( .A(\sub_182/carry[3] ), .B(n525), .Y(N381) );
  XOR2X1 U1030 ( .A(n453), .B(\add_174/carry[13] ), .Y(N348) );
  AND2X1 U1031 ( .A(\add_174/carry[12] ), .B(n527), .Y(\add_174/carry[13] ) );
  XOR2X1 U1032 ( .A(n527), .B(\add_174/carry[12] ), .Y(N347) );
  AND2X1 U1033 ( .A(\add_174/carry[11] ), .B(n526), .Y(\add_174/carry[12] ) );
  XOR2X1 U1034 ( .A(n526), .B(\add_174/carry[11] ), .Y(N346) );
  AND2X1 U1035 ( .A(\add_174/carry[10] ), .B(n519), .Y(\add_174/carry[11] ) );
  XOR2X1 U1036 ( .A(n519), .B(\add_174/carry[10] ), .Y(N345) );
  AND2X1 U1037 ( .A(\add_174/carry[9] ), .B(n520), .Y(\add_174/carry[10] ) );
  XOR2X1 U1038 ( .A(n520), .B(\add_174/carry[9] ), .Y(N344) );
  AND2X1 U1039 ( .A(\add_174/carry[8] ), .B(n521), .Y(\add_174/carry[9] ) );
  XOR2X1 U1040 ( .A(n521), .B(\add_174/carry[8] ), .Y(N343) );
  AND2X1 U1041 ( .A(\add_174/carry[7] ), .B(n517), .Y(\add_174/carry[8] ) );
  XOR2X1 U1042 ( .A(n517), .B(\add_174/carry[7] ), .Y(N342) );
  AND2X1 U1043 ( .A(\add_174/carry[6] ), .B(n522), .Y(\add_174/carry[7] ) );
  XOR2X1 U1044 ( .A(n522), .B(\add_174/carry[6] ), .Y(N341) );
  AND2X1 U1045 ( .A(\add_174/carry[5] ), .B(n523), .Y(\add_174/carry[6] ) );
  XOR2X1 U1046 ( .A(n523), .B(\add_174/carry[5] ), .Y(N340) );
  AND2X1 U1047 ( .A(\add_174/carry[4] ), .B(n524), .Y(\add_174/carry[5] ) );
  XOR2X1 U1048 ( .A(n524), .B(\add_174/carry[4] ), .Y(N339) );
  AND2X1 U1049 ( .A(\add_174/carry[3] ), .B(n525), .Y(\add_174/carry[4] ) );
  XOR2X1 U1050 ( .A(n525), .B(\add_174/carry[3] ), .Y(N338) );
  OR2X1 U1051 ( .A(n528), .B(\sub_182/carry[2] ), .Y(\sub_182/carry[3] ) );
  XNOR2X1 U1052 ( .A(\sub_182/carry[2] ), .B(n528), .Y(N380) );
  AND2X1 U1053 ( .A(\add_174/carry[2] ), .B(n528), .Y(\add_174/carry[3] ) );
  XOR2X1 U1054 ( .A(n528), .B(\add_174/carry[2] ), .Y(N337) );
  AND2X1 U1055 ( .A(n533), .B(n531), .Y(\sub_182/carry[2] ) );
  XOR2X1 U1056 ( .A(n531), .B(n533), .Y(N379) );
  OR2X1 U1057 ( .A(n531), .B(n533), .Y(\add_174/carry[2] ) );
  XNOR2X1 U1058 ( .A(n533), .B(n531), .Y(N336) );
  OAI22XL U1059 ( .A0(val1[3]), .A1(n438), .B0(val1[3]), .B1(n545), .Y(n551)
         );
  OA22X1 U1060 ( .A0(n544), .A1(val1[3]), .B0(n544), .B1(n438), .Y(n547) );
  NOR2BX1 U1061 ( .AN(val1[4]), .B(val2[4]), .Y(n548) );
  OAI22XL U1062 ( .A0(n548), .A1(n441), .B0(val1[5]), .B1(n548), .Y(n549) );
  AOI2BB2X1 U1063 ( .B0(n558), .B1(val4[0]), .A0N(val3[1]), .A1N(n661), .Y(
        n560) );
  NOR2BX1 U1064 ( .AN(val3[4]), .B(val4[4]), .Y(n562) );
  OAI22XL U1065 ( .A0(cmp1[3]), .A1(n584), .B0(cmp1[3]), .B1(n573), .Y(n579)
         );
  OA22X1 U1066 ( .A0(n571), .A1(cmp1[3]), .B0(n571), .B1(n584), .Y(n575) );
  OAI22XL U1067 ( .A0(n576), .A1(n455), .B0(cmp1[5]), .B1(n576), .Y(n577) );
  OAI221XL U1068 ( .A0(cmp2[6]), .A1(n586), .B0(n579), .B1(n578), .C0(n577), 
        .Y(n580) );
  AO22X1 U1069 ( .A0(n585), .A1(cmp1[7]), .B0(n581), .B1(n580), .Y(n582) );
  NAND2BX1 U1070 ( .AN(\lt_86/A[2] ), .B(mid_val[2]), .Y(n591) );
  OAI22XL U1071 ( .A0(\lt_86/A[3] ), .A1(n601), .B0(\lt_86/A[3] ), .B1(n591), 
        .Y(n597) );
  NOR2BX1 U1072 ( .AN(\lt_86/A[2] ), .B(mid_val[2]), .Y(n589) );
  OA22X1 U1073 ( .A0(n589), .A1(\lt_86/A[3] ), .B0(n589), .B1(n601), .Y(n593)
         );
  NOR2BX1 U1074 ( .AN(\lt_86/A[4] ), .B(mid_val[4]), .Y(n594) );
  AOI21X1 U1075 ( .A0(n529), .A1(n532), .B0(state[4]), .Y(N505) );
endmodule

