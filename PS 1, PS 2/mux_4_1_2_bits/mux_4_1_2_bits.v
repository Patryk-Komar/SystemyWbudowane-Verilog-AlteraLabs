module mux_4_1_2_bits (
	input [7:0] SW, input [1:0] KEY,
	output reg [1:0] LEDR);
	always @(*)
		case (KEY)
			2'b00: LEDR = SW[1:0];
			2'b01: LEDR = SW[3:2];
			2'b10: LEDR = SW[5:4];
			2'b11: LEDR = SW[7:6];
		endcase
endmodule