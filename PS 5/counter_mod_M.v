module counter_modulo_M
	#(parameter M=10)
	(input clk,aclr,enable,
	output reg [N-1:0] Q);
	localparam N=clogb2(M-1);
	
	function integer clogb2(input [31:0] v);
	for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
		v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr)
		if (!aclr)
			Q <= {N{1'b0}};
		else if (Q == M-1)
			Q <= {N{1'b0}};
		else if (enable)
			Q <= Q + 1'b1;
		else	
			Q <= Q;
endmodule

module counter_mod_10(
	input clk,aclr,enable,
	output [3:0] Q);
	counter_modulo_M #(10) ex(clk,aclr,enable,Q);
endmodule

module counter(
	input clk,aclr,enable,
	output [0:6] h);
	localparam sizeA=clogb2(50000000);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	wire [sizeA-1:0] A;
	wire e_1_sec;
	wire [3:0] B;
	counter_modulo_M #(50000000) ex0(clk,aclr,enable,A);
	assign e_1_sec = ~|A;
	counter_modulo_M #(9) ex1(clk,aclr,e_1_sec,B);
	displayer displayer0(B,h);
endmodule

module displayer(
	input [3:0] SW,
	output reg [0:6] HEX0);
	always @(*) begin
		casex(SW)
			4'd0: HEX0=7'b0000001;
			4'd1: HEX0=7'b1001111;
			4'd2: HEX0=7'b0010010;
			4'd3: HEX0=7'b0000110;
			4'd4: HEX0=7'b1001100;
			4'd5: HEX0=7'b0100100;
			4'd6: HEX0=7'b0100000;
			4'd7: HEX0=7'b0001111;
			4'd8: HEX0=7'b0000000;
			4'd9: HEX0=7'b0000100;
			default: HEX0=7'b1111111;
		endcase
	end
endmodule

module counter_mod_M(
	input CLOCK_50,
	input [1:0] SW,
	output [0:6] HEX0);
	counter counter0(CLOCK_50,SW[0],SW[1],HEX0);
endmodule