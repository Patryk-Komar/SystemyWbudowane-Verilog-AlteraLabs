module mux_2_1_1_bit (
	input [1:0] SW, input [0:0] KEY,
	output [0:0] LEDR);
	assign LEDR[0] = (~KEY[0] & SW[0]) | (KEY[0] & SW[1]);
endmodule