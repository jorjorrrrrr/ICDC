module SME(clk,reset,chardata,isstring,ispattern,valid,match,match_index);

    input               clk;
    input               reset;
    
    input       [7:0]   chardata;
    input               isstring;
    input               ispattern;
    
    output reg          match;
    output reg  [4:0]   match_index;
    output              valid;
    // reg match;
    // reg [4:0] match_index;
    // reg valid;
    
    reg         [7:0]   string_array  [0:31];
    reg         [7:0]   pattern_array [0:7];

    reg         [5:0]   string_len;
    reg         [3:0]   pattern_len; 

    reg                 string_flag;
    reg                 pattern_flag;

    reg                 head_exist;
    reg                 tail_exist;

    reg         [5:0]   string_index;
    reg         [3:0]   pattern_index; 
    
    reg         [5:0]   string_index_reg;
    reg         [5:0]   string_star_index_reg; 
    
    reg                 maybe_match;
    reg         [4:0]   maybe_match_index;

    reg                 star_reg;

    reg         [4:0]   state;
    reg         [4:0]   nstate;

    integer i;   

    parameter READ_STRING = 4'd0,
                READ_PATTERN    = 4'd1,
                CHECK           = 4'd2,
                NORMAL          = 4'd3,
                HEAD            = 4'd4,
                TAIL            = 4'd5,
                BOTH            = 4'd6,
                OUTPUT_ANS      = 4'd7,
                RESET_ALL       = 4'd8;


    assign valid = (state == OUTPUT_ANS) ? 1'b1 : 1'b0;
    //assign match = 1'b0;
    //assign match_index = 5'b0;
    
    // =========================================================================================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i=i+1) begin
                string_array[i] <= 8'b0;
            end
            string_len <= 6'b0;
        end
        else begin
            if (isstring && (~string_flag)) begin
                for (i = 1; i < 32; i=i+1) begin
                    string_array[i] <= 8'b0;
                end
                string_array[0] <= chardata;
                string_len      <= 6'b1;
            end
            else if (isstring) begin
                string_array[string_len]    <= chardata;
                string_len                  <= string_len + 6'b1;
            end
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 8; i=i+1) begin
                pattern_array[i] <= 8'b0;
            end
            pattern_len <= 4'b0;
        end
        else begin
            if (ispattern && (~pattern_flag)) begin
                for (i = 1; i < 8; i=i+1) begin
                    pattern_array[i] <= 8'b0;
                end
                pattern_array[0] <= chardata;
                pattern_len      <= 4'b1;
            end
            else if (ispattern) begin
                pattern_array[pattern_len]  <= chardata;
                pattern_len                 <= pattern_len + 4'b1;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            string_flag     <= 1'b0;
            pattern_flag    <= 1'b0;
        end
        else begin
            string_flag     <= (isstring)  ? 1'b1 : 1'b0;
            pattern_flag    <= (ispattern) ? 1'b1 : 1'b0;
        end
    end

    always @(posedge clk or posedge reset) begin : check_head_tail_is_exist
        if (reset) begin
            head_exist <= 1'b0;
            tail_exist <= 1'b0;
        end
        else begin
            if (ispattern) begin
                head_exist <= 1'b0;
                tail_exist <= 1'b0;
            end
            else if (ispattern) begin
                if (chardata == 8'h5E) begin
                    head_exist <= 1'b1;
                end
                else if (chardata == 8'h24) begin
                    tail_exist <= 1'b1;
                end
            end
        end
    end
    
    // =========================================================================================================================

    always @(posedge clk or posedge reset) begin
        if (reset) begin
           string_index <= 6'b0;
        end
        else begin
            if (ispattern) begin
                string_index <= 6'b0;
            end
            else if (pattern_array[pattern_index] == 8'h2A) begin
                if (string_index == string_len) begin
                    string_index <= string_star_index_reg;
                end
                else begin
                    string_index <= string_index + 6'b1;
                end
            end
            else if (state == NORMAL) begin
                if (maybe_match == 1'b1 && !((string_array[string_index] == pattern_array[pattern_index] || pattern_array[pattern_index] == 8'h2E))) begin
                    string_index <= string_index_reg + 6'b1;
                end
                else if (pattern_array[pattern_index] == 8'h5E && (string_index == 6'b0)) begin
                    string_index <= string_index; 
                end
                else begin
                    string_index <= string_index + 6'b1;
                end
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            string_star_index_reg   <= 6'b0;
        end
        else begin
            if (ispattern) begin
                string_star_index_reg   <= 6'b0;
            end
            else if (pattern_array[pattern_index] == 8'h2A) begin
                if (!star_reg) begin
                    string_star_index_reg <= string_index;
                end
                else if (pattern_index+2 < pattern_len) begin 
                    if (string_array[string_index] == pattern_array[pattern_index+1] && string_array[string_index+1] == pattern_array[pattern_index+2]) begin
                        string_star_index_reg <= string_index;
                    end
                end
                else begin
                    if (string_array[string_index] == pattern_array[pattern_index+1]) begin
                        string_star_index_reg <= string_index;
                    end
                end
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            star_reg    <= 1'b0;
        end
        else begin
            if (ispattern) begin
                star_reg <= 1'b0;
            end
            else if (pattern_array[pattern_index] == 8'h2A) begin
                star_reg <= 1'b1;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            string_index_reg <= 6'b0;
        end
        else begin
            if (ispattern) begin // reset
                string_index_reg <= 4'b0;
            end
            else if (maybe_match == 1'b0) begin
                if ((pattern_array[pattern_index] == 8'h5E && (string_array[string_index] == 8'h20 || string_index == 6'b0))) begin
                    string_index_reg <= string_index;
                end
                else if ((string_array[string_index] == pattern_array[pattern_index] || pattern_array[pattern_index] == 8'h2E)) begin
                    string_index_reg <= string_index;
                end
            end
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_index <= 4'b0;
        end
        else begin
            if (ispattern) begin
                pattern_index <= 4'b0;
            end
            else if (state >= NORMAL && state <= BOTH) begin
                if (string_array[string_index] == pattern_array[pattern_index] || pattern_array[pattern_index] == 8'h2E) begin
                    if (pattern_array[pattern_index+1] == 8'h24 && (string_array[string_index+1] == 8'h20 || string_index+1 == string_len)) begin
                        pattern_index <= pattern_index + 4'd2;
                    end
                    else begin
                        pattern_index <= pattern_index + 4'b1;
                    end
                end
                else if ((pattern_array[pattern_index] == 8'h5E && (string_array[string_index] == 8'h20 || string_index == 6'b0))) begin
                    pattern_index <= pattern_index + 4'b1;
                end
                else if (pattern_array[pattern_index] == 8'h2A) begin
                    if (string_index == string_len) begin // finish fully scan
                        if (string_array[string_star_index_reg] == pattern_array[pattern_index+1]) begin
                            pattern_index <= pattern_index + 6'b1;
                        end
                        else begin
                            pattern_index <= 6'b0;
                        end
                    end
                    else begin
                        pattern_index <= pattern_index; 
                    end
                end
                else begin
                    pattern_index <= 4'b0;
                end
            end
        end
    end
    

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            match       <= 1'b0;
            match_index <= 5'b0;
        end
        else begin
            if (ispattern) begin // reset
                match       <= 1'b0;
                match_index <= 5'b0;
            end
            else if (pattern_index == pattern_len) begin
                match       <= 1'b1;
                match_index <= maybe_match_index;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            maybe_match_index <= 4'b0;
        end
        else begin
            if (ispattern) begin
                maybe_match_index <= 4'b0;
            end
            else if ((state == NORMAL) && (maybe_match == 1'b0)) begin
                if (string_array[string_index] == pattern_array[pattern_index] || pattern_array[pattern_index] == 8'h2E) begin
                    maybe_match_index <= string_index;
                end
                else if ((pattern_array[pattern_index] == 8'h5E && (string_array[string_index] == 8'h20))) begin
                    maybe_match_index <= string_index + 6'b1;
                end
                else if ((pattern_array[pattern_index] == 8'h5E && string_index == 6'b0)) begin
                    maybe_match_index <= string_index;
                end
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            maybe_match <= 1'b0;
        end
        else begin
            if (ispattern) begin // reset
                maybe_match <= 1'b0;
            end
            else if (state >= NORMAL && state <= BOTH) begin
                if (string_array[string_index] == pattern_array[pattern_index] || pattern_array[pattern_index] == 8'h2E) begin
                    maybe_match <= 1'b1;
                end
                else if ((pattern_array[pattern_index] == 8'h5E && (string_array[string_index] == 8'h20 || string_index == 6'b0))) begin
                    maybe_match <= 1'b1;
                end
                else if (pattern_array[pattern_index] == 8'h2A) begin
                    maybe_match <= maybe_match;
                end
                else if (string_array[string_index] != pattern_array[pattern_index]) begin
                    maybe_match <= 1'b0;
                end
            end
        end
    end
    
    always @(*) begin
        case(state)
            READ_STRING : nstate = (isstring)  ? READ_STRING  : READ_PATTERN;
            READ_PATTERN: nstate = (ispattern) ? READ_PATTERN : CHECK;
            CHECK       : nstate = NORMAL;
            NORMAL      : nstate = ((string_index == string_len && !(pattern_array[pattern_index] == 8'h2A)) || pattern_index == pattern_len) ? OUTPUT_ANS : NORMAL;
            TAIL        : nstate = OUTPUT_ANS;
            BOTH        : nstate = OUTPUT_ANS;
            OUTPUT_ANS  : nstate = READ_STRING;
            default     : nstate = READ_STRING;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)      state <= READ_STRING;
        else            state <= nstate;
    end


endmodule
