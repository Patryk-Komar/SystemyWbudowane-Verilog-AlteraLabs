/* TO DO

REFACTORING - WE NEED TO CHANGE VARIABLES' NAMES, HE DEFINITELY WON'T FIND OUT THEN */


module D1SPL4Y3R(
    input [3:0] number,
    output reg [0:6] H);
    always @(number)
        case (number)
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

module D0D4WACZ(
	input T,clk,aclr,
   output reg Q);
   always @(posedge clk,negedge aclr)
	if (!aclr)
		Q <= 1'b0;
	else if (T)
		Q <= ~Q;
	else
		Q <= Q;
endmodule
 
module counter(
   input clk,aclr,enable,
   output [15:0] q);
   wire [15:1] c;
   assign c[1] = q[0] & enable;
   assign c[2] = q[1] & c[1];
   assign c[3] = q[2] & c[2];
   assign c[4] = q[3] & c[3];
   assign c[5] = q[4] & c[4];
   assign c[6] = q[5] & c[5];
   assign c[7] = q[6] & c[6];
   assign c[8] = q[7] & c[7];
   assign c[9] = q[8] & c[8];
   assign c[10] = q[9] & c[9];
   assign c[11] = q[10] & c[10];
   assign c[12] = q[11] & c[11];
   assign c[13] = q[12] & c[12];
   assign c[14] = q[13] & c[13];
   assign c[15] = q[14] & c[14];
   D0D4WACZ D0D4WACZ0(enable,clk,aclr,q[0]);
   D0D4WACZ D0D4WACZ1(c[1],clk,aclr,q[1]);
   D0D4WACZ D0D4WACZ2(c[2],clk,aclr,q[2]);
   D0D4WACZ D0D4WACZ3(c[3],clk,aclr,q[3]);
   D0D4WACZ D0D4WACZ4(c[4],clk,aclr,q[4]);
   D0D4WACZ D0D4WACZ5(c[5],clk,aclr,q[5]);
   D0D4WACZ D0D4WACZ6(c[6],clk,aclr,q[6]);
   D0D4WACZ D0D4WACZ7(c[7],clk,aclr,q[7]);
   D0D4WACZ D0D4WACZ8(c[8],clk,aclr,q[8]);
   D0D4WACZ D0D4WACZ9(c[9],clk,aclr,q[9]);
   D0D4WACZ D0D4WACZ10(c[10],clk,aclr,q[10]);
   D0D4WACZ D0D4WACZ11(c[11],clk,aclr,q[11]);
   D0D4WACZ D0D4WACZ12(c[12],clk,aclr,q[12]);
   D0D4WACZ D0D4WACZ13(c[13],clk,aclr,q[13]);
   D0D4WACZ D0D4WACZ14(c[14],clk,aclr,q[14]);
   D0D4WACZ D0D4WACZ15(c[15],clk,aclr,q[15]);
endmodule
 
module counter_16_bits(
   input [1:0] SW,
   input [0:0] KEY,
   output [0:6] HEX0,HEX1,HEX2,HEX3);
   wire [15:0] number;
   counter counter0(KEY[0],SW[0],SW[1],number);
	integer zmienna1,zmienna2,zmienna3,zmienna4;
	always @(*) begin
		zmienna1 = number%16;
		zmienna2 = number/16;
		zmienna3 = number/256;
		zmienna4 = number/4096;
	end
   D1SPL4Y3R displayNumber0(zmienna1,HEX0);
   D1SPL4Y3R displayNumber1(zmienna2,HEX1);
	D1SPL4Y3R displayNumber2(zmienna3,HEX2);
	D1SPL4Y3R displayNumber3(zmienna4,HEX3);
endmodule