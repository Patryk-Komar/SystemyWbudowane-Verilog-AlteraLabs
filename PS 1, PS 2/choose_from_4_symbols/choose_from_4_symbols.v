module choose_from_4_symbols (
	input [9:0] SW,
	output [9:0] LEDR, output [6:0] HEX0);
	assign LEDR = SW;
	wire [1:0] muxOut;
	mux_4_1_2_bits ex0(SW[7:0],~SW[9:8],muxOut[1:0]);
	decoder_7_seg ex1(muxOut[1:0],HEX0[6:0]);
endmodule