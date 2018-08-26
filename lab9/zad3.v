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

module my_ram32x4_3(
	input [4:0] Address,
	input clk,
	input [3:0] DataIn,
	input Write,
	output [3:0] DataOut);
	
	reg [3:0] memory_array[31:0];
	
	reg [4:0] reg_Address;
	reg [3:0] reg_DataIn;
	reg reg_Write;
	
	always @(posedge clk)
	begin
		reg_Address <= Address;
		reg_DataIn <= DataIn;
		reg_Write <= Write;
	end
	
	always @(*)
		if (reg_Write) memory_array[reg_Address] = reg_DataIn;
	
	assign DataOut = memory_array[reg_Address];
	
endmodule

module zad3(
	input [9:0] SW,
	input [1:0] KEY,
	output [0:6] HEX0,HEX2,HEX4,HEX5);
	
	wire [3:0] h0;
	
	my_ram32x4_3 exm(SW[8:4],KEY[0],SW[3:0],SW[9],h0);
	
	decoder_hex_16 d5({3'b000,SW[8]},HEX5);
	decoder_hex_16 d4(SW[7:4],HEX4);
	decoder_hex_16 d2(SW[3:0],HEX2);
	decoder_hex_16 d0(h0,HEX0);
endmodule