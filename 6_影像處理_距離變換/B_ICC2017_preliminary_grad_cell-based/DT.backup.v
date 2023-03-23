module DT(clk, reset, done, sti_rd, sti_addr, sti_di, res_wr, res_rd, res_addr, res_do, res_di);
	
	input 					clk;
	input					reset;
	output					done;

	output	reg				sti_rd;
	output	reg	[9:0]		sti_addr;
	input		[15:0]		sti_di;
	
	output	reg				res_wr;
	output	reg				res_rd;
	output	reg	[13:0]		res_addr;
	output		[7:0]		res_do;
	input		[7:0]		res_di;

	reg			[0:16383]	img_STI;

	reg			[13:0]		count_addr;

	reg			[7:0]		mid_val;
	reg			[7:0]		val1;
	reg			[7:0]		val2;
	reg			[7:0]		val3;
	reg			[7:0]		val4;


	wire		[7:0]		cmp1;
	wire		[7:0]		cmp2;
	wire		[7:0]		ans_FP;
	wire		[7:0]		ans_BP;

	reg			[4:0]		state;
	reg			[4:0]		nstate;

	parameter IDLE = 5'd0,
				START_STI 	= 5'd1,
				READ_STI 	= 5'd2,
				FP_PREPARE 	= 5'd3,
				FP_START 	= 5'd4,
				FP_NW 		= 5'd5,
				FP_N 		= 5'd6,
				FP_NE 		= 5'd7,
				FP_W 		= 5'd8,
				FP_WRITE 	= 5'd9,
				BP_PREPARE 	= 5'd10,
				BP_START 	= 5'd11,
				BP_MID 		= 5'd12,
				BP_E 		= 5'd13,
				BP_SW 		= 5'd14,
				BP_S 		= 5'd15,
				BP_SE 		= 5'd16,
				BP_WRITE 	= 5'd17,
				FINISH 		= 5'd18;

	assign cmp1 = (val1 < val2) ? val1 : val2;
	assign cmp2 = (val3 < val4) ? val3 : val4;
	assign ans_FP = (cmp1 < cmp2) ? cmp1 + 8'd1 : cmp1 + 8'd1;
	assign ans_BP = (ans_FP < mid_val) ? ans_FP : mid_val;
	
	assign done = (state == FINISH);


	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			res_rd <= 1'b0;
		end
		else if (nstate == FP_START || nstate == BP_START) begin
			res_rd <= 1'b1;
		end
		else if (nstate == FP_WRITE || nstate == BP_WRITE) begin
			res_rd <= 1'b0;
		end
	end

	always @(negedge clk or negedge reset) begin
		if (!reset) begin
			res_wr <= 1'b0;
		end
		else if (state == FP_WRITE || state == BP_WRITE) begin
			res_wr <= 1'b1;
		end
		else begin
			res_wr <= 1'b0;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			count_addr <= 14'd128;
		end
		else if (nstate == FP_PREPARE) begin
			if (count_addr[6:0] == 7'b111_1110) begin // x == 126
				count_addr <= count_addr + 14'd3;
			end
			else begin
				count_addr <= count_addr + 14'd1;
			end
		end
		else if (nstate == BP_PREPARE) begin
			if (count_addr[6:0] == 7'b000_0001) begin // x == 1
				count_addr <= count_addr - 14'd3;
			end
			else begin
				count_addr <= count_addr - 14'd1;
			end
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			res_addr <= 14'd0;
		end
		else begin
			case (state)
				FP_START 	: res_addr <= count_addr - 14'd129;
				FP_NW 		: res_addr <= count_addr - 14'd128;
				FP_N 		: res_addr <= count_addr - 14'd127;
				FP_NE 		: res_addr <= count_addr - 14'd1;
				FP_W 		: res_addr <= count_addr; // for FP_WRITE
				BP_START 	: res_addr <= count_addr;
				BP_MID 		: res_addr <= count_addr + 14'd1;
				BP_E 		: res_addr <= count_addr + 14'd127;
				BP_SW 		: res_addr <= count_addr + 14'd128;
				BP_S 		: res_addr <= count_addr + 14'd129;
				BP_SE 		: res_addr <= count_addr; // for BP_WRITE
				default		: res_addr <= res_addr;
			endcase
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			mid_val	<= 8'b0;
			val1	<= 8'b0;
			val2	<= 8'b0;
			val3	<= 8'b0;
			val4	<= 8'b0;
		end
		else begin
			case (state)
				FP_NW 	: val1		<= res_di;
				FP_N 	: val2		<= res_di;
				FP_NE 	: val3		<= res_di;
				FP_W 	: val4		<= res_di;
				BP_MID 	: mid_val	<= res_di;
				BP_E 	: val1		<= res_di;
				BP_SW 	: val2		<= res_di;
				BP_S 	: val3		<= res_di;
				BP_SE 	: val4		<= res_di;
				default	: mid_val	<= mid_val;
			endcase
		end
	end

	assign res_do = (state < BP_PREPARE) ? ans_FP : ans_BP;

	// STI PROCESS ====================================================

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			sti_rd <= 1'b0;
		end
		else if (state == START_STI) begin
			sti_rd <= 1'b1;
		end
		else if (nstate == FP_PREPARE) begin
			sti_rd <= 1'b0;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			sti_addr <= 10'b0;
		end
		else if (state == READ_STI) begin
			sti_addr <= sti_addr + 10'b1;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			img_STI <= 16384'b0;
		end
		else if (state == READ_STI) begin
			img_STI <= {img_STI[16:16383], sti_di};
		end
	end

	// ==========================================================

	always @(*) begin
		case(state)
			IDLE 		: nstate = START_STI;
			START_STI	: nstate = READ_STI;
			READ_STI	: nstate = (&sti_addr) ? FP_PREPARE : READ_STI;
			FP_PREPARE 	: begin
				if (count_addr >= 14'd16366)			nstate = BP_PREPARE;
				else if (img_STI[count_addr] == 1'b0)	nstate = FP_PREPARE;
				else									nstate = FP_START;
			end
			FP_START 	: nstate = FP_NW;
			FP_NW 		: nstate = FP_N;
			FP_N 		: nstate = FP_NE;
			FP_NE 		: nstate = FP_W;
			FP_W 		: nstate = FP_WRITE;
			FP_WRITE 	: nstate = FP_PREPARE;
			BP_PREPARE 	: nstate = (count_addr == 14'd129) ? FINISH : BP_START;
			BP_START 	: nstate = BP_MID;
			BP_MID 		: nstate = BP_E;
			BP_E 		: nstate = BP_SW; //(mid_val == 8'b0) ? BP_PREPARE : BP_SW;
			BP_SW 		: nstate = BP_S;
			BP_S 		: nstate = BP_SE;
			BP_SE 		: nstate = BP_WRITE;
			BP_WRITE 	: nstate = BP_PREPARE;
			default		: nstate = FINISH;
		endcase
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) 		state <= IDLE;
		else 				state <= nstate;
	end



endmodule
