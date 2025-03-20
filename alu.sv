module alu (
  input Clock, 
  input nReset,
  input signed [7:0] a, 
  input signed [15:0] b,
  output signed logic o
  );

  timeunit 1ns; 
  timeprecision 100ps; 

assign o = a * b; 

  endmodule
