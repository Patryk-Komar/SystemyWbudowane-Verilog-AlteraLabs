module adder_4_bit(
	input [3:0] A,B,
	input cin,
	output [3:0] S,
	output cout);
	
	wire [2:0] c;
	
	adder_1_bit ex0(A[0],B[0],cin,S[0],c[0]);
	adder_1_bit ex1(A[1],B[1],c[0],S[1],c[1]);
	adder_1_bit ex2(A[2],B[2],c[1],S[2],c[2]);
	adder_1_bit ex3(A[3],B[3],c[2],S[3],cout);
	
endmodule