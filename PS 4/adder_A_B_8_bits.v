module regN(reset, CLK, D, Q);
	input reset;
	input CLK;
	parameter N = 8;
	input [N-1:0] D;
	output [N-1:0] Q;
	reg [N-1:0] Q;

	always @(posedge CLK or posedge reset)
		if (reset)
			Q = 0;
		else
			Q = D;

	
endmodule	
	
module displayer(
    input [3:0] liczba,
    output reg [0:6] H);
    always @(*)
        case (liczba)
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
            10: H = 7'b0001000;
            11: H = 7'b1100000;
            12: H = 7'b0110001;
            13: H = 7'b1000010;
            14: H = 7'b0110000;
            15: H = 7'b0111000;
            default: H = 7'b1111111;
            endcase
endmodule

module adder_A_B_8_bits(
	input [7:0] SW, 
	input [1:0] KEY,
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output [0:0] LEDR);
	
	wire [7:0] myNumber;
	
	regN #(8) newRegister(~KEY[0], ~KEY[1], SW[7:0], myNumber);
	
	integer sum, cout, mod16, multiple16, _sum;
	integer firstMod, firstMulti;
	integer secondMod, secondMulti;
	
	always @(SW[7:0] or myNumber[7:0]) begin
	/* sumator */
		sum = SW[7:0] + myNumber[7:0];
		_sum = sum % 256;
		cout = sum/256 > 0 ? 1 : 0;
		mod16 = _sum % 16;
		multiple16 = _sum / 16;
		
	/* odejmowanie
		if(SW[7:0] > myNumber[7:0]) begin
			cout = 1;
			sum = SW[7:0] - myNumber[7:0];
		end
		else begin
			cout = 0;
			sum = myNumber[7:0] - SW[7:0];
		end
		
		mod16 = sum % 16;
		multiple16 = sum / 16;
		
	/* koniec odejmowania	*/
		
		firstMod = SW[7:0] % 16;
		firstMulti = SW[7:0] / 16;
		secondMod = myNumber[7:0] % 16;
		secondMulti = myNumber[7:0] / 16;
	end
	
	assign LEDR[0] = cout;
	
	displayer displayHex5(multiple16, HEX5);
	displayer displayHex4(mod16, HEX4);
	
	displayer displayHex3(firstMulti, HEX3);
	displayer displayHex2(firstMod, HEX2);
	
	displayer displayHex1(secondMulti, HEX1);
	displayer displayHex0(secondMod, HEX0);
	
	
	
	
endmodule