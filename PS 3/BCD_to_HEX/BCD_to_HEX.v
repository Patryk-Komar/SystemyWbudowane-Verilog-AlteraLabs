module decoder_hex_16 (
    input [3:0] bcd,
    output reg [0:6] H);
    always @(bcd)
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
            10: H = 7'b0001000;
            11: H = 7'b1100000;
            12: H = 7'b0110001;
            13: H = 7'b1000010;
            14: H = 7'b0110000;
            15: H = 7'b0111000;
            default: H = 7'b1111111;
        endcase
endmodule
 
module BCD_to_HEX (
    input [7:0] SW,
    output [0:6] HEX0,HEX1);
    decoder_hex_16 decoder1(SW[3:0],HEX0);
    decoder_hex_16 decoder2(SW[7:4],HEX1);
endmodule