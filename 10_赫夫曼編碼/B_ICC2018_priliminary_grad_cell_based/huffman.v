module huffman(clk, reset, gray_data, gray_valid, CNT_valid, CNT1, CNT2, CNT3, CNT4, CNT5, CNT6, code_valid, HC1, HC2, HC3, HC4, HC5, HC6, M1, M2, M3, M4, M5, M6);

input               clk;
input               reset;
input               gray_valid;
input       [7:0]   gray_data;
output              CNT_valid;
output reg  [7:0]   CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
output              code_valid;
output reg  [7:0]   HC1, HC2, HC3, HC4, HC5, HC6;
output reg  [7:0]   M1, M2, M3, M4, M5, M6;


// {symbol, probability} = {8, 8}
reg         [15:0]  symb1, symb2, symb3, symb4, symb5, symb6;      

// {cnt, symbols, probability} = {3, ?, 8}
reg         [26:0]  c1_symb1, c1_symb2, c1_symb3, c1_symb4, c1_symb5;      
reg         [34:0]  c2_symb1, c2_symb2, c2_symb3, c2_symb4;      
reg         [42:0]  c3_symb1, c3_symb2, c3_symb3;      
reg         [50:0]  c4_symb1, c4_symb2;      

reg         [2:0]   cntA;
reg         [2:0]   cntB;

reg         [7:0]   index;

reg         [2:0]   cnt_sort;       // counter of bubble sort

wire        [7:0]   buff_M1, buff_M2, buff_M3, buff_M4, buff_M5, buff_M6;

reg         [4:0]   state;
reg         [4:0]   nstate;


parameter IDLE = 0,
            READ_GRAY   = 1,
            PREP_C0     = 2,
            SORT_C0     = 3,
            CALC_C0_A   = 4,
            CALC_C0_B   = 5,
            PREP_C1     = 6,
            SORT_C1     = 7,
            CALC_C1_A   = 8,
            CALC_C1_B   = 9,
            PREP_C2     = 10,
            SORT_C2     = 11,
            CALC_C2_A   = 12,
            CALC_C2_B   = 13,
            PREP_C3     = 14,
            SORT_C3     = 15,
            CALC_C3_A   = 16,
            CALC_C3_B   = 17,
            PREP_C4     = 18,
            SORT_C4     = 19,
            CALC_C4_A   = 20,
            CALC_C4_B   = 21,
            PRE_FINISH  = 30,
            FINISH      = 31;


integer i;


assign CNT_valid = (state == PREP_C0) ? 1'b1 : 1'b0;
assign code_valid = (state == FINISH) ? 1'b1 : 1'b0;

convert u_conv1(.M(M1), .buffM(buff_M1));
convert u_conv2(.M(M2), .buffM(buff_M2));
convert u_conv3(.M(M3), .buffM(buff_M3));
convert u_conv4(.M(M4), .buffM(buff_M4));
convert u_conv5(.M(M5), .buffM(buff_M5));
convert u_conv6(.M(M6), .buffM(buff_M6));

// COUNTER  ==================================================================================
always @(posedge clk or posedge reset) begin : counter_of_gray_data
    if (reset) begin
        CNT1 <= 8'b0;
        CNT2 <= 8'b0;
        CNT3 <= 8'b0;
        CNT4 <= 8'b0;
        CNT5 <= 8'b0;
        CNT6 <= 8'b0;
    end
    else begin
        if (gray_valid) begin
            case(gray_data)
                8'h01 : CNT1 <= CNT1 + 8'b1;
                8'h02 : CNT2 <= CNT2 + 8'b1;
                8'h03 : CNT3 <= CNT3 + 8'b1;
                8'h04 : CNT4 <= CNT4 + 8'b1;
                8'h05 : CNT5 <= CNT5 + 8'b1;
                8'h06 : CNT6 <= CNT6 + 8'b1;
            endcase
        end
    end
end


always @(posedge clk or posedge reset) begin : counter_of_sorting
    if (reset) begin
        cnt_sort <= 3'b0;
    end
    else begin
        if (nstate == CALC_C0_A || nstate == CALC_C1_A || nstate == CALC_C2_A || nstate == CALC_C3_A) begin
            cnt_sort <= 3'b0;
        end
        else if (state == SORT_C0 || state == SORT_C1 || state == SORT_C2 || state == SORT_C3 || state == SORT_C4) begin
            cnt_sort <=cnt_sort + 3'b1;
        end
    end
end

always @(posedge clk or posedge reset) begin : cntA_and_cntB
    if (reset) begin
        cntA <= 3'b0;
        cntB <= 3'b0;
    end
    else begin
        if (state == PREP_C1 || state == PREP_C2 || state == PREP_C3 || state == PREP_C4) begin
            cntA <= 3'b0;
            cntB <= 3'b0;
        end
        else if (state == CALC_C1_A || state == CALC_C2_A || state == CALC_C3_A || state == CALC_C4_A) begin
            cntA <= cntA + 3'b1;
        end
        else if (state == CALC_C1_B || state == CALC_C2_B || state == CALC_C3_B || state == CALC_C4_B) begin
            cntB <= cntB + 3'b1;
        end
    end
end

// SORT C0 ==================================================================================
always @(posedge clk or posedge reset) begin : sorting_C0
    if (reset) begin
        symb1 <= 16'h0;
        symb2 <= 16'h0;
        symb3 <= 16'h0;
        symb4 <= 16'h0;
        symb5 <= 16'h0;
        symb6 <= 16'h0;
    end
    else begin
        if (state == PREP_C0) begin
            symb1 <= {8'h01, CNT1};
            symb2 <= {8'h02, CNT2};
            symb3 <= {8'h03, CNT3};
            symb4 <= {8'h04, CNT4};
            symb5 <= {8'h05, CNT5};
            symb6 <= {8'h06, CNT6};
        end
        else if (state == SORT_C0) begin
            if (cnt_sort[0]) begin
                symb1 <= (symb1[7:0] < symb2[7:0]) ? symb2 : symb1;
                symb2 <= (symb1[7:0] < symb2[7:0]) ? symb1 : symb2;
                
                symb3 <= (symb3[7:0] < symb4[7:0]) ? symb4 : symb3;
                symb4 <= (symb3[7:0] < symb4[7:0]) ? symb3 : symb4;
                
                symb5 <= (symb5[7:0] < symb6[7:0]) ? symb6 : symb5;
                symb6 <= (symb5[7:0] < symb6[7:0]) ? symb5 : symb6;
            end
            else begin
                symb2 <= (symb2[7:0] < symb3[7:0]) ? symb3 : symb2;
                symb3 <= (symb2[7:0] < symb3[7:0]) ? symb2 : symb3;
                
                symb4 <= (symb4[7:0] < symb5[7:0]) ? symb5 : symb4;
                symb5 <= (symb4[7:0] < symb5[7:0]) ? symb4 : symb5;
            end
        end
    end
end
wire [7:0] s1 = c1_symb3[7:0];
wire [7:0] s2 = c1_symb4[7:0];
// SORT C1 ==================================================================================
always @(posedge clk or posedge reset) begin : sorting_C1
    if (reset) begin
        c1_symb1 <= 27'b0;
        c1_symb2 <= 27'b0;
        c1_symb3 <= 27'b0;
        c1_symb4 <= 27'b0;
        c1_symb5 <= 27'b0;
    end
    else begin
        if (state == PREP_C1) begin
            c1_symb1 <= {3'd1, 8'b0, symb1};
            c1_symb2 <= {3'd1, 8'b0, symb2};
            c1_symb3 <= {3'd1, 8'b0, symb3};
            c1_symb4 <= {3'd1, 8'b0, symb4};

            c1_symb5[26:24] <= 3'd2;
            c1_symb5[23:8] <= {symb5[15:8], symb6[15:8]};
            c1_symb5[7:0] <= symb5[7:0] + symb6[7:0];
        end
        else if (state == SORT_C1) begin
            if (cnt_sort[0]) begin
               c1_symb1 <= (c1_symb1[7:0] < c1_symb2[7:0]) ? c1_symb2 : c1_symb1;
               c1_symb2 <= (c1_symb1[7:0] < c1_symb2[7:0]) ? c1_symb1 : c1_symb2;
               
               c1_symb3 <= (c1_symb3[7:0] < c1_symb4[7:0]) ? c1_symb4 : c1_symb3;
               c1_symb4 <= (c1_symb3[7:0] < c1_symb4[7:0]) ? c1_symb3 : c1_symb4;
            end
            else begin
               c1_symb2 <= (c1_symb2[7:0] < c1_symb3[7:0]) ? c1_symb3 : c1_symb2;
               c1_symb3 <= (c1_symb2[7:0] < c1_symb3[7:0]) ? c1_symb2 : c1_symb3;

               c1_symb4 <= (c1_symb4[7:0] < c1_symb5[7:0]) ? c1_symb5 : c1_symb4;
               c1_symb5 <= (c1_symb4[7:0] < c1_symb5[7:0]) ? c1_symb4 : c1_symb5;
            end
        end
    end
end

// SORT C2 ==================================================================================
always @(posedge clk or posedge reset) begin : sorting_C2
    if (reset) begin
        c2_symb1 <= 35'b0;
        c2_symb2 <= 35'b0;
        c2_symb3 <= 35'b0;
        c2_symb4 <= 35'b0;
    end
    else begin
        if (state == PREP_C2) begin
            c2_symb1 <= {c1_symb1[26:24], 8'b0, c1_symb1[23:0]};
            c2_symb2 <= {c1_symb2[26:24], 8'b0, c1_symb2[23:0]};
            c2_symb3 <= {c1_symb3[26:24], 8'b0, c1_symb3[23:0]};

            c2_symb4[34:32] <= c1_symb4[26:24] + c1_symb5[26:24];
            c2_symb4[7:0] <= c1_symb4[7:0] + c1_symb5[7:0];
            //c2_symb4[31:8] <= {c1_symb4[23:8], c1_symb5[15:8]};
            
            case({c1_symb4[26:24], c1_symb5[26:24]})
                {3'd1, 3'd1}    : c2_symb4[31:8] <= {8'b0, c1_symb4[15:8], c1_symb5[15:8]};
                {3'd1, 3'd2}    : c2_symb4[31:8] <= {c1_symb4[15:8], c1_symb5[23:8]};
                {3'd2, 3'd1}    : c2_symb4[31:8] <= {c1_symb4[23:8], c1_symb5[15:8]};
                default         : c2_symb4[31:8] <= c2_symb4[31:8];
            endcase
        end
        else if (state == SORT_C2) begin
            if (~cnt_sort[0]) begin
                c2_symb1 <= {c2_symb1[7:0] < c2_symb2[7:0]} ? c2_symb2 : c2_symb1;
                c2_symb2 <= {c2_symb1[7:0] < c2_symb2[7:0]} ? c2_symb1 : c2_symb2;
                
                c2_symb3 <= {c2_symb3[7:0] < c2_symb4[7:0]} ? c2_symb4 : c2_symb3;
                c2_symb4 <= {c2_symb3[7:0] < c2_symb4[7:0]} ? c2_symb3 : c2_symb4;
            end
            else begin
                c2_symb2 <= {c2_symb2[7:0] < c2_symb3[7:0]} ? c2_symb3 : c2_symb2;
                c2_symb3 <= {c2_symb2[7:0] < c2_symb3[7:0]} ? c2_symb2 : c2_symb3;
            end
        end
    end
end

// SORT C3 ==================================================================================
always @(posedge clk or posedge reset) begin
    if (reset) begin
        c3_symb1 <= 43'b0;
        c3_symb2 <= 43'b0;
        c3_symb3 <= 43'b0;
    end
    else begin
        if (state == PREP_C3) begin
            c3_symb1 <= {c2_symb1[34:32], 8'b0, c2_symb1[31:0]};
            c3_symb2 <= {c2_symb2[34:32], 8'b0, c2_symb2[31:0]};

            c3_symb3[42:40] <= c2_symb3[34:32] + c2_symb4[34:32];
            c3_symb3[7:0]   <= c2_symb3[7:0] + c2_symb4[7:0];

            //c3_symb3[39:8] <= {c2_symb3[23:8], c2_symb4[23:8]};
            case({c2_symb3[34:32], c2_symb4[34:32]})
                {3'd1, 3'd1}    : c3_symb3[39:8] <= {16'b0, c2_symb3[15:8], c2_symb4[15:8]};
                {3'd1, 3'd2}    : c3_symb3[39:8] <= {8'b0, c2_symb3[15:8], c2_symb4[23:8]};
                {3'd2, 3'd1}    : c3_symb3[39:8] <= {8'b0, c2_symb3[23:8], c2_symb4[15:8]};
                {3'd3, 3'd1}    : c3_symb3[39:8] <= {c2_symb3[31:8], c2_symb4[15:8]};
                {3'd1, 3'd3}    : c3_symb3[39:8] <= {c2_symb3[15:8], c2_symb4[31:8]};
                {3'd2, 3'd2}    : c3_symb3[39:8] <= {c2_symb3[23:8], c2_symb4[23:8]};
                default         : c3_symb3[39:8] <= c3_symb3[39:8];
            endcase
        end
        else if (state == SORT_C3) begin
            if (cnt_sort[0]) begin
                c3_symb1 <= (c3_symb1 [7:0] < c3_symb2[7:0]) ? c3_symb2 : c3_symb1;
                c3_symb2 <= (c3_symb1 [7:0] < c3_symb2[7:0]) ? c3_symb1 : c3_symb2;
            end
            else begin
                c3_symb2 <= (c3_symb2 [7:0] < c3_symb3[7:0]) ? c3_symb3 : c3_symb2;
                c3_symb3 <= (c3_symb2 [7:0] < c3_symb3[7:0]) ? c3_symb2 : c3_symb3;
            end
        end
    end
end


// SORT C4 ==================================================================================
always @(posedge clk or posedge reset) begin
    if (reset) begin
        c4_symb1 <= 51'b0;
        c4_symb2 <= 51'b0;
    end
    else begin
        if (state == PREP_C4) begin
            c4_symb1 <= {c3_symb1[42:40], 8'b0, c3_symb1[39:0]};

            c4_symb2[50:48] <= c3_symb2[42:40] + c3_symb3[42:40];
            c4_symb2[7:0]   <= c3_symb2[7:0]   + c3_symb3[7:0];

            //c4_symb2[39:8]  <= {c3_symb2[39:8], c3_symb3[39:8]};
            case({c3_symb2[42:40], c3_symb3[42:40]})
                {3'd1, 3'd1}    : c4_symb2[47:8] <= {24'b0, c3_symb2[15:8], c3_symb3[15:8]};
                {3'd1, 3'd2}    : c4_symb2[47:8] <= {16'b0, c3_symb2[15:8], c3_symb3[23:8]};
                {3'd1, 3'd3}    : c4_symb2[47:8] <= { 8'b0, c3_symb2[15:8], c3_symb3[31:8]};
                {3'd1, 3'd4}    : c4_symb2[47:8] <=        {c3_symb2[15:8], c3_symb3[39:8]};
                {3'd2, 3'd1}    : c4_symb2[47:8] <= {16'b0, c3_symb2[23:8], c3_symb3[15:8]};
                {3'd2, 3'd2}    : c4_symb2[47:8] <= { 8'b0, c3_symb2[23:8], c3_symb3[23:8]};
                {3'd2, 3'd3}    : c4_symb2[47:8] <=        {c3_symb2[23:8], c3_symb3[31:8]};
                {3'd3, 3'd1}    : c4_symb2[47:8] <= { 8'b0, c3_symb2[31:8], c3_symb3[15:8]};
                {3'd3, 3'd2}    : c4_symb2[47:8] <=        {c3_symb2[31:8], c3_symb3[23:8]};
                {3'd4, 3'd1}    : c4_symb2[47:8] <=        {c3_symb2[39:8], c3_symb3[15:8]};
                default         : c4_symb2[47:8] <= c4_symb2[47:8];
            endcase
        end
        else if (state == SORT_C4) begin
            c4_symb1 <= (c4_symb1 [7:0] < c4_symb2[7:0]) ? c4_symb2 : c4_symb1;
            c4_symb2 <= (c4_symb1 [7:0] < c4_symb2[7:0]) ? c4_symb1 : c4_symb2;
        end
    end
end

// INDEX ==================================================================================
always @(*) begin
    case(state) 
        CALC_C0_A   : index = symb5[15:8];
        CALC_C0_B   : index = symb6[15:8];
        CALC_C1_A   : index = (cntA == 3'b1) ? c1_symb4[23:16] : c1_symb4[15:8];
        CALC_C1_B   : index = (cntB == 3'b1) ? c1_symb5[23:16] : c1_symb5[15:8];
        CALC_C2_A   : begin
            case(cntA)
                3'd0    : index = c2_symb3[15:8];
                3'd1    : index = c2_symb3[23:16];
                3'd2    : index = c2_symb3[31:24];
                default : index = 8'hff;
            endcase
        end
        CALC_C2_B   : begin
            case(cntB)
                3'd0    : index = c2_symb4[15:8];
                3'd1    : index = c2_symb4[23:16];
                3'd2    : index = c2_symb4[31:24];
                default : index = 8'hff;
            endcase
        end
        CALC_C3_A   : begin
            case(cntA)
                3'd0    : index = c3_symb2[15:8];
                3'd1    : index = c3_symb2[23:16];
                3'd2    : index = c3_symb2[31:24];
                3'd3    : index = c3_symb2[39:32];
                default : index = 8'hff;
            endcase
        end
        CALC_C3_B   : begin
            case(cntB)
                3'd0    : index = c3_symb3[15:8];
                3'd1    : index = c3_symb3[23:16];
                3'd2    : index = c3_symb3[31:24];
                3'd3    : index = c3_symb3[39:32];
                default : index = 8'hff;
            endcase
        end
        CALC_C4_A   : begin
            case(cntA)
                3'd0    : index = c4_symb1[15:8];
                3'd1    : index = c4_symb1[23:16];
                3'd2    : index = c4_symb1[31:24];
                3'd3    : index = c4_symb1[39:32];
                3'd4    : index = c4_symb1[47:40];
                default : index = 8'hff;
            endcase
        end
        CALC_C4_B   : begin
            case(cntB)
                3'd0    : index = c4_symb2[15:8];
                3'd1    : index = c4_symb2[23:16];
                3'd2    : index = c4_symb2[31:24];
                3'd3    : index = c4_symb2[39:32];
                3'd4    : index = c4_symb2[47:40];
                default : index = 8'hff;
            endcase
        end
        default     : index = 8'hff;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        HC1 <= 8'b0;
        HC2 <= 8'b0;
        HC3 <= 8'b0;
        HC4 <= 8'b0;
        HC5 <= 8'b0;
        HC6 <= 8'b0;
    end
    else begin
        if (state == PRE_FINISH) begin
            HC1 <= (HC1>>(8-M1));
            HC2 <= (HC2>>(8-M2));
            HC3 <= (HC3>>(8-M3));
            HC4 <= (HC4>>(8-M4));
            HC5 <= (HC5>>(8-M5));
            HC6 <= (HC6>>(8-M6));
        end
        else if (state == CALC_C0_A || state == CALC_C1_A || state == CALC_C2_A || state == CALC_C3_A || state == CALC_C4_A) begin    
            case(index)
                8'h01   : HC1   <= {1'b0, HC1[7:1]};
                8'h02   : HC2   <= {1'b0, HC2[7:1]};
                8'h03   : HC3   <= {1'b0, HC3[7:1]};
                8'h04   : HC4   <= {1'b0, HC4[7:1]};
                8'h05   : HC5   <= {1'b0, HC5[7:1]};
                8'h06   : HC6   <= {1'b0, HC6[7:1]};
                default : HC1 <= HC1;
            endcase
        end
        else if (state == CALC_C0_B || state == CALC_C1_B || state == CALC_C2_B || state == CALC_C3_B || state == CALC_C4_B) begin 
            case(index)
                8'h01   : HC1   <= {1'b1, HC1[7:1]};
                8'h02   : HC2   <= {1'b1, HC2[7:1]};
                8'h03   : HC3   <= {1'b1, HC3[7:1]};
                8'h04   : HC4   <= {1'b1, HC4[7:1]};
                8'h05   : HC5   <= {1'b1, HC5[7:1]};
                8'h06   : HC6   <= {1'b1, HC6[7:1]};
                default : HC1 <= HC1;
            endcase
        end
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        M1 <= 8'b0;
        M2 <= 8'b0;
        M3 <= 8'b0;
        M4 <= 8'b0;
        M5 <= 8'b0;
        M6 <= 8'b0;
    end
    else begin
        if (state == PRE_FINISH) begin
            M1 <= buff_M1;
            M2 <= buff_M2;
            M3 <= buff_M3;
            M4 <= buff_M4;
            M5 <= buff_M5;
            M6 <= buff_M6;
        end
        else if (state == CALC_C0_A || state == CALC_C0_B || state == CALC_C1_A || state == CALC_C1_B || state == CALC_C2_A || state == CALC_C2_B ||
                    state == CALC_C3_A || state == CALC_C3_B || state == CALC_C4_A || state == CALC_C4_B) begin
            case(index)
                8'h01   : M1 <= M1 + 1'b1;
                8'h02   : M2 <= M2 + 1'b1;
                8'h03   : M3 <= M3 + 1'b1;
                8'h04   : M4 <= M4 + 1'b1;
                8'h05   : M5 <= M5 + 1'b1;
                8'h06   : M6 <= M6 + 1'b1;
                default : M1 <= M1;
            endcase
        end
    end
end

always @(*) begin
    case(state)
        IDLE        : nstate = (gray_valid) ? READ_GRAY : IDLE;
        READ_GRAY   : nstate = (!gray_valid) ? PREP_C0 : READ_GRAY;
        PREP_C0     : nstate = SORT_C0;
        SORT_C0     : nstate = (cnt_sort == 3'd5) ? CALC_C0_A : SORT_C0;
        CALC_C0_A   : nstate = CALC_C0_B;
        CALC_C0_B   : nstate = PREP_C1;
        PREP_C1     : nstate = SORT_C1;
        SORT_C1     : nstate = (cnt_sort == 3'd4) ? CALC_C1_A : SORT_C1;
        CALC_C1_A   : nstate = (cntA == 3'd1) ? CALC_C1_B : CALC_C1_A;
        CALC_C1_B   : nstate = (cntB == 3'd1) ? PREP_C2 : CALC_C1_B;
        PREP_C2     : nstate = SORT_C2;
        SORT_C2     : nstate = (cnt_sort == 3'd3) ? CALC_C2_A : SORT_C2;
        CALC_C2_A   : nstate = (cntA == 3'd2) ? CALC_C2_B : CALC_C2_A;
        CALC_C2_B   : nstate = (cntB == 3'd2) ? PREP_C3 : CALC_C2_B;
        PREP_C3     : nstate = SORT_C3;
        SORT_C3     : nstate = (cnt_sort == 3'd2) ? CALC_C3_A : SORT_C3;
        CALC_C3_A   : nstate = (cntA == 3'd3) ? CALC_C3_B : CALC_C3_A;
        CALC_C3_B   : nstate = (cntB == 3'd3) ? PREP_C4 : CALC_C3_B;
        PREP_C4     : nstate = SORT_C4;
        SORT_C4     : nstate = CALC_C4_A;
        CALC_C4_A   : nstate = (cntA == 3'd4) ? CALC_C4_B : CALC_C4_A;
        CALC_C4_B   : nstate = (cntB == 3'd4) ? PRE_FINISH : CALC_C4_B;
        PRE_FINISH  : nstate = FINISH;
        FINISH      : nstate = FINISH;
        default     : nstate = FINISH;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= nstate;
    end
end

endmodule


module convert(M, buffM);

    input       [7:0] M;
    output reg  [7:0] buffM;

    always @(*) begin
        case(M)
            8'd0: buffM <= 8'b0000_0000;
            8'd1: buffM <= 8'b0000_0001;
            8'd2: buffM <= 8'b0000_0011;
            8'd3: buffM <= 8'b0000_0111;
            8'd4: buffM <= 8'b0000_1111;
            8'd5: buffM <= 8'b0001_1111;
            8'd6: buffM <= 8'b0011_1111;
            8'd7: buffM <= 8'b0111_1111;
            8'd8: buffM <= 8'b1111_1111;
            default: buffM <= 8'b0000_0000;
        endcase
    end

endmodule
