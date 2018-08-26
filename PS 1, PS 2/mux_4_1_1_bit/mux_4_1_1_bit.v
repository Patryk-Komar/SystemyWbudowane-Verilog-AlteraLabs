module mux_4_1_1_bit (
	input [3:0] SW, input [1:0] KEY,
	output reg [0:0] LEDR);
	always @(*)
		case (KEY)
			2'b00: LEDR[0] = SW[0];
			2'b01: LEDR[0] = SW[1];
			2'b10: LEDR[0] = SW[2];
			2'b11: LEDR[0] = SW[3];
		endcase
endmodule