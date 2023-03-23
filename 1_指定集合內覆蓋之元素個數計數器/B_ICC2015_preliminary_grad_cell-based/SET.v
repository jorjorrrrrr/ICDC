module SET ( clk , rst, en, central, radius, mode, busy, valid, candidate );

    input           clk, rst;
    input           en;
    input   [23:0]  central;
    input   [11:0]  radius;
    input   [1:0]   mode;

    output reg      busy;
    output reg      valid;
    output reg [7:0]   candidate;

    reg     [5:0]   count; //{y, x}

    wire    [3:0]   x;
    wire    [3:0]   y;

    wire    [3:0]   x1;
    wire    [3:0]   y1;
    wire    [3:0]   x2;
    wire    [3:0]   y2;
    wire    [3:0]   x3;
    wire    [3:0]   y3;

    wire    [7:0]   x1_2;
    wire    [7:0]   y1_2;
    wire    [7:0]   x2_2;
    wire    [7:0]   y2_2;
    wire    [7:0]   x3_2;
    wire    [7:0]   y3_2;

    wire    [7:0]   r1_2;
    wire    [7:0]   r2_2;
    wire    [7:0]   r3_2;

    wire            a;
    wire            b;
    wire            c;

    reg     [1:0]   state;
    reg     [1:0]   nstate;

    parameter IDLE = 0, WORK = 1, PRINT = 2;

    assign x = {1'b0, count[2:0]} + 4'b1;
    assign y = {1'b0, count[5:3]} + 4'b1;

    assign x1 = (central[23:20] > x) ? (central[23:20] - x) : (x - central[23:20]);
    assign y1 = (central[19:16] > y) ? (central[19:16] - y) : (y - central[19:16]);
    
    assign x2 = (central[15:12] > x) ? (central[15:12] - x) : (x - central[15:12]);
    assign y2 = (central[11:8] > y) ? (central[11:8] - y) : (y - central[11:8]);

    assign x3 = (central[7:4] > x) ? (central[7:4] - x) : (x - central[7:4]);
    assign y3 = (central[3:0] > y) ? (central[3:0] - y) : (y - central[3:0]);

    power2_LUT p1(.in(x1), .out(x1_2));
    power2_LUT p2(.in(y1), .out(y1_2));

    power2_LUT p3(.in(x2), .out(x2_2));
    power2_LUT p4(.in(y2), .out(y2_2));

    power2_LUT p5(.in(x3), .out(x3_2));
    power2_LUT p6(.in(y3), .out(y3_2));

    power2_LUT p7(.in(radius[11:8]), .out(r1_2));
    power2_LUT p8(.in(radius[7:4]), .out(r2_2));
    power2_LUT p9(.in(radius[3:0]), .out(r3_2));

    assign a = (x1_2 + y1_2 <= r1_2);
    assign b = (x2_2 + y2_2 <= r2_2);
    assign c = (x3_2 + y3_2 <= r3_2);

    always @(posedge clk) begin
        if (rst)                    count <= 6'b0;
        else if (state == WORK)     count <= count + 6'b1;
    end
    
    always @(posedge clk) begin
        if (rst)                candidate <= 8'b0;
        else if (state == IDLE) candidate <= 8'b0;
        else if (state == WORK) begin
            case(mode)
                2'b00 : candidate <= candidate + a;
                2'b01 : candidate <= candidate + (a&b);
                2'b10 : candidate <= candidate + ((a|b)&(~(a&b)));
                2'b11 : candidate <= candidate + (((a&b)|(b&c)|(a&c))&(~(a&b&c)));
            endcase
        end
    end

    always @(posedge clk) begin
        if (rst)                    busy <= 1'b0;
        else if (en)                busy <= 1'b1;
        else if (state == PRINT)    busy <= 1'b0;
    end

    always @(posedge clk) begin
        if (rst)                    valid <= 1'b0;
        else if (state == PRINT)    valid <= 1'b1;
        else                        valid <= 1'b0;
    end

    always @(*) begin
        case(state)
            IDLE : nstate = (en) ? WORK : IDLE;
            WORK : nstate = (&count) ? PRINT : WORK;
            PRINT : nstate = IDLE;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst)    state <= IDLE;
        else        state <= nstate;
    end

endmodule

module power2_LUT(in, out);

    input   [3:0]   in;
    output reg [7:0]   out;

    always @(*) begin
        case(in)
            4'd0 : out = 8'd0;
            4'd1 : out = 8'd1;
            4'd2 : out = 8'd4;
            4'd3 : out = 8'd9;
            4'd4 : out = 8'd16;
            4'd5 : out = 8'd25;
            4'd6 : out = 8'd36;
            4'd7 : out = 8'd49;
            4'd8 : out = 8'd64;
            default : out = 8'd0;
        endcase
    end

endmodule