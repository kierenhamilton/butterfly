module butterfly (
  input Clock, 
  input nReset,           // switch 9
  input [7:0] sswitch,    // switches 0 through 7
  input control,          // switch 8
  );

timeunit 1ns; 
timeprecision 100ps; 

logic [4:0] state; 
logic [2:0] twiddle_lookup
logic [7:0] Reb;
logic [7:0] Rea; 

always_ff @(posedge Clock, negedge nReset)
  if (!nReset)
    begin
      state <= 0; 
    end

    else 
      case (state)
        0: begin // control = 1
          if (control == 0) state <= 1; 
        end
        1: begin // control = 0
          if (control == 1) state <= 2; 
        end
        2: begin // control = 1 
          if (control == 0)  
            begin
              state <= 3;
              twiddle_lookup <= sswitch[2:0];
            end
        end:
        3: begin // control = 0 
          if (control == 1) state <= 4; 
        end
        4: begin // control = 1 
          if (control == 0) begin
           state <= 5; 
           Reb <= sswitch; 
         end
        end
        5: begin // control = 0
        if (control == 1) begin
            state <= 6; 
            Rea <= sswitch; 
          end
        end
        6: begin // control = 1 
          if (control == 0) begin
            state <= 7;
          end
        end
        7: begin // control = 0
        end
        8: begin
        end
        9: begin
        end
      endcase
