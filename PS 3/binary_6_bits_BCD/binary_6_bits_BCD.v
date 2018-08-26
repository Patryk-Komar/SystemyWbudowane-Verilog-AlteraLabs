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

module binary_6_bits_BCD(
	input [9:0] SW,
	output [0:6] HEX0, HEX1, output [9:0] LEDR);
	
	assign LEDR = SW;
	
	integer enteredInput,tenModulo,tenMultiple;
	
	always @(SW[5:0])
		enteredInput = SW[5:0];
		
	reg [3:0] moduloBinary;
	reg [3:0] multipleBinary;
	
	always @(*)
		begin
         tenModulo = enteredInput%10; 
         tenMultiple = enteredInput/10;
			case (tenModulo)
				0: moduloBinary = 4'b0000;
				1: moduloBinary = 4'b0001;
				2: moduloBinary = 4'b0010;
				3: moduloBinary = 4'b0011;
				4: moduloBinary = 4'b0100;
				5: moduloBinary = 4'b0101;
				6: moduloBinary = 4'b0110;
				7: moduloBinary = 4'b0111;
				8: moduloBinary = 4'b1000;
				9: moduloBinary = 4'b1001;
				default: moduloBinary = 4'b1111;
			endcase
			case (tenMultiple)
				0: multipleBinary = 4'b0000;
				1: multipleBinary = 4'b0001;
				2: multipleBinary = 4'b0010;
				3: multipleBinary = 4'b0011;
				4: multipleBinary = 4'b0100;
				5: multipleBinary = 4'b0101;
				6: multipleBinary = 4'b0110;
				7: multipleBinary = 4'b0111;
				8: multipleBinary = 4'b1000;
				9: multipleBinary = 4'b1001;
				default: multipleBinary = 4'b1111;
			endcase
		end
	
	displayNumber displayModulo(moduloBinary,HEX0);
	displayNumber displayMultiple(multipleBinary,HEX1);

endmodule