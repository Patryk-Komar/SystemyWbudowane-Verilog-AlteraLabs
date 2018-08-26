module display(
	input [3:0] liczba,
	output reg [0:6] H);
   always @(*)
	case (liczba)
		0: H = 7'b0000001;
		1: H = 7'b1001111;
		2: H = 7'b0010010;
		3: H = 7'b0000110;
		4: H = 7'b1001100;
		5: H = 7'b0100100;
		6: H = 7'b0100000;
		7: H = 7'b0001111;
		8: H = 7'b0000000;
		9: H = 7'b0000100;
		10: H = 7'b0001000;
		11: H = 7'b1100000;
		12: H = 7'b0110001;
		13: H = 7'b1000010;
		14: H = 7'b0110000;
		15: H = 7'b0111000;
		default: H = 7'b1111111;
	endcase
endmodule

module accumulator_N_bits_always_aclr
	#(N=8)
	(input [N-1:0] A,
	input clk,aclr,
	output reg [N-1:0] S,
	output reg overflow,carry);	
	reg [N-1:0] B;
	always @(posedge clk, negedge aclr)
		if (!aclr)
			B <= {N{1'b0}};
		else
			B <= A;	
	always @(posedge clk, negedge aclr)
		if (!aclr)
			{carry,S} <= {(N+1){1'b0}};
		else
			{carry,S} <= B + S;	
	always @(posedge clk, negedge aclr)
		if (!aclr)
			overflow <= 1'b0;
		else
			overflow <= carry ^ S[N-1];
endmodule

module accum_N_bits(
	input [7:0] SW,
	input [1:0] KEY,
	output [9:0] LEDR,
	output [0:6] HEX0,HEX1,HEX2,HEX3);
	wire [3:0] AH,AL,SH,SL;
	assign LEDR[7:0] = SW;
	assign {AH,AL} = SW;
	accumulator_N_bits_always_aclr #(8) ex(SW, KEY[1], KEY[0], {SH,SL}, LEDR[8], LEDR[9]);
	display d3(AH,HEX3);
	display d2(AL,HEX2);
	display d1(SH,HEX1);
	display d0(SL,HEX0);
endmodule 