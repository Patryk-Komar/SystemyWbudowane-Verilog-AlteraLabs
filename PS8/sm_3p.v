module sm_3p(
	input clk, reset, x,
	output reg y);
	reg [1:0] state, next_state;
	parameter [1:0] S0=2'd0, S1=2'd1, S2=2'd2, S3=2'd3;
	always @(*)
		case (state)
			S0:
				if (x) next_state = S1;
				else next_state = S0;
			S1:
				if (x) next_state = S2;
				else next_state = S1;
			S2:
				if (x) next_state = S3;
				else next_state = S2;
			S3:
				if (x) next_state = S0;
				else next_state = S1;
		endcase
	always @(posedge clk)
		if (!reset) state <= 0;
		else state <= next_state;
	always @(*)
		if (state==S1 | state==S3) y=1;
		else y=0;
endmodule