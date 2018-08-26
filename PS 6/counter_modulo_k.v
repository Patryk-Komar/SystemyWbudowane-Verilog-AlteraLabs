module counter_modulo_k
	#(parameter M=20)
	(input clk,aclr,enable,
	output reg [N-1:0] Q,
	output reg rollover);
	
	localparam N=clogb2(M-1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr) begin
		if (!aclr)
			Q <= {N{1'b0}};
		else if (Q == M-1)
			Q <= {N{1'b0}};
		else if (enable)
			Q <= Q + 1'b1;
		else
			Q <= Q;
	end
	
	always @(*) begin
		if (Q == M-1)
			rollover = 1'b1;
		else 
			rollover = 1'b0;
	end
endmodule


module program
	(input [2:0] KEY,
	output [9:0] LEDR);

	counter_modulo_k #(20) dzialaj(~KEY[0], KEY[1],KEY[2], LEDR[4:0], LEDR[9]);
	
	
endmodule