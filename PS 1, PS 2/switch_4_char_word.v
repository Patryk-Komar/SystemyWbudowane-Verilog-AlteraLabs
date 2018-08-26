module switch_4_char_word (
	input [9:0] SW,
	output reg [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	always @(*)
		case (SW[9:7])
			3'o0: begin
			HEX0 = 7'b0000001;
			HEX1 = 7'b1001111;
			HEX2 = 7'b0110000;
			HEX3 = 7'b1000010;
			HEX4 = 7'b1111111;
			HEX5 = 7'b1111111;
			end
			3'o1: begin
			HEX1 = 7'b0000001;
			HEX2 = 7'b1001111;
			HEX3 = 7'b0110000;
			HEX4 = 7'b1000010;
			HEX5 = 7'b1111111;
			HEX0 = 7'b1111111;
			end
			3'o2: begin
			HEX2 = 7'b0000001;
			HEX3 = 7'b1001111;
			HEX4 = 7'b0110000;
			HEX5 = 7'b1000010;
			HEX0 = 7'b1111111;
			HEX1 = 7'b1111111;
			end
			3'o3: begin
			HEX3 = 7'b0000001;
			HEX4 = 7'b1001111;
			HEX5 = 7'b0110000;
			HEX0 = 7'b1000010;
			HEX1 = 7'b1111111;
			HEX2 = 7'b1111111;
			end
			3'o4: begin
			HEX4 = 7'b0000001;
			HEX5 = 7'b1001111;
			HEX0 = 7'b0110000;
			HEX1 = 7'b1000010;
			HEX2 = 7'b1111111;
			HEX3 = 7'b1111111;
			end
			3'o5: begin
			HEX5 = 7'b0000001;
			HEX0 = 7'b1001111;
			HEX1 = 7'b0110000;
			HEX2 = 7'b1000010;
			HEX3 = 7'b1111111;
			HEX4 = 7'b1111111;
			end	
		endcase
endmodule