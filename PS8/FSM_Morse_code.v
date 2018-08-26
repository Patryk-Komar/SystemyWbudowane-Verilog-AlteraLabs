module FSM_Morse_code (SW,KEY,CLOCK_50,LEDR,LEDG);
    input [2:0] SW;
    input [1:0] KEY;
    input CLOCK_50;
    output [0:0] LEDR;
    output [2:0] LEDG; 
    reg [25:0] count;    
    reg [2:0] length;
    reg [2:0] counter;
    reg [3:0] M;   
    reg [3:0] Q;   
    reg z;    
    reg[2:0] y_Q, Y_D;   
    parameter Qa = 3'b000, Ra = 3'b001, Sa = 3'b010, Ta = 3'b011, Ua = 3'b100, Va = 3'b101, Wa = 3'b110, Xa = 3'b111;
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;
    assign LEDR = z;
    always @(SW)
    begin: letter_selection
        case(SW[2:0])
            Qa: begin
                    length = 3'b010;
                    M = 4'b0100;
                end
            Ra: begin
                    length = 3'b100;
                    M = 4'b1000;
                end
            Sa: begin
                    length = 3'b100;
                    M = 4'b1010;
                end
            Ta: begin
                    length = 3'b011;
                    M = 4'b1000;
                end
            Ua: begin
                    length = 3'b001;
                    M = 4'b0000;
                end
            Va: begin
                    length = 3'b100;
                    M = 4'b0010;
                end
            Wa: begin
                    length = 3'b011;
                    M = 4'b1100;
                end
            Xa: begin
                    length = 3'b100;
                    M = 4'b0000;
                end
        endcase
    end
    always @(Q[3], KEY[1:0], counter, y_Q)     
    begin: state_table
        case (y_Q)
            A: if (!KEY[1]) Y_D = B;
                else Y_D = A;
            // State B => State Selection State  
            B: if (!Q[3]) Y_D = E;
                else Y_D = C;
            // B -> C -> D -> => 1.5 seconds => dash
            C: if (!KEY[0]) Y_D = A;
                else Y_D = D;          
            D: if (!KEY[0]) Y_D = A;
                else Y_D = E;          
            E: if (counter == 0) Y_D = A;
                else Y_D = B;              
        default: Y_D = 3'bxxx;
        endcase
    end
    always @(posedge CLOCK_50)
    begin
        if (count < 50000000/2)
            count <= count + 1;
        else
        begin
            count <= 0;
            y_Q <= Y_D;
            if (Y_D == A) begin
                counter <= length;
                Q <= M;
            end
            if (Y_D == E) begin  
                counter <= counter - 1;
                Q[3] <= Q[2];
                Q[2] <= Q[1];
                Q[1] <= Q[0];
                Q[0] <= 1'b0;
            end
        end
    end
    always @(y_Q)
    begin: zassign
        case (y_Q)
            B: z = 1; // turn on output
            C: z = 1; // turn on output
            D: z = 1; // turn on output
            default: z = 0; // off output at States E or A
        endcase
    end
endmodule