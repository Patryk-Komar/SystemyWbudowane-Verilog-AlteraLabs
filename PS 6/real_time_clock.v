module decoder_hex_10(
	input [3:0] SW,
	output reg [0:6] HEX,
	output reg E);
	always @(*)
		if(SW>4'b1001) begin
			E=1;
		end
		else begin
		
			E=0;
			casex(SW)
				4'd0: HEX = 7'b0000001;
				4'd1: HEX = 7'b1001111;
				4'd2: HEX = 7'b0010010;
				4'd3: HEX = 7'b0000110;
				4'd4: HEX = 7'b1001100;
				4'd5: HEX = 7'b0100100;
				4'd6: HEX = 7'b0100000;
				4'd7: HEX = 7'b0001111;
				4'd8: HEX = 7'b0000000;
				4'd9: HEX = 7'b0000100;
				default: HEX = 7'b1111111;
			endcase
		end
endmodule

module counter_modulo_k_aload
	#(parameter M=8)
	(input clk,aclr,enable,aload,
	input [N-1:0] data,
	output reg [N-1:0] Q={N{1'b0}},
	output reg rollover);
	localparam N=clogb2(M-1);
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	always @(posedge clk, negedge aclr, posedge aload)
		if (!aclr)
			Q <= {N{1'b0}};
		else if (aload)
			Q <= data;
		else if (Q == M-1)
			Q <= {N{1'b0}};
		else if (enable)
			Q <= Q + 1'b1;		
		else
			Q <= Q;
	always @(*)
		if (Q == M-1)
			rollover = 1'b1;
		else
			rollover = 1'b0;
endmodule

module counter_modulo_k
	#(parameter M=8)
	(input clk,aclr,enable,
	output reg [N-1:0] Q,
	output reg rollover);
	localparam N=clogb2(M-1);
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	always @(posedge clk, negedge aclr)
		if (!aclr)
			Q <= {N{1'b0}};
		else if (Q == M-1)
			Q <= {N{1'b0}};
		else if (enable)
			Q <= Q + 1'b1;
		else
			Q <= Q;
	always @(*)
		if (Q == M-1)
			rollover = 1'b1;
		else
			rollover = 1'b0;
endmodule

module delay_10_ms(
	input clk,
	output q);
	wire [25:0] A;
	wire e;
	counter_modulo_k #(500000) ex0(clk,1'b1,1'b1,A);
	assign e=~|A;
	counter_modulo_k #(2) ex1(clk,1'b1,e,q);
endmodule

module real_time_clock(
	input [2:0] KEY,
	input CLOCK_50,
	input [9:0] SW,
	output [9:0] LEDR,
	output [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	wire c0,c1,c2,c3,c4,c5;
	wire [3:0] h0,h1,h2,h4;
	wire [2:0] h3,h5;
	delay_10_ms del(CLOCK_50,c0);
	counter_modulo_k_aload #(10) counter0(c0,KEY[2],KEY[0],~KEY[1],SW[3:0],h0,c1);
	counter_modulo_k_aload #(10) counter1(~c1,KEY[2],1'b1,~KEY[1],SW[7:4],h1,c2);
	counter_modulo_k #(10) counter2(~c2,KEY[2],1'b1,h2,c3);
	counter_modulo_k #(6) counter3(~c3,KEY[2],1'b1,h3,c4);
	counter_modulo_k #(10) counter4(~c4,KEY[2],1'b1,h4,c5);
	counter_modulo_k #(6) counter5(~c5,KEY[2],1'b1,h5,c6);
	decoder_hex_10 d0(h0,HEX0);
	decoder_hex_10 d1(h1,HEX1);
	decoder_hex_10 d2(h2,HEX2);
	decoder_hex_10 d3({1'b0,h3},HEX3);
	decoder_hex_10 d4(h4,HEX4);
	decoder_hex_10 d5({1'b0,h5},HEX5);
	assign LEDR=SW;
endmodule