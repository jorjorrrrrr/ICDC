module LCD_CTRL(clk, reset, cmd, cmd_valid, IROM_Q, IROM_rd, IROM_A, IRAM_valid, IRAM_D, IRAM_A, busy, done);
    input               clk;
    input               reset;
    
    input       [3:0]   cmd;
    input               cmd_valid;
    
    input       [7:0]   IROM_Q;
    output  reg         IROM_rd;
    output  reg [5:0]   IROM_A;

    output              IRAM_valid;
    output  reg [7:0]   IRAM_D;
    output  reg [5:0]   IRAM_A;
    
    output  reg         busy;
    output              done;

    reg         [7:0]   IMG [0:63];

    reg         [2:0]   objx;
    reg         [2:0]   objy;

    wire        [2:0]   objx_1;
    wire        [2:0]   objy_1;

    wire        [5:0]   addr1;
    wire        [5:0]   addr2; // 1 2
    wire        [5:0]   addr3; // 3 4
    wire        [5:0]   addr4;

    wire        [7:0]   max_1;
    wire        [7:0]   max_2;
    wire        [7:0]   max_val;

    wire        [7:0]   min_1;
    wire        [7:0]   min_2;
    wire        [7:0]   min_val;

    wire        [9:0]   total;
    wire        [7:0]   avg;

    reg         [2:0]   state;
    reg         [2:0]   nstate;

    parameter IDLE = 3'd0, 
                read_IROM_1     = 3'd1, 
                read_IROM_2     = 3'd2, 
                wait_CMD        = 3'd3, 
                CAL             = 3'd4, 
                write_IRAM_1    = 3'd5, 
                write_IRAM_2    = 3'd6, 
                finish          = 3'd7;

    integer i;

    assign objx_1 = objx - 3'b1;
    assign objy_1 = objy - 3'b1;

    // position
    assign addr1 = {objy_1  , objx_1    };
    assign addr2 = {objy_1  , objx      };
    assign addr3 = {objy    , objx_1    };
    assign addr4 = {objy    , objx      };

    // cal max
    assign max_1 = (IMG[addr1] > IMG[addr2]) ? IMG[addr1] : IMG[addr2];
    assign max_2 = (IMG[addr3] > IMG[addr4]) ? IMG[addr3] : IMG[addr4];
    assign max_val = (max_1 > max_2) ? max_1 : max_2;

    // cal min
    assign min_1 = (IMG[addr1] < IMG[addr2]) ? IMG[addr1] : IMG[addr2];
    assign min_2 = (IMG[addr3] < IMG[addr4]) ? IMG[addr3] : IMG[addr4];
    assign min_val = (min_1 < min_2) ? min_1 : min_2;

    // cal avg
    assign total = IMG[addr1] + IMG[addr2] + IMG[addr3] + IMG[addr4];
    assign avg = (total >> 2);

    
    assign IRAM_valid = (state == write_IRAM_1 || state == write_IRAM_2);
    assign done = (state == finish);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            IRAM_D <= 8'b0;
            IRAM_A <= 6'b0;
        end
        else if (state == write_IRAM_1) begin
            IRAM_D <= IMG[0];
            IRAM_A <= 6'b0;
        end
        else if (state == write_IRAM_2) begin
            IRAM_D <= IMG[IRAM_A + 1];
            IRAM_A <= IRAM_A + 6'b1;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            busy <= 1'b1;
        end
        else if (state == wait_CMD && cmd_valid) begin
            busy <= 1'b1;
        end
        else if (state == wait_CMD) begin
            busy <= 1'b0;
        end
        else if (state == finish) begin
            busy <= 1'b1;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            IROM_A  <= 6'b0;
            IROM_rd <= 6'b1;
        end
        else if (nstate == read_IROM_1) begin
            IROM_A  <= 6'b0;
            IROM_rd <= 1'b1;
        end
        else if (nstate == read_IROM_2) begin
            IROM_A  <= (IROM_A == 6'd63) ? 6'b0 : IROM_A + 6'b1;
            IROM_rd <= (IROM_A == 6'd63) ? 1'b0 : 1'b1;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i <= 63; i=i+1) begin
                IMG[i] <= 8'b0;
            end
        end
        else if (state == read_IROM_1 || state == read_IROM_2) begin
            IMG[IROM_A] <= IROM_Q;
        end
        else if (state == CAL) begin
            case(cmd)
                4'h5 : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {4{max_val}};
                4'h6 : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {4{min_val}};
                4'h7 : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {4{avg}};
                4'h8 : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {IMG[addr2], IMG[addr4], IMG[addr1], IMG[addr3]};
                4'h9 : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {IMG[addr3], IMG[addr1], IMG[addr4], IMG[addr2]};
                4'ha : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {IMG[addr3], IMG[addr4], IMG[addr1], IMG[addr2]};
                4'hb : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {IMG[addr2], IMG[addr1], IMG[addr4], IMG[addr3]};
                default : {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]} <= {IMG[addr1], IMG[addr2], IMG[addr3], IMG[addr4]};
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            objx    <= 4'h4;
            objy    <= 4'h4;
        end
        else if (state == CAL) begin
            case(cmd)
                4'h1    : objy <= (objy <= 4'h1) ? 4'h1 : objy - 4'h1;
                4'h2    : objy <= (objy >= 4'h7) ? 4'h7 : objy + 4'h1;
                4'h3    : objx <= (objx <= 4'h1) ? 4'h1 : objx - 4'h1;
                4'h4    : objx <= (objx >= 4'h7) ? 4'h7 : objx + 4'h1;
                default : {objx, objy} <= {objx, objy};
            endcase
        end
    end

    always @(*) begin
        case(state)
            IDLE            : nstate = read_IROM_1;
            read_IROM_1     : nstate = read_IROM_2;
            read_IROM_2     : nstate = (IROM_A == 6'd63) ? wait_CMD : read_IROM_2;
            wait_CMD        : nstate = (cmd_valid) ? ((cmd == 4'b0) ? write_IRAM_1 : CAL) : wait_CMD;
            CAL             : nstate = wait_CMD;
            write_IRAM_1    : nstate = write_IRAM_2;
            write_IRAM_2    : nstate = (IRAM_A == 6'd63) ? finish : write_IRAM_2;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)          state <= IDLE;
        else                state <= nstate;
    end


endmodule



