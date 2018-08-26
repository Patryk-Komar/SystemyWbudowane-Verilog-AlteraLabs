module sm_1p(
	input clk, reset, x,
	output reg y);
	reg [1:0] state;
	parameter [1:0] S0=2'd0, S1=2'd1, S2=2'd2, S3=2'd3;
	always @(posedge clk)
		if (!reset)
			state <= 0;
		else begin
			case (state)
				S0: begin
					y <= 0;
					if (x) state = S1;
					else state = S0;
					end
				S1: begin
					y <= 1;
					if (x) state = S2;
					else state = S1;
					end
				S2: begin
					y <= 0;
					if (x) state = S3;
					else state = S2;
					end
				S3: begin
					y <= 1;
					if (x) state = S0;
					else state = S1;
					end
			endcase
		end
endmodule