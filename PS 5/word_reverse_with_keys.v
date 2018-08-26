module wordDisplayer(
    input [2:0] number,
    output reg [0:6] H0,H1,H2,H3,H4,H5);
    always @(number)
        case (number)
            3'b000: begin
                H0 = 7'b0100100;
                H1 = 7'b0110000;
                H2 = 7'b1001111;
                H3 = 7'b0011000;
                H4 = 7'b1111111;
                H5 = 7'b1111111;
            end
            3'b001: begin
                H0 = 7'b1111111;
                H1 = 7'b0100100;
                H2 = 7'b0110000;
                H3 = 7'b1001111;
                H4 = 7'b0011000;
                H5 = 7'b1111111;
            end
            3'b010: begin
                H0 = 7'b1111111;
                H1 = 7'b1111111;
                H2 = 7'b0100100;
                H3 = 7'b0110000;
                H4 = 7'b1001111;
                H5 = 7'b0011000;
            end
            3'b011: begin
                H0 = 7'b0011000;
                H1 = 7'b1111111;
                H2 = 7'b1111111;
                H3 = 7'b0100100;
                H4 = 7'b0110000;
                H5 = 7'b1001111;
            end
            3'b100: begin
                H0 = 7'b1001111;
                H1 = 7'b0011000;
                H2 = 7'b1111111;
                H3 = 7'b1111111;
                H4 = 7'b0100100;
                H5 = 7'b0110000;
            end
            3'b101: begin
                H0 = 7'b0110000;
                H1 = 7'b1001111;
                H2 = 7'b0011000;
                H3 = 7'b1111111;
                H4 = 7'b1111111;
                H5 = 7'b0100100;
            end
            default: begin
                H0 = 7'b1111111;
                H1 = 7'b1111111;
                H2 = 7'b1111111;
                H3 = 7'b1111111;
                H4 = 7'b1111111;
                H5 = 7'b1111111;
            end
        endcase
endmodule

module counter(
	input right,
	input left,
	output reg[2:0] out);
		always @(posedge right or posedge left) begin
			if(left) begin
				if(out < 3'b101)
					out <= out + 1;
				else
					out <= 3'b0;
			end
			else if(right) begin
				if(out > 3'b0)
					out <= out - 1;
				else
					out <= 3'b101;
			end
			else begin
				;
			end
		end
endmodule
 
module word_reverse_with_keys(
   input [1:0] KEY,
   output [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	wire [2:0] positionNumber;
	counter counter0(~KEY[0],~KEY[1],positionNumber);
   wordDisplayer wordPIES(positionNumber,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
endmodule