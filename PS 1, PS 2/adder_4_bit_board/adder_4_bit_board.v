module adder_4_bit_board(
	input [9:0] SW,
	output [9:0] LEDR);
	
	wire [2:0] c;
	
	/* adder_1_bit ex0(SW[0],SW[4],SW[9],LEDR[0],c[0]);
	adder_1_bit ex1(SW[1],SW[5],c[0],LEDR[1],c[1]);
	adder_1_bit ex2(SW[2],SW[6],c[1],LEDR[2],c[2]);
	adder_1_bit ex3(SW[3],SW[7],c[2],LEDR[3],LEDR[9]); */
	
	adder_4_bit ex0(SW[3:0],SW[7:4],SW[9],LEDR[3:0],LEDR[9]);
	
endmodule