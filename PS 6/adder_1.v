module counter_modulo_k
    #(parameter M=20)
    (input clk,aclr,enable,
    output reg [N-1:0] Q,
    output reg rollover);
   
    localparam N=clogb2(M-1);
   
    function integer clogb2(input [31:0] v);
        for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
            v = v >> 1;
    endfunction
   
    always @(posedge clk, negedge aclr) begin
        if (!aclr)
            Q <= {N{1'b0}};
        else if (Q == M-1)
            Q <= {N{1'b0}};
        else if (enable)
            Q <= Q + 1'b1;
        else
            Q <= Q;
    end
   
    always @(*) begin
        if (Q == M-1)
            rollover = 1'b0;
        else
            rollover = 1'b1;
    end
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
 
 
module adder_1(
    input CLOCK_50,
    input [1:0] KEY,
    output [0:6] HEX0,HEX1,HEX2,
    output [1:0] LEDR);
   
    wire c0,c1,c2;
    wire [3:0] h0,h1,h2;
   
    delay_1_sec del(CLOCK_50,c0);
   
    counter_modulo_k #(10) count0(c0,KEY[0],1'b1,h0,c1);
    counter_modulo_k #(10) count1(c1,KEY[0],1'b1,h1,c2);
    counter_modulo_k #(10) count2(c2,KEY[0],1'b1,h2,LEDR[0]);
   
    decoder_hex_10 d0(h0,HEX0);
    decoder_hex_10 d1(h1,HEX1);
    decoder_hex_10 d2(h2,HEX2);
endmodule
 
module decoder_hex_10(
    input [3:0] SW,
    output reg [0:6] HEX0,
    output reg E);
   
    assign LEDR=SW;
    always @(*)
        if(SW>4'b1001) begin
        E=1;
        end
       
        else begin
       
        E=0;
        casex(SW)
            4'd0: HEX0=7'b0000001;
            4'd1: HEX0=7'b1001111;
            4'd2: HEX0=7'b0010010;
            4'd3: HEX0=7'b0000110;
            4'd4: HEX0=7'b1001100;
            4'd5: HEX0=7'b0100100;
            4'd6: HEX0=7'b0100000;
            4'd7: HEX0=7'b0001111;
            4'd8: HEX0=7'b0000000;
            4'd9: HEX0=7'b0000100;
            default: HEX0=7'b1111111;
        endcase
        end
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
        if (!aclr)      Q <= {N{1'b0}};
        else    if (Q == M-1)   Q <= {N{1'b0}};
        else    if (enable)     Q <= Q + 1'b1;      else            Q <= Q;
endmodule