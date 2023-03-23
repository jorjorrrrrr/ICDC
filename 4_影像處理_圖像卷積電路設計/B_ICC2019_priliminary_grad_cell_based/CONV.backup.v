
`timescale 1ns/10ps

module  CONV(clk, reset, busy, ready, iaddr, idata, cwr, caddr_wr, cdata_wr, crd, caddr_rd, cdata_rd, csel);

	input				clk;
	input				reset;
	output reg			busy;
	input				ready;
			
	output reg	[11:0]	iaddr;
	input		[19:0]	idata;
	
	output reg			cwr;
	output reg	[11:0]	caddr_wr;
	output reg	[19:0]	cdata_wr;
	
	output	 			crd;
	output		[11:0]	caddr_rd;
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


	reg 		[4:0]	state;
	reg 		[4:0]	nstate;

	integer i;

	parameter IDLE = 0, 
				L0_START = 1,
				L0_LeftUp = 2,
				L0_Up = 3,
				L0_RightUp = 4,
				L0_Left = 5,
				L0_Mid = 6,
				L0_Right = 7,
				L0_LeftDown = 8,
				L0_Down = 9,
				L0_RightDown = 10,
				L0_WRITE = 11,
				L0_NEXT = 12,
				done = 31;

	// 0 1 2
	// 3 4 5
	// 6 7 8

	// // kernel 0
	
	// parameter w0_k0 = 20'h0A89E;
	// parameter w1_k0 = 20'h092D5;
	// parameter w2_k0 = 20'h06D43;
	// parameter w3_k0 = 20'h01004;
	// parameter w4_k0 = 20'hF8F71;
	// parameter w5_k0 = 20'hF6E54;
	// parameter w6_k0 = 20'hFA6D7;
	// parameter w7_k0 = 20'hFC834;
	// parameter w8_k0 = 20'hFAC19;

	// parameter bias_k0 = 20'h01310;

	// // kernel 1
	
	// parameter w0_k1 = 20'hFDB55;
	// parameter w1_k1 = 20'h02992;
	// parameter w2_k1 = 20'hFC994;
	// parameter w3_k1 = 20'h050FD;
	// parameter w4_k1 = 20'h02F20;
	// parameter w5_k1 = 20'h0202D;
	// parameter w6_k1 = 20'h03BD7;
	// parameter w7_k1 = 20'hFD369;
	// parameter w8_k1 = 20'h05E68;

	// parameter bias_k1 = 20'hF7295;

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
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			kernel <= 1'b0;
		end
		else if (state == L0_NEXT && (&caddr_wr)) begin
			kernel <= ~kernel;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset)						cwr <= 1'b0;
		else if (state == L0_WRITE)		cwr <= 1'b1;
		else							cwr <= 1'b0;
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cdata_wr <= 12'b0;
		end
		else if (state == L0_WRITE) begin
			cdata_wr <= L0_ans[19] ? 20'h0 : L0_ans;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			caddr_wr <= 12'b0;
		end
		else if (state == L0_NEXT) begin
			caddr_wr <= caddr_wr + 12'b1;
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
			L0_NEXT		: nstate = (kernel == 1'b1 && (&caddr_wr)) ? done : L0_START;
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


// always @(posedge clk or posedge reset) begin
	// 	if (reset)								kernel <= 1'b0;
	// 	else if (state == L0_NEXT && (&caddr_wr))	kernel <= ~kernel;
	// end

	// always @(posedge clk or posedge reset) begin
	// 	if (reset)				busy <= 1'b0;
	// 	else if (ready)			busy <= 1'b1;
	// 	else if (state == done)	busy <= 1'b0;
	// end

	// always @(posedge clk or posedge reset) begin
	// 	if (reset) begin
	// 		caddr_wr <= 12'b0;
	// 	end
	// 	else if (state == L0_NEXT)	begin
	// 		caddr_wr <= caddr_wr + 12'b1;
	// 	end
	// end
	
	// always @(posedge clk or posedge reset) begin
	// 	if (reset) begin
	// 		cdata_wr <= 20'b0;
	// 	end
	// 	else if (state == L0_write)	begin
	// 		cdata_wr <= L0_ans[19] ? 20'h0 : L0_ans;
	// 	end
	// end

	// always @(posedge clk or posedge reset) begin
	// 	if (reset) begin
	// 		iaddr <= 12'b0;
	// 	end
	// 	else begin
	// 		case(nstate)
	// 			L0_Mid 		: iaddr <= caddr_wr;
	// 			L0_LeftUp 	: iaddr <= caddr_wr - 12'd65;
	// 			L0_Up 		: iaddr <= caddr_wr - 12'd64;
	// 			L0_RightUp 	: iaddr <= caddr_wr - 12'd63;
	// 			L0_Left 	: iaddr <= caddr_wr - 12'd1;
	// 			L0_Right 	: iaddr <= caddr_wr + 12'd1;
	// 			L0_LeftDown : iaddr <= caddr_wr + 12'd63;
	// 			L0_Down 	: iaddr <= caddr_wr + 12'd64;
	// 			L0_RightDown: iaddr <= caddr_wr + 12'd65;
	// 			default 	: iaddr <= iaddr;
	// 		endcase
	// 	end
	// end

	// always @(posedge clk or posedge reset) begin
	// 	if (reset) begin
	// 		csel <= 3'b000;
	// 	end
	// 	else if (ready) begin
	// 		csel <= 3'b001;
	// 	end
	// 	else if (state == L0_NEXT && (&caddr_wr) && kernel == 1'b0) begin
	// 		csel <= 3'b010;
	// 	end
	// end

	// assign cwr = (state == L0_write);

	// assign total = conv1 + conv2 + conv3 + conv4 + conv5 + conv6 + conv7 + conv8 + conv9;
	// assign L0_ans = total[35:16] + total[15] + bias;

	// always @(posedge clk or posedge reset) begin
	// 	if (reset) begin
	// 		for (i = 0; i <= 8; i=i+1) begin
	// 			conv[i] <= 40'h0;
	// 		end
	// 	end
	// 	else if (state == L0_START) begin
	// 		for (i = 0; i <= 8; i=i+1) begin
	// 			conv[i] <= 40'h0;
	// 		end
	// 	end
	// 	else begin
	// 		case(state)
	// 			L0_Mid 		: conv[0] <= (kernel) ? idata * w0_k1 : idata * w0_k0;
	// 			L0_LeftUp 	: conv[1] <= (kernel) ? idata * w1_k1 : idata * w1_k0;
	// 			L0_Up 		: conv[2] <= (kernel) ? idata * w2_k1 : idata * w2_k0;
	// 			L0_RightUp 	: conv[3] <= (kernel) ? idata * w3_k1 : idata * w3_k0;
	// 			L0_Left 	: conv[4] <= (kernel) ? idata * w4_k1 : idata * w4_k0;
	// 			L0_Right 	: conv[5] <= (kernel) ? idata * w5_k1 : idata * w5_k0;
	// 			L0_LeftDown : conv[6] <= (kernel) ? idata * w6_k1 : idata * w6_k0;
	// 			L0_Down 	: conv[7] <= (kernel) ? idata * w7_k1 : idata * w7_k0;
	// 			L0_RightDown: conv[8] <= (kernel) ? idata * w8_k1 : idata * w8_k0;
	// 			default		: conv[0] <= conv[0];
	// 		endcase
	// 	end
	// end

