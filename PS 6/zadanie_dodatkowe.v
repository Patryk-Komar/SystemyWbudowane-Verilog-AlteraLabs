module counter_modulo_k
	#(parameter M=8)
	(input clk,aclr,enable,
	output reg [N-1:0] Q,
	output reg rollover);
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
	always @(*)
		if (Q == M-1)
			rollover = 1'b1;
		else
			rollover = 1'b0;
endmodule

module counter_mod_M
   #(parameter M=11)
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

module delay_05_sec(
	input clk,
	output q);
	wire [25:0] A;
	wire e;
	counter_mod_M #(25000000) ex0(clk,1'b1,1'b1,A);
	assign e=~|A;
	counter_mod_M #(2) ex1(clk,1'b1,e,q);
endmodule

module zadanie_dodatkowe(
	input CLOCK_50,
	output [1:1] LEDR);
	wire c0,h1;	
	delay_05_sec del(CLOCK_50,c0);
	counter_modulo_k #(2) count(c0, 1'b1, 1'b1, LEDR[1], h1);
endmodule