module array_multiplier_4_bits(
input [7:0]SW,
//a 0-3  b 4-7
output [7:0]LEDR,
output [0:6]HEX0, HEX2, HEX4, HEX5);
 
wire [39:0]w;
 
 
and a1(w[0],SW[0],SW[4]);
and a2(w[1],SW[1],SW[4]);
and a3(w[2],SW[2],SW[4]);
and a4(w[3],SW[3],SW[4]);
 
and a5(w[4],SW[0],SW[5]);
and a6(w[5],SW[1],SW[5]);
and a7(w[6],SW[2],SW[5]);
and a8(w[7],SW[3],SW[5]);
 
and a9(w[8],SW[0],SW[6]);
and a10(w[9],SW[1],SW[6]);
and a11(w[10],SW[2],SW[6]);
and a12(w[11],SW[3],SW[6]);
 
and a13(w[12],SW[0],SW[7]);
and a14(w[13],SW[1],SW[7]);
and a15(w[14],SW[2],SW[7]);
and a16(w[15],SW[3],SW[7]);
 
assign LEDR[0]=w[0];
//full adders instatiations
fulladder a17(1'b0,w[1],w[4],w[16],w[17]);
fulladder a18(1'b0,w[2],w[5],w[18],w[19]);
fulladder a19(1'b0,w[3],w[6],w[20],w[21]);
 
fulladder a20(w[8],w[17],w[18],w[22],w[23]);
fulladder a21(w[9],w[19],w[20],w[24],w[25]);
fulladder a22(w[10],w[7],w[21],w[26],w[27]);
 
fulladder a23(w[12],w[23],w[24],w[28],w[29]);
fulladder a24(w[13],w[25],w[26],w[30],w[31]);
fulladder a25(w[14],w[11],w[27],w[32],w[33]);
 
fulladder a26(1'b0,w[29],w[30],w[34],w[35]);
fulladder a27(w[31],w[32],w[35],w[36],w[37]);
fulladder a28(w[15],w[33],w[37],w[38],w[39]);
 
assign LEDR[1]=w[16];
assign LEDR[2]=w[22];
assign LEDR[3]=w[28];
assign LEDR[4]=w[34];
assign LEDR[5]=w[36];
assign LEDR[6]=w[38];
assign LEDR[7]=w[39];
 
 
display d1(SW[3:0], HEX0);
display d2(SW[7:4], HEX2);
display d3(LEDR[7:0] % 16, HEX4);
display d4(LEDR[7:0] / 16, HEX5);
 
 
 
endmodule
 
module fulladder(
input a,b,c,
output s,ca);
assign s=(a^b^c);
assign ca=((a&b)|(b&c)|(c&a));
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