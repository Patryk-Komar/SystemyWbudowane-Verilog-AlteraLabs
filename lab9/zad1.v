module zad1(
	input [4:0] Address,
	input clk,
	input [3:0] DataIn,
	input Write,
	output [3:0] DataOut);
	
	ram32x4 my(Address,clk,DataIn,Write,DataOut);
endmodule

module decoder_hex_16(
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