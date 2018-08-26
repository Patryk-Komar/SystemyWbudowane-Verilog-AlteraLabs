module latch_D(
	input [1:0] SW,
	output [0:0] LEDR);
	(* KEEP = "TRUE" *) wire S,R,S_g,R_g,Qa,Qb;
	assign S = SW[0];
	assign R = ~SW[0];
	assign S_g = ~(S & SW[1]);
	assign R_g = ~(R & SW[1]);
	assign Qa = ~(S_g & Qb);
	assign Qb = ~(R_g & Qa);
	assign LEDR[0] = Qa;
endmodule