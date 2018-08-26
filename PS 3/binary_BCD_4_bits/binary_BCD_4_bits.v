module binary_BCD_4_bits (
    input [3:0] SW,
    output reg [0:6] HEX0,HEX1);
    always @(SW)
        case (SW[3:0])
            0: begin
                HEX0 = 7'b0000001;
                HEX1 = 7'b0000001;
                end
            1: begin
                HEX0 = 7'b1001111;
                HEX1 = 7'b0000001;
                end
            2: begin
                HEX0 = 7'b0010010;
                HEX1 = 7'b0000001;
                end
            3: begin
					HEX0 = 7'b0000110;
               HEX1 = 7'b0000001;
                end
            4: begin
					HEX0 = 7'b1001100;
                HEX1 = 7'b0000001;
                end
            5: begin
					 HEX0 = 7'b0100100;
                HEX1 = 7'b0000001;
                end
            6: begin
					 HEX0 = 7'b0100000;
                HEX1 = 7'b0000001;
                end
            7: begin
					HEX0 = 7'b0001111;
               HEX1 = 7'b0000001;
               end
            8: begin
					HEX0 = 7'b0000000;
               HEX1 = 7'b0000001;
               end
            9: begin
					HEX0 = 7'b0000100;
               HEX1 = 7'b0000001;
               end
            10: begin
                HEX0 = 7'b0000001;
                HEX1 = 7'b1001111;
                end
            11: begin
                HEX0 = 7'b1001111;
                HEX1 = 7'b1001111;
                end
            12: begin
                HEX0 = 7'b0010010;
                HEX1 = 7'b1001111;
                end
            13: begin
                HEX0 = 7'b0000110;
                HEX1 = 7'b1001111;
                end
            14: begin
                HEX0 = 7'b1001100;
                HEX1 = 7'b1001111;
                end
            15: begin
                HEX0 = 7'b0100100;
                HEX1 = 7'b1001111;
                end
            default: begin
                HEX0 = 7'b1111111;
                HEX1 = 7'b1111111;
                end
        endcase
endmodule