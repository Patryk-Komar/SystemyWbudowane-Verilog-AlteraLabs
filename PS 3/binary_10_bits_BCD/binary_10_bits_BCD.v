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


module binary_10_bits_BCD (
	input [9:0] SW,
	output [0:6] HEX0,HEX1,HEX2,HEX3, output [9:0] LEDR);
	
	assign LEDR = SW;
	
	integer enteredInput,tenModulo,tenMultiple,hundredMultiple,thousandMultiple;
	
	always @(SW[9:0])
		enteredInput = SW[9:0];
		
	reg [3:0] moduloTen,multipleTen,multipleHundred,multipleThousand;
	
	always @(*)
		begin
			tenModulo = enteredInput%10; 
			tenMultiple = (enteredInput/10)%10;
			hundredMultiple = (enteredInput/100)%10;
			thousandMultiple = (enteredInput/1000)%10;
			case (tenModulo)
				0: moduloTen = 4'b0000;
				1: moduloTen = 4'b0001;
				2: moduloTen = 4'b0010;
				3: moduloTen = 4'b0011;
				4: moduloTen = 4'b0100;
				5: moduloTen = 4'b0101;
				6: moduloTen = 4'b0110;
				7: moduloTen = 4'b0111;
				8: moduloTen = 4'b1000;
				9: moduloTen = 4'b1001;
				default: moduloTen = 4'b1111;
			endcase
			case (tenMultiple)
				0: multipleTen = 4'b0000;
				1: multipleTen = 4'b0001;
				2: multipleTen = 4'b0010;
				3: multipleTen = 4'b0011;
				4: multipleTen = 4'b0100;
				5: multipleTen = 4'b0101;
				6: multipleTen = 4'b0110;
				7: multipleTen = 4'b0111;
				8: multipleTen = 4'b1000;
				9: multipleTen = 4'b1001;
				default: multipleTen = 4'b1111;
			endcase
			case (hundredMultiple)
				0: multipleHundred = 4'b0000;
				1: multipleHundred = 4'b0001;
				2: multipleHundred = 4'b0010;
				3: multipleHundred = 4'b0011;
				4: multipleHundred = 4'b0100;
				5: multipleHundred = 4'b0101;
				6: multipleHundred = 4'b0110;
				7: multipleHundred = 4'b0111;
				8: multipleHundred = 4'b1000;
				9: multipleHundred = 4'b1001;
				default: multipleHundred = 4'b1111;
			endcase
			case (thousandMultiple)
				1: multipleThousand = 4'b0001;
				default: multipleThousand = 4'b1111;
			endcase
		end
	
	displayNumber displayHexZero(moduloTen,HEX0);
	displayNumber displayHexOne(multipleTen,HEX1);
	displayNumber displayHexTwo(multipleHundred,HEX2);
	displayNumber displayHexThree(multipleThousand,HEX3);

endmodule