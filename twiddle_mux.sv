module twiddle_mux (
  input [2:0] twiddle_select, 
  output logic [7:0] Itw, 
  output logic [7:0] Rtw
  );
  
  localparam MINUSONE        = 8'b1000_0000;
  localparam ONE             = 8'b0111_1111;
  localparam ONEONROOT2      = 8'b0101_1011;
  localparam MINUSONEONROOT2 = 8'b1010_0101;
  localparam ZERO            = 8'b0000_0000; 

  always_comb
    case (twiddle_select)
      0: begin Rtw = ONE;             Itw = ZERO; end
      1: begin Rtw = ONEONROOT2;      Itw = MINUSONEONROOT2; end
      2: begin Rtw = ZERO;            Itw = MINUSONE; end
      3: begin Rtw = MINUSONEONROOT2; Itw = MINUSONEONROOT2; end
      4: begin Rtw = MINUSONE;        Itw = ZERO; end
      5: begin Rtw = MINUSONEONROOT2; Itw = ONEONROOT2; end
      6: begin Rtw = ZERO;            Itw = ONE; end
      7: begin Rtw = ONEONROOT2;      Itw = ONEONROOT2; end
    endcase

  endmodule

