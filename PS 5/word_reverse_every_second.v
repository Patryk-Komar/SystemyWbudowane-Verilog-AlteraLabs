module displayer(
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

module mux_6_1_2_bits(
	input [1:0] a,b,c,d,e,f,
	input [2:0] s,
	output reg [1:0] m);
	always @(*)
		casex (s)
			3'b000: m=a;
			3'b001: m=b;
			3'b010: m=c;
			3'b011: m=d;
			3'b100: m=e;
			3'b101: m=f;
			default: m=2'b00;
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

module word_reverse_every_second(
	input CLOCK_50,
	input [1:0] SW,
	output [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	wire [2:0] s;
	wire [25:0] A;
	wire e;
	wire [1:0] c0,c1,c2,c3,c4,c5;
	counter_mod_M #(50000000) count0(CLOCK_50,SW[0],SW[1],A);
	assign e = ~|A;
	counter_mod_M #(6) count1(CLOCK_50,SW[0],e,s);
	
	mux_6_1_2_bits ex0(2'b00,2'b01,2'b10,2'b11,2'b11,2'b11,s,c0);
	mux_6_1_2_bits ex1(2'b01,2'b10,2'b11,2'b11,2'b11,2'b00,s,c1);
	mux_6_1_2_bits ex2(2'b10,2'b11,2'b11,2'b11,2'b00,2'b01,s,c2);
	mux_6_1_2_bits ex3(2'b11,2'b11,2'b11,2'b00,2'b01,2'b10,s,c3);
	mux_6_1_2_bits ex4(2'b11,2'b11,2'b00,2'b01,2'b10,2'b11,s,c4);
	mux_6_1_2_bits ex5(2'b11,2'b00,2'b01,2'b10,2'b11,2'b11,s,c5);
	
	displayer d0(c0,HEX5);
	displayer d1(c1,HEX4);
	displayer d2(c2,HEX3);
	displayer d3(c3,HEX2);
	displayer d4(c4,HEX1);
	displayer d5(c5,HEX0);
endmodule