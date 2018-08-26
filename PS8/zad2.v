module FSM_lab7_part1a(
	input w,clk,aclr,
	output reg z,
	output reg [8:0] y);
	reg [8:0] d;
	always @(*) begin
	d[0] = ~aclr;
	d[1] = y[0] & ~w | y[5] & ~w | y[6] & ~w | y[7] & ~w | y[8] & ~w;
	d[2] = y[1] & ~w;
	d[3] = y[2] & ~w;
	d[4] = y[3] & ~w | y[4] & ~w;
	d[5] = y[0] & w | y[2] & w | y[3] & w | y[4] & w | y[5] & w;
	d[6] = y[5] & w;
	d[7] = y[6] & w;
	d[8] = y[7] & w | y[8] & w;
	end
	always @(*)
	z = y[4] | y[8];
	always @(posedge clk, negedge aclr)
	if (~aclr)
		begin y <= 0; y[0] <= 1'b1; end
	else y <= d;
endmodule 
module zad2(
	input [1:0] SW,
	input [1:0] KEY,
	output [9:0] LEDR);
	FSM_lab7_part1a ex(SW[1],KEY[0],SW[0],LEDR[9],LEDR[8:0]);
endmodule