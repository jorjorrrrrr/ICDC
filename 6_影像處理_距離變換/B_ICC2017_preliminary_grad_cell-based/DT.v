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
	output	reg	[7:0]		res_do;
	input		[7:0]		res_di;

	//reg			[0:16383]	img_STI;

	reg			[13:0]		count_addr;

	reg			[3:0]		sti_count;

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

	// parameter IDLE = 5'd0,
	// 			START_STI 	= 5'd1,
	// 			READ_STI 	= 5'd2,
	// 			START_WRITE = 5'd3,
	// 			WRITE_STI 	= 5'd4,
	// 			FP_PREPARE 	= 5'd5,
	// 			FP_START 	= 5'd6,
	// 			FP_MID 		= 5'd7,
	// 			FP_NW 		= 5'd8,
	// 			FP_N 		= 5'd9,
	// 			FP_NE 		= 5'd10,
	// 			FP_W 		= 5'd11,
	// 			FP_WRITE 	= 5'd12,
	// 			BP_PREPARE 	= 5'd13,
	// 			BP_START 	= 5'd14,
	// 			BP_MID 		= 5'd15,
	// 			BP_E 		= 5'd16,
	// 			BP_SW 		= 5'd17,
	// 			BP_S 		= 5'd18,
	// 			BP_SE 		= 5'd19,
	// 			BP_WRITE 	= 5'd20,
	// 			FINISH 		= 5'd21;

	parameter IDLE = 5'd0,
				READ_STI 	= 5'd1,
				WRITE_STI 	= 5'd2,
				NEXT_STI 	= 5'd3,
				FP_PREPARE 	= 5'd4,
				FP_START 	= 5'd5,
				FP_MID 		= 5'd6,
				FP_NW 		= 5'd7,
				FP_N 		= 5'd8,
				FP_NE 		= 5'd9,
				FP_W 		= 5'd10,
				FP_WRITE 	= 5'd11,
				BP_PREPARE 	= 5'd12,
				BP_START 	= 5'd13,
				BP_MID 		= 5'd14,
				BP_E 		= 5'd15,
				BP_SW 		= 5'd16,
				BP_S 		= 5'd17,
				BP_SE 		= 5'd18,
				BP_WRITE 	= 5'd19,
				FINISH 		= 5'd31;

	assign cmp1 = (val1 < val2) ? val1 : val2;
	assign cmp2 = (val3 < val4) ? val3 : val4;
	assign ans_FP = (cmp1 < cmp2) ? cmp1 + 8'd1 : cmp2 + 8'd1;
	assign ans_BP = (ans_FP < mid_val) ? ans_FP : mid_val;

	assign done = (state == FINISH);

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			sti_rd <= 1'b0;
		end
		else if (state == READ_STI) begin
			sti_rd <= 1'b1;
		end
		else if (state == FP_PREPARE) begin
			sti_rd <= 1'b0;
		end
	end
	
	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			sti_addr <= 10'b0;
		end
		else if (state == NEXT_STI) begin
			sti_addr <= sti_addr + 10'b1;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			sti_count <= 4'b0;
		end
		else if (state == WRITE_STI)begin
			sti_count <= sti_count + 4'b1;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			res_wr <= 1'b0;
		end
		else if (state == WRITE_STI || state == FP_WRITE || state == BP_WRITE) begin
			res_wr <= 1'b1;
		end
		else begin
			res_wr <= 1'b0;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			res_rd <= 1'b0;
		end
		else if (state == FP_START || state == BP_START)begin
			res_rd <= 1'b1;
		end
		else if (state == FP_WRITE || state == BP_WRITE) begin
			res_rd <= 1'b0;
		end
	end

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			res_addr <= 14'b0;
		end
		else begin
			case (state)
				WRITE_STI 	: res_addr <= {sti_addr, sti_count};
				FP_START 	: res_addr <= count_addr;
				FP_MID 		: res_addr <= count_addr - 14'd129;
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
			count_addr <= 14'd128;
		end
		else if (nstate == FP_PREPARE) begin
			if (count_addr[6:0] == 7'd126) begin  // x == 126
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
			mid_val	<= 8'b0;
			val1	<= 8'b0;
			val2	<= 8'b0;
			val3	<= 8'b0;
			val4	<= 8'b0;
		end
		else begin
			case (state)
				FP_MID 	: mid_val	<= res_di;
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

	always @(*) begin
		if (state < FP_PREPARE) begin
			case (res_addr[3:0]) 
				4'd0 : res_do = {7'b0, sti_di[15]};
				4'd1 : res_do = {7'b0, sti_di[14]};
				4'd2 : res_do = {7'b0, sti_di[13]};
				4'd3 : res_do = {7'b0, sti_di[12]};
				4'd4 : res_do = {7'b0, sti_di[11]};
				4'd5 : res_do = {7'b0, sti_di[10]};
				4'd6 : res_do = {7'b0, sti_di[9]};
				4'd7 : res_do = {7'b0, sti_di[8]};
				4'd8 : res_do = {7'b0, sti_di[7]};
				4'd9 : res_do = {7'b0, sti_di[6]};
				4'd10 : res_do = {7'b0, sti_di[5]};
				4'd11 : res_do = {7'b0, sti_di[4]};
				4'd12 : res_do = {7'b0, sti_di[3]};
				4'd13 : res_do = {7'b0, sti_di[2]};
				4'd14 : res_do = {7'b0, sti_di[1]};
				4'd15 : res_do = {7'b0, sti_di[0]};
			endcase
		end
		else if (state < BP_PREPARE)begin
			res_do = ans_FP;
		end
		else begin
			res_do = ans_BP;
		end
	end

	always @(*) begin
		case(state)
			IDLE		: nstate = READ_STI;
			READ_STI	: nstate = WRITE_STI;
			WRITE_STI	: begin
				if (&res_addr[3:0])				nstate = NEXT_STI;
				else							nstate = WRITE_STI;
			end
			NEXT_STI	: nstate = (&sti_addr) ? FP_PREPARE : WRITE_STI;
			FP_PREPARE 	: nstate = (count_addr == 14'd16366) ? BP_PREPARE : FP_START;
			FP_START 	: nstate = FP_MID;
			FP_MID 		: nstate = FP_NW;
			FP_NW 		: nstate = (mid_val == 8'b0) ? FP_PREPARE : FP_N;
			FP_N 		: nstate = FP_NE;
			FP_NE 		: nstate = FP_W;
			FP_W 		: nstate = FP_WRITE;
			FP_WRITE 	: nstate = FP_PREPARE;
			BP_PREPARE 	: nstate = (count_addr == 14'd129) ? FINISH : BP_START;
			BP_START 	: nstate = BP_MID;
			BP_MID 		: nstate = BP_E;
			BP_E 		: nstate = BP_SW;//(mid_val == 8'b0) ? BP_PREPARE : BP_SW;
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
