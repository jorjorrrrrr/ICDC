module geofence (clk, reset, X, Y, valid, is_inside);
input               clk;
input               reset;
input       [9:0]   X;
input       [9:0]   Y;
output              valid;
output  reg     is_inside;

// {X,Y}
reg         [19:0]  OBJ;    // object
reg         [19:0]  SEN0;   // sensor
reg         [19:0]  SEN1;
reg         [19:0]  SEN2;
reg         [19:0]  SEN3;
reg         [19:0]  SEN4;
reg         [19:0]  SEN5;

reg         [19:0]  A;
reg         [19:0]  B;
reg         [19:0]  C;

wire                buff_out; // 1 -> larger ; 0 -> smaller

reg         [2:0]   cnt;            // counter input x y
reg         [2:0]   cnt_sort;       // counter of sorting

integer i;

reg     [4:0]   state;
reg     [4:0]   nstate;

parameter READ_XY   = 0,
            SORT1   = 1,
            EXCH1   = 2, // exchange 
            SORT2   = 3,
            EXCH2   = 4,
            SORT3   = 5,
            EXCH3   = 6,
            SORT4   = 7,
            EXCH4   = 8,
            COMP01  = 9,
            COMP12  = 10, // compare
            COMP23  = 11,
            COMP34  = 12,
            COMP45  = 13,
            COMP50  = 14,
            FINISH  = 15;

assign valid = (state == FINISH) ? 1'b1 : 1'b0;

cross_product u_cross_product(.x0({1'b0, A[19:10]}), .y0({1'b0, A[9:0]}), .x1({1'b0, B[19:10]}), .y1({1'b0, B[9:0]}), .x2({1'b0, C[19:10]}), .y2({1'b0, C[9:0]}), .out(buff_out));


always @(posedge clk or posedge reset) begin
    if (reset) begin
        is_inside <= 1'b1;
    end
    else begin
        if (state == READ_XY) begin
            is_inside <= 1'b1;
        end
        else if (state == COMP01 || state == COMP12 || state == COMP23 || state == COMP34 || state == COMP45 || state == COMP50) begin
            is_inside <= is_inside & (~buff_out);
        end
    end
end

always @(posedge clk or posedge reset) begin : CROSS_PRODUCT_INPUT
    if (reset) begin
        {A, B, C} <= 60'b0;
    end
    else begin
        case (state)
            SORT1   : {A, B, C} <= {SEN0, SEN1, SEN2};
            SORT2   : {A, B, C} <= {SEN0, SEN2, SEN3};
            SORT3   : {A, B, C} <= {SEN0, SEN3, SEN4};
            SORT4   : {A, B, C} <= {SEN0, SEN4, SEN5};
            EXCH4   : {A, B, C} <= {OBJ , SEN0, SEN1};
            COMP01  : {A, B, C} <= {OBJ , SEN1, SEN2};
            COMP12  : {A, B, C} <= {OBJ , SEN2, SEN3};
            COMP23  : {A, B, C} <= {OBJ , SEN3, SEN4};
            COMP34  : {A, B, C} <= {OBJ , SEN4, SEN5};
            COMP45  : {A, B, C} <= {OBJ , SEN5, SEN0};
            default : {A, B, C} <= {A, B, C};
        endcase
    end
end


always @(posedge clk or posedge reset) begin : READ_INPUT
    if (reset) begin
        OBJ     <= 20'b0;
        SEN0    <= 20'b0;
        SEN1    <= 20'b0;
        SEN2    <= 20'b0;
        SEN3    <= 20'b0;
        SEN4    <= 20'b0;
        SEN5    <= 20'b0;
    end
    else begin
        if (state == READ_XY) begin
            case(cnt)
                3'd0 : OBJ  <= {X, Y};
                3'd1 : SEN0 <= {X, Y};
                3'd2 : SEN1 <= {X, Y};
                3'd3 : SEN2 <= {X, Y};
                3'd4 : SEN3 <= {X, Y};
                3'd5 : SEN4 <= {X, Y};
                3'd6 : SEN5 <= {X, Y};
                default : OBJ  <= OBJ;
            endcase
        end
        else begin
            case (state)
                EXCH1 : {SEN1, SEN2} <= (buff_out) ? {SEN2, SEN1} : {SEN1, SEN2};
                EXCH2 : {SEN2, SEN3} <= (buff_out) ? {SEN3, SEN2} : {SEN2, SEN3};
                EXCH3 : {SEN3, SEN4} <= (buff_out) ? {SEN4, SEN3} : {SEN3, SEN4};
                EXCH4 : {SEN4, SEN5} <= (buff_out) ? {SEN5, SEN4} : {SEN4, SEN5};
                default : OBJ  <= OBJ;
            endcase
        end
    end
end


// COUNTER =========================================================================
//

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt_sort <= 3'd0;
    end
    else begin
        if (state == FINISH) begin
            cnt_sort <= 3'd0;
        end
        else if (state == EXCH4) begin
            cnt_sort <= cnt_sort + 3'd1;
        end
    end
end

always @(posedge clk or posedge reset) begin : COUNTER_INPUT
    if (reset) begin
        cnt <= 3'b0;
    end
    else begin
        if (state == FINISH) begin
            cnt <= 3'b0;
        end
        else if (state == READ_XY) begin
            cnt <= cnt + 3'b1;
        end
    end
end

always @(*) begin
    case(state)
        READ_XY : nstate = (cnt == 3'd6) ? SORT1 : READ_XY;
        SORT1   : nstate = EXCH1;
        EXCH1   : nstate = SORT2;
        SORT2   : nstate = EXCH2;
        EXCH2   : nstate = SORT3;
        SORT3   : nstate = EXCH3;
        EXCH3   : nstate = SORT4;
        SORT4   : nstate = EXCH4;
        EXCH4   : nstate = (cnt_sort == 3'd3) ? COMP01 : SORT1;
        COMP01  : nstate = COMP12;
        COMP12  : nstate = COMP23;
        COMP23  : nstate = COMP34;
        COMP34  : nstate = COMP45;
        COMP45  : nstate = COMP50;
        COMP50  : nstate = FINISH;
        FINISH  : nstate = READ_XY;
        default : nstate = READ_XY;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= READ_XY;
    end
    else begin
        state <= nstate;
    end
end

endmodule


module cross_product(x0, y0, x1, y1, x2, y2, out);

    input signed    [10:0]  x0, y0; // S.10
    input signed    [10:0]  x1, y1;
    input signed    [10:0]  x2, y2;

    output          out; // 1 -> larger ; 0 -> smaller
    
    wire signed     [10:0]  x1_x0; // S.10
    wire signed     [10:0]  y2_y0; // S.10
    wire signed     [10:0]  x2_x0; // S.10
    wire signed     [10:0]  y1_y0; // S.10

    wire signed     [20:0]  Ax_By; // S.20
    wire signed     [20:0]  Bx_Ay; // S.20

    assign x1_x0 = x1 - x0;
    assign y2_y0 = y2 - y0;
    assign x2_x0 = x2 - x0;
    assign y1_y0 = y1 - y0;

    assign Ax_By = x1_x0 * y2_y0; 
    assign Bx_Ay = x2_x0 * y1_y0;

    assign out = (Ax_By > Bx_Ay) ? 1'b1 : 1'b0;

endmodule
