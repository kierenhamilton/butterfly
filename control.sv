module control (
  input Clock,
  input nReset,
  input control,
  input [7:0] sswitch,
  input [15:0] alu_output, 
  input [7:0] MuxItw,
  input [7:0] MuxRtw,
  output logic [1:0] opperation,
  output logic [7:0] alu_input_1,
  output logic [7:0] alu_input_2,
  output logic [7:0] led_out,
  output logic [2:0] twiddle_select
  );

logic [7:0] Itw;
logic [7:0] Rtw;

logic [7:0] Rea;
logic [7:0] Reb;

logic [15:0] bw_r;
logic [15:0] bw_i; 

logic [15:0] Rey;
logic [15:0] Imy; 

logic [15:0] Rez; 
logic [15:0] Imz;

alu dut_alu (
  .opperation(opperation),
  .alu_input_1(alu_input_1),
  .alu_input_2(alu_input_2),
  .alu_output(alu_output)
  );

twiddle_mux dut_twiddle_mux (
  .twiddle_select(twiddle_select),
  .Itw(MuxItw),
  .Rtw(MuxRtw)
  ); 

enum logic [3:0] {
  START,
  IS_LOW,
  GET_TFS,
  PROCESS_TFS,
  GET_REB,
  PROCESS_REB,
  GET_REA_DIS_REY,
  DISP_IMY,
  DISP_REZ,
  DISP_IMZ
  } state; 

always_ff @(posedge Clock, negedge nReset)
  if (!nReset)
  begin
    state <= START; 
    Itw <= 0; 
    Rtw <= 0; 
    Rea <= 0; 
    Reb <= 0; 
    bw_r <= 0; 
    bw_i <= 0; 
    Rey <= 0; 
    Imy <= 0; 
    Rez <= 0; 
    Imz <= 0; 
  end
  else 
    case (state)
      START: if (!control) state <= IS_LOW;
      IS_LOW: if (control) state <= GET_TFS; 
      GET_TFS: begin
        if (!control) state <= PROCESS_TFS; 
        twiddle_select <= sswitch[2:0]; 
      end
      PROCESS_TFS: begin
        if (control) state <= GET_REB;
        Itw <= MuxItw;
        Rtw <= MuxRtw; 
      end
      GET_REB: begin
        if (!control) state <= PROCESS_REB;
        bw_I <= alu_output;
        Reb <= sswitch; 
      end
      PROCESS_REB: begin
        if (control) state <= GET_REA_DIS_REY;
        bw_r <= alu_output;
      end
      GET_REA_DIS_REY: begin
        if (!control) state <= DISP_IMY;
        Rea <= sswitch; 
      end
      DISP_IMY: begin
        if (control) state <= DISP_REZ;
        Rez <= alu_output; 
      end
      DISP_REZ: begin
        if (!control) state <= DISP_IMZ;
        Imz <= alu_output;
      end
      DISP_IMZ: if (control) state <= START;
    endcase

  always_comb
  begin
    opperation = 0; 
    alu_input_1 = 0; 
    alu_input_2 = 0; 
    LED_out = 0;
    case (state)
      GET_REB: begin
        opperation = 0;
        alu_input_1 = Rtw;
        alu_input_2 = ReB;
      end
      PROCESS_REB: begin
        opperation = 0; 
        alu_input_1 = Itw;
        alu_input_2 = ReB;
      end
      GET_REA_DIS_REY: begin
        opperation = 1;
        alu_input_1 = bw_r;
        alu_input_2 = Rea;
        LED_out = alu_output;
      end
      DISP_IMY: begin
        opperation = 2; 
        alu_input_1 = 0; 
        alu_input_2 = bw_i;
      end
      DISP_REZ: begin
        LED_out = Rez;
        opperation = 2; 
        alu_input_1 = 0;
        alu_input_2 = bw_I;
      end
      DISP_IMZ: LED_out = Imz; 
    endcase
  end

endmodule
