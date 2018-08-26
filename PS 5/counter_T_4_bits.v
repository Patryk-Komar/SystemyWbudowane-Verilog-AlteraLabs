module displayer(
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

module adder(
	input T,clk,aclr,
   output reg Q);
   always @(posedge clk,negedge aclr)
	if (!aclr)
		Q <= 1'b0;
	else if (T)
		Q <= ~Q;
	else
		Q <=  Q;
endmodule
 
module counter(
    input clk,aclr,enable,
    output [3:0] q);
    wire [3:1] c;
    assign c[1] = q[0] & enable;
    assign c[2] = q[1] & c[1];
    assign c[3] = q[2] & c[2];
    adder adder0(enable,clk,aclr,q[0]);
    adder adder1(c[1],clk,aclr,q[1]);
    adder adder2(c[2],clk,aclr,q[2]);
    adder adder3(c[3],clk,aclr,q[3]);
endmodule
 
module counter_T_4_bits(
    input [1:0] SW,
    input [0:0] KEY,
    output [0:6] HEX0);
    wire [3:0] number;
    counter counter0(KEY[0],SW[0],SW[1],number);
    displayer displayNumber(number,HEX0);
endmodule