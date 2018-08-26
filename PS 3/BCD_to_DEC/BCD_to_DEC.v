module decoder_hex_10 (
	input [3:0] bcd,
	output reg [6:0] H,
	output reg E);
	always @(bcd)
		if (bcd > 4'b1001) begin
			E = 1;
		end
		else begin
			E = 0;
			case (bcd)
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
				default: H = 7'b1111111;
			endcase
		end
endmodule

module BCD_to_DEC (
	input [7:0] SW,
	output [9:0] LEDR, output [6:0] HEX0,HEX1);
	assign LEDR[7:0] = SW[7:0];
	decoder_hex_10 decoder1(SW[3:0],HEX0,LEDR[8]);
	decoder_hex_10 decoder2(SW[7:4],HEX1,LEDR[9]);
endmodule