module proc_with_rom(
	input [9:0] SW,
	input [1:0] KEY,
	output [9:0] LEDR,
	output [0:6] HEX0);
	counter ex1(SW[0], KEY[0], cout);
	rom ex2(cout, KEY[0],q);
	proc ex3(q, SW[0], KEY[1], SW[9],LEDR[9], LEDR[8:0]);
	decoder_hex_16 ex4(cout, HEX0);
endmodule
module counter(Clear, Clock, Q);
  input Clear, Clock;
  output [2:0] Q;
  reg [2:0] Q;
 
  always @(posedge Clock)
    if (Clear)
      Q <= 2'b0;
    else
      Q <= Q + 1;
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