module decoder_hex_10 (
        input [3:0] bcd,
        output reg [0:6] H,
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

module adder_BCD_2_digits (
	input [8:0] SW,
	output reg [0:6] HEX0, HEX1, 
	output [0:6] HEX3, HEX5,
	output [9:0] LEDR);

	wire [4:0] sum;
	wire err1, err2;
	
	assign LEDR[7:0] = SW[7:0];
	
	decoder_hex_10 display1(SW[7:4],HEX5,err2);
	decoder_hex_10 display2(SW[3:0],HEX3,err1);
	
	assign LEDR[9] = err1 | err2;
	
	assign sum[4:0] = SW[3:0] + SW[7:4] + SW[8];

	always @(sum) begin
	        case (sum)
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
            16: begin
                HEX0 = 7'b0100000;
                HEX1 = 7'b1001111;
                end
            17: begin
                HEX0 = 7'b0001111;
                HEX1 = 7'b1001111;
                end
            18: begin
                HEX0 = 7'b0000000;
                HEX1 = 7'b1001111;
                end
            19: begin
                HEX0 = 7'b0000100;
                HEX1 = 7'b1001111;
                end
            default: begin
                HEX0 = 7'b1111111;
                HEX1 = 7'b1111111;
                end
        endcase
		
		if(err1 | err2) begin
          HEX0 = 7'b1111111;
          HEX1 = 7'b1111111;
		end
	end
endmodule