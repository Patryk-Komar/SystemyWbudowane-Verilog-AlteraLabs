module zad4(
	input CLOCK_50,
	input [9:0] SW,
	input [1:0] KEY,
	output [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	
	wire clk_1_sec;
	wire [4:0] read_addr;
	wire [3:0] q;
	delay_1_sec del_1_sec(CLOCK_50,clk_1_sec);
	
	counter_N_bits cnt_addr(clk_1_sec,KEY[0],1'b1,read_addr);
	
	ram32x4_2_ports mem(CLOCK_50,SW[3:0],read_addr,SW[8:4],SW[9],q);
	
	decoder_hex_16 d0(q,HEX0);
	decoder_hex_16 d1(SW[3:0],HEX1);
	decoder_hex_16 d2(read_addr[3:0],HEX2);
	decoder_hex_16 d3({3'b000,read_addr[4]},HEX3);
	decoder_hex_16 d4(SW[7:4],HEX4);
	decoder_hex_16 d5({3'b000,SW[8]},HEX5);
endmodule

module counter_N_bits(
	input clk,aclr,enable,
	output reg [4:0] Q);
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 		Q <= 5'h0000;
		else if (enable) 	Q <= Q + 1'b1;
		else 		Q <= Q;
endmodule 


module decoder_hex_16(
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


module delay_1_sec(
	input clk,
	output q);
	
	wire [25:0] A;
	wire e;
	
	counter_mod_M #(50000000) ex0(clk,1'b1,1'b1,A);
	
	assign e=~|A;
	
	counter_mod_M #(2) ex1(clk,1'b1,e,q);
endmodule

module counter_mod_M
	#(parameter M=10)
	(input clk,aclr,enable,
	output reg [N-1:0] Q);
	
	localparam N=clogb2(M-1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 		Q <= {N{1'b0}};
		else 	if (Q == M-1)	Q <= {N{1'b0}};
		else 	if (enable) 	Q <= Q + 1'b1;		
		else 			Q <= Q;
endmodule
