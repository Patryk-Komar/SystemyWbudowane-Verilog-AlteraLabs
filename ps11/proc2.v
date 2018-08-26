module proc2 (DIN, Resetn, Clock, Run, Done, BusWires, ADDR, DOUT, W, Tstep_Q, R0);
  input [15:0] DIN;
  input Resetn, Clock, Run;
  output reg Done;
  output reg [15:0] BusWires;
  output [15:0] ADDR, DOUT;
  output W;
  output [2:0] Tstep_Q;
  output [15:0] R0;
 
  //declare variables
  reg IRin, DINout, Ain, Gout, Gin, AddSub, incr_pc, ADDRin, DOUTin, W_D;
  reg [7:0] Rout, Rin;
  wire [7:0] Xreg, Yreg;
  wire [1:9] IR;
  wire [1:3] I;
  reg [9:0] MUXsel;
  (* keep *) reg [15:0] R0, R1, R2, R3, R4, R5, R6, R7, result;
  wire [15:0] A, G;
  wire [2:0] Tstep_Q;
 
  wire Clear = Done | ~Resetn;
  upcount Tstep (Clear, Clock, Tstep_Q);
  assign I = IR[1:3];
  dec3to8 decX (IR[4:6], 1'b1, Xreg);
  dec3to8 decY (IR[7:9], 1'b1, Yreg);
  always @(Tstep_Q or I or Xreg or Yreg)
  begin
    //specify initial values
    IRin = 1'b0;
    Rout[7:0] = 8'b00000000;
    Rin[7:0] = 8'b00000000;
    DINout = 1'b0;
    Ain = 1'b0;
    Gout = 1'b0;
    Gin = 1'b0;
    AddSub = 1'b0;
    DOUTin = 1'b0;
    ADDRin = 1'b0;
    W_D = 1'b0;
    incr_pc = 1'b0;
 
    Done = 1'b0;
 
    case (Tstep_Q)
      3'b000: // load next instruction in time step 0
      begin
        Rout = 8'b00000001;
        ADDRin = 1'b1;
        incr_pc = 1'b1;
      end
      3'b001: // store next instruction in time step 1
      begin
        IRin = 1'b1; // should this be ANDed with Run?
        ADDRin = 1'b1;
      end
      3'b010: //define signals in time step 1
        case (I)
          3'b000: // mv
          begin
            Rout = Yreg;
            Rin = Xreg;
            Done = 1'b1;
          end
          3'b001: // mvi
          begin
            DINout = 1'b1;
            Rin = Xreg;
            Done = 1'b1;
            incr_pc = 1'b1;
          end
          3'b010: // add
          begin
            Rout = Xreg;
            Ain = 1'b1;
          end
          3'b011: // sub
          begin
            Rout = Xreg;
            Ain = 1'b1;
          end
          3'b100: // ld
          begin
            Rout = Yreg;
            ADDRin = 1'b1;
          end
          3'b101: // st
          begin
            Rout = Xreg;
            DOUTin = 1'b1;
          end
          3'b110: // mvnz
          begin
            if (G != 0) begin
              Rout = Yreg;
              Rin = Xreg;
            end
            Done = 1'b1;
          end
        endcase
      3'b011: //define signals in time step 2
        case (I)
          3'b010: // add
          begin
            Rout = Yreg;
            Gin = 1'b1;
          end
          3'b011: // sub
          begin
            Rout = Yreg;
            Gin = 1'b1;
            AddSub = 1'b1;
          end
          3'b100: // ld
          begin
            DINout = 1'b1;
            Rin = Xreg;
            Done = 1'b1;
          end
          3'b101: // st
          begin
            Rout = Yreg;
            ADDRin = 1'b1;
            W_D = 1'b1;
          end
        endcase
      3'b100: //define signals in time step 3
        case (I)
          3'b010: // add
          begin
            Gout = 1'b1;
            Rin = Xreg;
            Done = 1'b1;
          end
          3'b011: // sub
          begin
            Gout = 1'b1;
            Rin = Xreg;
            Done = 1'b1;
          end
        endcase
    endcase
  end
 
  //instantiate registers and the adder/subtracter unit
  //regn reg_0 (BusWires, Rin[0], Clock, R0);
  counterlpm reg_0 (1'b1, Clock, incr_pc, BusWires, ~Resetn, Rin[0], R0);
  regn reg_1 (BusWires, Rin[1], Clock, R1);
  regn reg_2 (BusWires, Rin[2], Clock, R2);
  regn reg_3 (BusWires, Rin[3], Clock, R3);
  regn reg_4 (BusWires, Rin[4], Clock, R4);
  regn reg_5 (BusWires, Rin[5], Clock, R5);
  regn reg_6 (BusWires, Rin[6], Clock, R6);
  regn reg_7 (BusWires, Rin[7], Clock, R7);
 
  regn reg_IR (DIN, IRin, Clock, IR);
  defparam reg_IR.n = 9;
  regn reg_A (BusWires, Ain, Clock, A);
  regn reg_G (result, Gin, Clock, G);
 
  regn reg_ADDR (BusWires, ADDRin, Clock, ADDR);
  regn reg_DOUT (BusWires, DOUTin, Clock, DOUT);
  regn reg_W (W_D, 1'b1, Clock, W);
  defparam reg_W.n = 1;
 
  addsub AS (~AddSub, A, BusWires, result);
 
  //define the bus
  always @ (MUXsel or Rout or Gout or DINout)
  begin
    MUXsel[9:2] = Rout;
    MUXsel[1] = Gout;
    MUXsel[0] = DINout;
   
    case (MUXsel)
      10'b0000000001: BusWires = DIN;
      10'b0000000010: BusWires = G;
      10'b0000000100: BusWires = R0;
      10'b0000001000: BusWires = R1;
      10'b0000010000: BusWires = R2;
      10'b0000100000: BusWires = R3;
      10'b0001000000: BusWires = R4;
      10'b0010000000: BusWires = R5;
      10'b0100000000: BusWires = R6;
      10'b1000000000: BusWires = R7;
    endcase
  end
 
endmodule
 
 
 
module addsub (
    add_sub,
    dataa,
    datab,
    result);
 
    input     add_sub;
    input   [15:0]  dataa;
    input   [15:0]  datab;
    output  [15:0]  result;
 
    wire [15:0] sub_wire0;
    wire [15:0] result = sub_wire0[15:0];
 
    lpm_add_sub lpm_add_sub_component (
                .dataa (dataa),
                .add_sub (add_sub),
                .datab (datab),
                .result (sub_wire0)
                // synopsys translate_off
                ,
                .aclr (),
                .cin (),
                .clken (),
                .clock (),
                .cout (),
                .overflow ()
                // synopsys translate_on
                );
    defparam
        lpm_add_sub_component.lpm_direction = "UNUSED",
        lpm_add_sub_component.lpm_hint = "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO",
        lpm_add_sub_component.lpm_representation = "UNSIGNED",
        lpm_add_sub_component.lpm_type = "LPM_ADD_SUB",
        lpm_add_sub_component.lpm_width = 16;
 
 
endmodule
 
 
module counterlpm (
    clk_en,
    clock,
    cnt_en,
    data,
    sclr,
    sload,
    q);
 
    input     clk_en;
    input     clock;
    input     cnt_en;
    input   [15:0]  data;
    input     sclr;
    input     sload;
    output  [15:0]  q;
 
    wire [15:0] sub_wire0;
    wire [15:0] q = sub_wire0[15:0];
 
    lpm_counter lpm_counter_component (
                .sload (sload),
                .clk_en (clk_en),
                .sclr (sclr),
                .clock (clock),
                .data (data),
                .cnt_en (cnt_en),
                .q (sub_wire0),
                .aclr (1'b0),
                .aload (1'b0),
                .aset (1'b0),
                .cin (1'b1),
                .cout (),
                .eq (),
                .sset (1'b0),
                .updown (1'b1));
    defparam
        lpm_counter_component.lpm_direction = "UP",
        lpm_counter_component.lpm_port_updown = "PORT_UNUSED",
        lpm_counter_component.lpm_type = "LPM_COUNTER",
        lpm_counter_component.lpm_width = 16;
 
 
endmodule
 
module upcount(Clear, Clock, Q);
  input Clear, Clock;
  output [2:0] Q;
  reg [2:0] Q;
 
  always @(posedge Clock)
    if (Clear)
      Q <= 3'b0;
    else
      Q <= Q + 1'b1;
endmodule
 
 
 
 
module dec3to8(W, En, Y);
  input [2:0] W;
  input En;
  output [0:7] Y;
  reg [0:7] Y;
 
  always @(W or En)
  begin
    if (En == 1)
      case (W)
        3'b000: Y = 8'b10000000;
        3'b001: Y = 8'b01000000;
        3'b010: Y = 8'b00100000;
        3'b011: Y = 8'b00010000;
        3'b100: Y = 8'b00001000;
        3'b101: Y = 8'b00000100;
        3'b110: Y = 8'b00000010;
        3'b111: Y = 8'b00000001;
      endcase
    else
      Y = 8'b00000000;
  end
endmodule
 
module regn(R, Rin, Clock, Q);
  parameter n = 16;
  input [n-1:0] R;
  input Rin, Clock;
  output [n-1:0] Q;
  reg [n-1:0] Q;
 
  always @(posedge Clock)
    if (Rin)
      Q <= R;
endmodule