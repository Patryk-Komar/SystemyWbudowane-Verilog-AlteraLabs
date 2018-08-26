module register_N_bits_aclr_ena
	#(parameter N=8)
	(input [N-1:0] D,
	input clk,aclr,ena,
	output reg[N-1:0] Q);
	
	always @(posedge clk,negedge aclr)
			if (~aclr) 	Q <= {N{1'b0}};
			else if (ena)	Q <= D;
			else		Q <= Q;
endmodule

module adder_N_bits
	#(parameter N=8)
	(input [N-1:0] A,B,
	input cin,
	output [N-1:0] S,
	output cout);
	
	assign {cout,S} = A + B + cin;
	
endmodule


module multiplier
	#(parameter N=4)
	(input [N-1:0] a,b,
	output [2*N-1:0] p);
	
	wire [7:0] m[7:0]; 	// jednowymiarowa macierz elementów 4-bitowych,
			// cząstkowe wartości mnożenia a * b
	wire [7:0] s[1:7];	// sumy cząstkowe

	wire cout[1:7]; 	// przeniesienia z 4-bitowych sumatorów szeregowych 
	
	genvar i;
	
	// formowanie cząstkowych wyników mnożenia
	generate
		for(i=0; i<N; i=i+1) begin:bl1
			assign m[i] = a & {N{b[i]}};
		end
	endgenerate
	
	// formowanie sum cząstkowych
	adder_N_bits #(N) ex1({1'b0,m[0][N-1:1]},m[1],1'b0,s[1],cout[1]);
	generate
		for(i=2; i<N; i=i+1) begin:bl2
			adder_N_bits #(N) 
			exi({cout[i-1],s[i-1][N-1:1]},m[i],1'b0,s[i],cout[i]);
		end
	endgenerate
	
	// formowanie wyniku
	assign p[0] = m[0][0];
	generate
		for(i=1;i<N-1;i=i+1) begin:bl3
			assign p[i] = s[i][0];
		end
	endgenerate
	
	assign p[2*N-2:N-1] = s[N-1];
	assign p[2*N-1] = cout[N-1];
endmodule


module display(
    input [3:0] liczba,
    output reg [0:6] H);
   always @(*)
        case (liczba)
            0: H = 7'b0000001;
            1: H = 7'b1001111;
            2: H = 7'b0010010;
            3: H = 7'b0000110;
            4: H = 7'b1001100;
            5: H = 7'b0100100;
            6: H = 7'b0100000;
            7: H = 7'b0001111;
            8: H = 7'b0000000;
            9: H = 7'b0000100;
            10: H = 7'b0001000;
            11: H = 7'b1100000;
            12: H = 7'b0110001;
            13: H = 7'b1000010;
            14: H = 7'b0110000;
            15: H = 7'b0111000;
        default: H = 7'b1111111;
    endcase
endmodule

module multiplier_N_bits(
	input [9:0] SW,
	input [1:0] KEY,
	output [9:0] LEDR,
	output [0:6] HEX0,HEX1,HEX2,HEX3);
	
	wire EA,EB,clk,aclr;
	wire [7:0] data,A,B;
	wire [15:0] M,P;
	
	assign LEDR = SW;
	assign EA = SW[9];
	assign EB = SW[8];
	assign clk = KEY[1];
	assign aclr = KEY[0];
	assign data = SW[7:0];
	
	register_N_bits_aclr_ena #(8) exA(data,clk,aclr,EA,A);
	register_N_bits_aclr_ena #(8) exB(data,clk,aclr,EB,B);
	
	multiplier #(8) exM(A,B,M);
	
	register_N_bits_aclr_ena #(16) exP(M,clk,aclr,1'b1,P);
	
	display d0(P[3:0],HEX0);
	display d1(P[7:4],HEX1);
	display d2(P[11:8],HEX2);
	display d3(P[15:12],HEX3);
	
endmodule