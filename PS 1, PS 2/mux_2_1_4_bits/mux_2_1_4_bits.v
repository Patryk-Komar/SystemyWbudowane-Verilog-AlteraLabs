module mux_2_1_4_bits (
	input [7:0] SW, input KEY,
	output reg [3:0] LEDR);
	always @(*)
		case (KEY)
			2'b0: LEDR = SW[3:0];
			2'b1: LEDR = SW[7:4];
		endcase
endmodule