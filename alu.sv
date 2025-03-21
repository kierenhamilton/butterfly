module alu (
  input [1:0] opperation,
  input signed [7:0] alu_input_1,
  input signed [7:0] alu_input_2,
  output logic signed [15:0] alu_output
  );

  always_comb
    case (opperation)
      0: alu_output = alu_input_1 * alu_input_2;
      1: alu_output = alu_input_1 + alu_input_2; 
      2: alu_output = alu_input_1 - alu_input_2; 
    endcase
  endmodule

  
