
`timescale 1ns/10ps

module LBP (clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, lbp_valid, lbp_data, finish);
    
    // area 4302
    // time 2381475
    // area x time = 10,245,105,450 (A)

    input   	        clk;
    input   	        reset;

    output reg [13:0] 	gray_addr;
    output reg          gray_req;
    input   	        gray_ready;
    input       [7:0] 	gray_data;
    
    output reg  [13:0] 	lbp_addr;
    output reg          lbp_valid;
    output reg  [7:0] 	lbp_data;
    output  	        finish;

    reg         [7:0]   gc;

    reg         [3:0]   state;
    reg         [3:0]   nstate;

    parameter   IDLE = 0, 
                READY = 1,
                START_READ = 2,
                mid = 3,
                LeftUp = 4,
                Up = 5,
                RightUp = 6,
                Left = 7,
                Right = 8,
                LeftDown = 9,
                Down = 10,
                RightDown = 11,
                Write = 12,
                done = 13;

    always @(posedge clk or posedge reset) begin
        if (reset)                      gc <= 8'd0;
        else if (state == mid)          gc <= gray_data;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lbp_data    <= 8'b0;
        end
        else if (state >= LeftUp && state <= RightDown) begin
            lbp_data    <= (gray_data >= gc) ? {1'b1, lbp_data[7:1]} : {1'b0, lbp_data[7:1]};
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset)              gray_req <= 1'b0;
        else if (gray_ready)    gray_req <= 1'b1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            gray_addr <= 14'd0;
        end
        else begin
            case(state)
                START_READ  :   gray_addr <= lbp_addr;
                mid         :   gray_addr <= lbp_addr - 14'd129;
                LeftUp      :   gray_addr <= lbp_addr - 14'd128;
                Up          :   gray_addr <= lbp_addr - 14'd127;
                RightUp     :   gray_addr <= lbp_addr - 14'd1;
                Left        :   gray_addr <= lbp_addr + 14'd1;
                Right       :   gray_addr <= lbp_addr + 14'd127;
                LeftDown    :   gray_addr <= lbp_addr + 14'd128;
                Down        :   gray_addr <= lbp_addr + 14'd129;
                default     :   gray_addr <= gray_addr;
            endcase
        end
    end

    assign finish = (state == done);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lbp_addr <= 14'd128;
        end
        else if (state == READY) begin
            if (lbp_addr[6:0] == 7'b111_1110)   lbp_addr <= lbp_addr + 14'd3;
            else                                lbp_addr <= lbp_addr + 14'd1;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lbp_valid   <= 1'b0;
        end
        else if (state == Write) begin
            lbp_valid   <= 1'b1;
        end
        else begin
            lbp_valid   <= 1'b0;
        end
    end

    always @(*) begin
        case(state)
            IDLE        : nstate = (gray_ready) ? READY : IDLE;
            READY       : nstate = START_READ;
            START_READ  : nstate = mid;
            mid         : nstate = LeftUp;
            LeftUp      : nstate = Up;
            Up          : nstate = RightUp;
            RightUp     : nstate = Left;
            Left        : nstate = Right;
            Right       : nstate = LeftDown;
            LeftDown    : nstate = Down;
            Down        : nstate = RightDown;
            RightDown   : nstate = Write;
            Write       : nstate = (lbp_addr == 14'd16254) ? done : READY;
            default     : nstate = done;  
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)      state <= IDLE;
        else            state <= nstate;
    end

endmodule
