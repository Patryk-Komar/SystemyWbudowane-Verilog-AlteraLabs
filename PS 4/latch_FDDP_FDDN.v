module latch_FDDP_FDDN(
	input [1:0] SW,
	output reg [2:0] LEDR);
	
	wire [0:0] latchA,latchB,latchC;
	
	latch_D latchOne(SW,latchA);
	
	always @(*)
		LEDR[0] = latchA;
		
	always @(posedge SW[1])
		LEDR[1] = SW[0];
	
	always @(negedge SW[1])
		LEDR[2] = SW[0];
		
endmodule