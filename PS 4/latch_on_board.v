module latch_on_board(
	input [2:0] SW,
	output [0:0] LEDR);
	(* KEEP = "TRUE" *) wire R_g, S_g, Qa, Qb;
	assign R_g = (SW[1] & SW[2]);
	assign S_g = (SW[0] & SW[2]);
	assign Qa = ~(R_g | Qb);
	assign Qb = ~(S_g | Qa);
	assign LEDR[0] = Qa;
endmodule