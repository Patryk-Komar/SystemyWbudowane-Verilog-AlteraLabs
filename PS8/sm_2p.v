module sm_2p(
	input clk, reset, x,
	output reg y);
	reg [1:0] state;
	parameter [1:0] S0=2'd0, S1=2'd1, S2=2'd2, S3=2'd3;
	always @(posedge clk)
		if (!reset)
			state <= 0;
		else begin
			case (state)
				S0:
					if (x) state = S1;
					else state = S0;
				S1:
					if (x) state = S2;
					else state = S1;
				S2:
					if (x) state = S3;
					else state = S2;
				S3:
					if (x) state = S0;
					else state = S1;
			endcase
		end
	always @(*)
		if (state==S1 | state==S3) y=1;
		else y=0;
endmodule