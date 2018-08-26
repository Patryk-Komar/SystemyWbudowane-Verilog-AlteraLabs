module decoder_7_seg (
	input [1:0] SW,
	output reg [6:0]HEX0);
	always @(*)
		case (SW)
			2'o0: HEX0 = 7'b0000001;
			2'o1: HEX0 = 7'b0000010;
			2'o2: HEX0 = 7'b0000100;
			2'o3: HEX0 = 7'b0001000;
		endcase
endmodule