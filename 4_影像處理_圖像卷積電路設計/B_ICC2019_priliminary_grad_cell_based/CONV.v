
`timescale 1ns/10ps

module  CONV(clk, reset, busy, ready, iaddr, idata, cwr, caddr_wr, cdata_wr, crd, caddr_rd, cdata_rd, csel);

	// area 94864 (S)
	
	input				clk;
	input				reset;
	output reg			busy;
	input				ready;
			
	output reg	[11:0]	iaddr;
	input		[19:0]	idata;
	
	output reg			cwr;
	output reg	[11:0]	caddr_wr;
	output reg	[19:0]	cdata_wr;
	
	output reg			crd;
	output reg	[11:0]	caddr_rd;
	input		[19:0]	cdata_rd;
	
	output reg	[2:0]	csel;

	wire 		[19:0]	weight[0:8];
	wire 		[19:0]	bias;

	reg 		[19:0]	img[0:8];
	wire 		[39:0]	conv[0:8];

	reg			[39:0]	total;
	wire 		[19:0]	L0_ans;

	wire		[5:0]	y;
	wire		[5:0]	x;

	reg					kernel; // 0 or 1

	reg			[19:0]	img1_max;
	reg			[19:0]	img2_max;
	reg			[19:0]	img3_max;
	reg			[19:0]	img4_max;

	wire		[19:0]	max1;
	wire		[19:0]	max2;
	wire		[19:0]	max;

	reg 		[4:0]	state;
	reg 		[4:0]	nstate;

	integer i;

	parameter IDLE 			= 0, 
				L0_START 	= 1,
				L0_LeftUp 	= 2,
				L0_Up 		= 3,
				L0_RightUp 	= 4,
				L0_Left 	= 5,
				L0_Mid 		= 6,
				L0_Right 	= 7,
				L0_LeftDown = 8,
				L0_Down 	= 9,
				L0_RightDown = 10,
				L0_WRITE 	= 11,
				L0_NEXT 	= 12,
				L1_START 	= 13,
				L1_LeftUp 	= 14,
				L1_RightUp 	= 15,
				L1_LeftDown = 16,
				L1_RightDown = 17,
				L1_WRITE 	= 18,
				L1_NEXT 	= 19,
				L2_START	= 20,
				L2_READ1	= 21,
				L2_WRITE1	= 22,
				L2_READ2	= 23,
				L2_WRITE2	= 24,
				L2_NEXT		= 25,
				done 		= 31;

	
	// 0 1 2
	// 3 4 5
	// 6 7 8

	assign weight[0] = kernel ? 20'hFDB55 : 20'h0A89E;
	assign weight[1] = kernel ? 20'h02992 : 20'h092D5;
	assign weight[2] = kernel ? 20'hFC994 : 20'h06D43;
	assign weight[3] = kernel ? 20'h050FD : 20'h01004;
	assign weight[4] = kernel ? 20'h02F20 : 20'hF8F71;
	assign weight[5] = kernel ? 20'h0202D : 20'hF6E54;
	assign weight[6] = kernel ? 20'h03BD7 : 20'hFA6D7;
	assign weight[7] = kernel ? 20'hFD369 : 20'hFC834;
	assign weight[8] = kernel ? 20'h05E68 : 20'hFAC19;

	assign bias = kernel ? 20'hF7295 : 20'h01310;

	assign y = caddr_wr[11:6];
	assign x = caddr_wr[5:0];

	assign max1 = (img1_max > img2_max) ? img1_max : img2_max;
	assign max2 = (img3_max > img4_max) ? img3_max : img4_max;
	assign max = (max1 > max2) ? max1 : max2;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			csel <= 3'b000;
		end
		else if (ready) begin
			csel <= 3'b001;
		end
		else if (state == L0_NEXT && (&caddr_wr) && kernel == 1'b0) begin
			csel <= 3'b010;
		end
		else if (state == L1_START) begin
			csel <= kernel ? 3'b010 : 3'b001;
		end
		else if (state == L1_WRITE) begin
			csel <= kernel ? 3'b100 : 3'b011;
		end
		else if (state == L2_READ1) begin
			csel <= 3'b011;
		end
		else if (state == L2_READ2) begin
			csel <= 3'b100;
		end
		else if (state == L2_WRITE1 || state == L2_WRITE2) begin
			csel <= 3'b101;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			kernel <= 1'b0;
		end
		else if ((state == L0_NEXT && (&caddr_wr)) || (state == L1_NEXT && (&caddr_wr[9:0]))) begin
			kernel <= ~kernel;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			crd <= 1'b0;
		end
		else if (state == L1_START || state == L2_READ1 || state == L2_READ2) begin
			crd <= 1'b1;
		end
		else if (state == L1_WRITE || state == L2_WRITE1 || state == L2_WRITE2) begin
			crd <= 1'b0;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			caddr_rd <= 12'b0;
		end
		else begin
			case (state)
				L1_START	: caddr_rd <= {caddr_wr[9:5], 1'b0, caddr_wr[4:0], 1'b0};
				L1_LeftUp	: caddr_rd <= {caddr_wr[9:5], 1'b0, caddr_wr[4:0], 1'b0} + 12'd1;
				L1_RightUp	: caddr_rd <= {caddr_wr[9:5], 1'b0, caddr_wr[4:0], 1'b0} + 12'd64;
				L1_LeftDown	: caddr_rd <= {caddr_wr[9:5], 1'b0, caddr_wr[4:0], 1'b0} + 12'd65;
				L2_READ1	: caddr_rd <= {2'b0, caddr_wr[10:1]};
				L2_READ2	: caddr_rd <= {2'b0, caddr_wr[10:1]};
				default		: caddr_rd <= caddr_rd;
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			img1_max <= 20'b0;
			img2_max <= 20'b0;
			img3_max <= 20'b0;
			img4_max <= 20'b0;
		end
		else begin
			case (state)
				L1_LeftUp	: img1_max <= cdata_rd;
				L1_RightUp	: img2_max <= cdata_rd;
				L1_LeftDown	: img3_max <= cdata_rd;
				L1_RightDown: img4_max <= cdata_rd;
				default		: img1_max <= img1_max;
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cwr <= 1'b0;
		end
		else if (state == L0_WRITE || state == L1_WRITE || state == L2_WRITE1 || state == L2_WRITE2) begin
			cwr <= 1'b1;
		end
		else begin
			cwr <= 1'b0;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cdata_wr <= 12'b0;
		end
		else if (state == L0_WRITE) begin
			cdata_wr <= L0_ans[19] ? 20'h0 : L0_ans;
		end
		else if (state == L1_WRITE) begin
			cdata_wr <= max;
		end
		else if (state == L2_WRITE1 || state == L2_WRITE2) begin
			cdata_wr <= cdata_rd;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			caddr_wr <= 12'b0;
		end
		else if (state == L0_NEXT) begin
			caddr_wr <= caddr_wr + 12'b1;
		end
		else if (state == L1_NEXT) begin
			caddr_wr <= (&caddr_wr[9:0]) ? 12'd0 : caddr_wr + 12'd1;
		end
		else if (state == L2_READ2 || state == L2_NEXT) begin
			caddr_wr <= caddr_wr + 12'd1;
		end
	end

	generate
		genvar j;
		
		for (j = 0; j <= 8; j=j+1) begin
			mult u_mult(.a(img[j]), .b(weight[j]), .out(conv[j]));
		end

	endgenerate

	always @(*) begin
		total = 44'b0;
		for (i = 0; i <= 8; i=i+1) begin
			total = total + conv[i];
		end
	end

	assign L0_ans = total[35:16] + total[15] + bias;
	
	// L0 Special case (y:iaddr[11:6], x:iaddr[5:0])
	// 1. (y==0 && x==0)
	// 2. (y==0 && x==63)	
	// 3. (y==63 && x==0)	
	// 4. (y==63 && x==63)	
	// 5. (y==0) 			
	// 6. (y==63) 			
	// 7. (x==0)			
	// 8. (x==63) 		

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			for (i = 0; i <= 8; i=i+1) begin
				img[i] <= 20'h0;
			end
		end
		else begin
			case(state)
				L0_LeftUp	: img[0] <= (x == 6'd0 || y == 6'd0) 	? 20'h0 : idata;
				L0_Up		: img[1] <= (y == 6'd0) 				? 20'h0 : idata;
				L0_RightUp	: img[2] <= (x == 6'd63 || y == 6'd0) 	? 20'h0 : idata;
				L0_Left		: img[3] <= (x == 6'd0) 				? 20'h0 : idata;
				L0_Mid		: img[4] <= idata;
				L0_Right	: img[5] <= (x == 6'd63) 				? 20'h0 : idata;
				L0_LeftDown	: img[6] <= (x == 6'd0 || y == 6'd63) 	? 20'h0 : idata;
				L0_Down		: img[7] <= (y == 6'd63) 				? 20'h0 : idata;
				L0_RightDown: img[8] <= (x == 6'd63 || y == 6'd63)	? 20'h0 : idata;
				default		: img[0] <= img[0];
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			iaddr <= 12'b0;
		end
		else begin
			case(state)
				L0_START	: iaddr <= caddr_wr - 12'd65;
				L0_LeftUp	: iaddr <= caddr_wr - 12'd64;
				L0_Up		: iaddr <= caddr_wr - 12'd63;
				L0_RightUp	: iaddr <= caddr_wr - 12'd1;
				L0_Left		: iaddr <= caddr_wr;
				L0_Mid		: iaddr <= caddr_wr + 12'd1;
				L0_Right	: iaddr <= caddr_wr + 12'd63;
				L0_LeftDown	: iaddr <= caddr_wr + 12'd64;
				L0_Down		: iaddr <= caddr_wr + 12'd65;
				default		: iaddr <= iaddr;
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset)					busy <= 1'b0;
		else if (ready)				busy <= 1'b1;
		else if (state == done)		busy <= 1'b0;
	end

	always @(*) begin
		case(state)
			IDLE 		: nstate = (ready) ? L0_START : IDLE;
			L0_START	: nstate = L0_LeftUp;
			L0_LeftUp	: nstate = L0_Up;
			L0_Up		: nstate = L0_RightUp;
			L0_RightUp	: nstate = L0_Left;
			L0_Left		: nstate = L0_Mid;
			L0_Mid		: nstate = L0_Right;
			L0_Right	: nstate = L0_LeftDown;
			L0_LeftDown	: nstate = L0_Down;
			L0_Down		: nstate = L0_RightDown;
			L0_RightDown: nstate = L0_WRITE;
			L0_WRITE	: nstate = L0_NEXT;
			L0_NEXT		: nstate = (kernel == 1'b1 && (&caddr_wr)) ? L1_START : L0_START;
			L1_START	: nstate = L1_LeftUp;
			L1_LeftUp	: nstate = L1_RightUp;
			L1_RightUp	: nstate = L1_LeftDown;
			L1_LeftDown	: nstate = L1_RightDown;
			L1_RightDown: nstate = L1_WRITE;
			L1_WRITE	: nstate = L1_NEXT;
			L1_NEXT		: nstate = (kernel == 1'b1 && (&caddr_wr[9:0])) ? L2_READ1 : L1_START;
			L2_READ1	: nstate = L2_WRITE1;
			L2_WRITE1	: nstate = L2_READ2;
			L2_READ2	: nstate = L2_WRITE2;
			L2_WRITE2	: nstate = L2_NEXT;
			L2_NEXT		: nstate = (&caddr_wr[10:0]) ? done : L2_READ1;
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset) 		state <= IDLE;
		else			state <= nstate;
	end


endmodule

module mult(a, b, out);
	input	signed	[19:0] a, b;
	output 	signed	[39:0] out;

	assign out = a * b;

endmodule
