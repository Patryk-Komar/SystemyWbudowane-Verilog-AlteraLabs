module adder_1_bit_board(
	input [2:0] SW,
	output [1:0] LEDR);
	
	adder_1_bit ex1(SW[0],SW[1],SW[2],LEDR[0],LEDR[1]);

endmodule