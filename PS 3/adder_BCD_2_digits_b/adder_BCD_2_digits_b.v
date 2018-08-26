module displayNumber(
	input [3:0] decimalNumber,
	output reg [0:6] displayer);
	always @(*)
		case (decimalNumber)
			4'b0000: displayer = 7'b0000001;
			4'b0001: displayer = 7'b1001111;
			4'b0010: displayer = 7'b0010010;
			4'b0011: displayer = 7'b0000110;
			4'b0100: displayer = 7'b1001100;
			4'b0101: displayer = 7'b0100100;
			4'b0110: displayer = 7'b0100000;
			4'b0111: displayer = 7'b0001111;
			4'b1000: displayer = 7'b0000000;
			4'b1001: displayer = 7'b0000100;
			default: displayer = 7'b1111111;
		endcase
endmodule

module displayNumberV2(
	input [3:0] decimalNumber,
	output reg [0:6] displayer);
	always @(*)
		case (decimalNumber)
			0: displayer = 7'b0000001;
			1: displayer = 7'b1001111;
			2: displayer = 7'b0010010;
			3: displayer = 7'b0000110;
			4: displayer = 7'b1001100;
			5: displayer = 7'b0100100;
			6: displayer = 7'b0100000;
			7: displayer = 7'b0001111;
			8: displayer = 7'b0000000;
			9: displayer = 7'b0000100;
			default: displayer = 7'b1111111;
		endcase
endmodule

module adder_BCD_2_digits_b (
	input [8:0] SW,
	output [0:6] HEX0,HEX1,HEX3,HEX5, output [9:0] LEDR);
	assign LEDR[7:0] = SW[7:0];
	integer x,y,cin,enteredNumber;
	integer zet0,c1,s0,s1;
	always @(*) begin
		x = SW[3:0];
		y = SW[7:4];
		cin = SW[8];
		enteredNumber = x + y + cin;
		if (enteredNumber > 19)
			begin
				s0 = 10;
				s1 = 10;
			end
		else if (enteredNumber > 9)
			begin
				zet0 = 10;
				c1 = 1;
				s0 = enteredNumber-zet0;
				s1 = c1;
			end
		else
			begin
				zet0 = 0;
				c1 = 0;
				s0 = enteredNumber;
				s1 = c1;
			end
	end
	displayNumber(SW[3:0],HEX3);
	displayNumber(SW[7:4],HEX5);
	displayNumberV2(s0,HEX0);
	displayNumberV2(s1,HEX1);
endmodule