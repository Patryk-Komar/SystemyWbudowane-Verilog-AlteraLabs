module decoder_7_seg(
	input wire [1:0] c,
	output wire [0:6] h);
	assign h[0] = ~c[0] | c[1];
	assign h[1] = c[0];
	assign h[2] = h[1];
	assign h[3] = c[1];
	assign h[4] = h[3];
	assign h[5] = h[0];
	assign h[6] = h[3];
endmodule

module mux_4_1_2_bits(
	input [1:0] a,b,c,d,
	input [1:0] e,
	output reg [1:0] q);
	always @(*)
		case (e)
		    2'b00: q = a[1:0];
		    2'b01: q = b[1:0];
		    2'b10: q = c[1:0];
		    2'b11: q = d[1:0];
		endcase
endmodule

module counter_mod_M
	#(parameter M=8)
	(input clk,aclr,enable,
	output reg [N-1:0] Q);
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
endmodule

module word_4_chars(
	input CLOCK_50,
	input [1:0] SW,
	output [0:6] HEX0,HEX1,HEX2,HEX3);
	wire [1:0] s;
	wire [25:0] A;
	wire e;
	wire [1:0] c0,c1,c2,c3;
	counter_mod_M #(50000000) count0(CLOCK_50,SW[0],SW[1],A);
	assign e = ~|A;
	counter_mod_M #(4) count1(CLOCK_50,SW[0],e,s);
	mux_4_1_2_bits ex0(2'b00,2'b01,2'b10,2'b11,s,c0);
	mux_4_1_2_bits ex1(2'b01,2'b10,2'b11,2'b00,s,c1);
	mux_4_1_2_bits ex2(2'b10,2'b11,2'b00,2'b01,s,c2);
	mux_4_1_2_bits ex3(2'b11,2'b00,2'b01,2'b10,s,c3);
	decoder_7_seg d0(c0,HEX3);
	decoder_7_seg d1(c1,HEX2);
	decoder_7_seg d2(c2,HEX1);
	decoder_7_seg d3(c3,HEX0);
endmodule