module STI_DAC(clk ,reset, load, pi_data, pi_length, pi_fill, pi_msb, pi_low, pi_end,
	       so_data, so_valid,
	       oem_finish, oem_dataout, oem_addr,
	       odd1_wr, odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr);

	input				clk;
	input				reset;
	input				load;
	input				pi_msb;
	input				pi_low;
	input				pi_end; 
	input		[15:0]	pi_data;
	input		[1:0]	pi_length;
	input				pi_fill;

	output reg			so_data;
	output reg			so_valid;

	output  			oem_finish;
	output  reg			odd1_wr;
	output  reg			odd2_wr;
	output  reg			odd3_wr;
	output  reg			odd4_wr;
	output  reg			even1_wr;
	output  reg			even2_wr;
	output  reg			even3_wr;
	output  reg			even4_wr;

	output	reg	[4:0] 	oem_addr;
	output 	reg	[7:0] 	oem_dataout;

	reg			[31:0]	data;
	reg			[4:0]	count;

	reg			[7:0]	oem_count;

	reg 		[2:0]	state;
	reg 		[2:0]	nstate;

	parameter READ_STI = 3'd0, 
				CLASSIFY = 3'd1,
				WRITE_STI = 3'd2,
				WRITE_RAM = 3'd3,
				NEXT = 3'd4,
				FINISH = 3'd5;
	
	assign oem_finish = (state == FINISH);

	// RAM ==============================================================

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			odd1_wr <= 1'b0;
			odd2_wr <= 1'b0;
			odd3_wr <= 1'b0;
			odd4_wr <= 1'b0;

			even1_wr <= 1'b0;
			even2_wr <= 1'b0;
			even3_wr <= 1'b0;
			even4_wr <= 1'b0;
		end
		else if (((state == WRITE_STI && count[2:0] == 3'b0) || state == WRITE_RAM) && (~(oem_count[0] ^ oem_count[3]))) begin
			case(oem_count[7:6])
				2'b00: odd1_wr <= 1'b1;
				2'b01: odd2_wr <= 1'b1;
				2'b10: odd3_wr <= 1'b1;
				2'b11: odd4_wr <= 1'b1;
			endcase
		end
		else if (((state == WRITE_STI && count[2:0] == 3'b0) || state == WRITE_RAM) && ((oem_count[0] ^ oem_count[3]))) begin
			case(oem_count[7:6])
				2'b00: even1_wr <= 1'b1;
				2'b01: even2_wr <= 1'b1;
				2'b10: even3_wr <= 1'b1;
				2'b11: even4_wr <= 1'b1;
			endcase
		end	
		else begin
			odd1_wr <= 1'b0;
			odd2_wr <= 1'b0;
			odd3_wr <= 1'b0;
			odd4_wr <= 1'b0;

			even1_wr <= 1'b0;
			even2_wr <= 1'b0;
			even3_wr <= 1'b0;
			even4_wr <= 1'b0;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			oem_addr <= 5'b0;
		end
		else if (state == WRITE_RAM) begin
			oem_addr <= oem_count[5:1];
		end
		else if (state == WRITE_STI && count[2:0] == 3'b0) begin
			oem_addr <= oem_count[5:1];
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			oem_count <= 8'b0;
		end
		else if (state == WRITE_RAM) begin
			oem_count <= oem_count + 8'b1;
		end
		else if (state == WRITE_STI && count[2:0] == 3'b0) begin
			oem_count <= oem_count + 8'b1;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			oem_dataout <= 8'b0;
		end
		else if (state == WRITE_STI) begin
			oem_dataout <= (pi_msb) ? {oem_dataout[6:0], data[31]} : {oem_dataout[6:0], data[0]};
		end
		else if (state == WRITE_RAM) begin
			oem_dataout <= 8'b0;
		end
	end

	// STI ==============================================================

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			data <= 32'b0;
		end
		else if (state == CLASSIFY) begin
			case(pi_length)
				2'b00 : begin
					case({pi_msb, pi_low})
						2'b00 : data <= {24'b0, pi_data[7:0]};
						2'b01 : data <= {24'b0, pi_data[15:8]};
						2'b10 : data <= {pi_data[7:0], 24'b0};
						2'b11 : data <= {pi_data[15:8], 24'b0};
					endcase
				end
				2'b01 : data <= (pi_msb) ? {pi_data, 16'b0} : {16'b0, pi_data};
				2'b10 : begin
					case({pi_msb, pi_fill})
						2'b00 : data <= {16'b0, pi_data};
						2'b01 : data <= {8'b0, pi_data, 8'b0};
						2'b10 : data <= {8'b0, pi_data, 8'b0};
						2'b11 : data <= {pi_data, 16'b0};
					endcase
				end
				2'b11 : data <= (pi_fill) ? {pi_data, 16'b0} : {16'b0, pi_data};
			endcase
		end
		else if (state == WRITE_STI) begin
			data <= (pi_msb) ? {data[30:0], 1'b0} : {1'b0, data[31:1]};
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 5'b0;
		end
		else if (state == CLASSIFY) begin
			case(pi_length)
				2'b00 : count <= 5'd7;
				2'b01 : count <= 5'd15;
				2'b10 : count <= 5'd23;
				2'b11 : count <= 5'd31;
			endcase
		end
		else if (state == WRITE_STI) begin
			count <= count - 5'b1;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			so_valid <= 1'b0;
		end
		else if (state == WRITE_STI) begin
			so_valid <= 1'b1;
		end
		else begin
			so_valid <= 1'b0;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			so_data <= 1'b0;
		end
		else if (state == WRITE_STI) begin
			so_data <= (pi_msb) ? data[31] : data[0];
		end
	end

	always @(*) begin
		case(state)
			READ_STI : begin
				if (pi_end) 	nstate = WRITE_RAM;
				else if (load)	nstate = CLASSIFY;
				else		 	nstate = READ_STI;
			end
			CLASSIFY : nstate = WRITE_STI;
			WRITE_STI: nstate = (count == 5'b0) ? READ_STI : WRITE_STI;
			WRITE_RAM : nstate = (~|oem_count) ? FINISH : NEXT;
			NEXT : nstate = WRITE_RAM;
			FINISH  : nstate = FINISH;
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset)		state <= READ_STI;
		else			state <= nstate;
	end


endmodule
