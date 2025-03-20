module alu_stim; 

timeunit 1ns; 
timeprecision 100ps; 

logic Clock;
logic nReset; 
logic [7:0] a; 
logic [7:0] b;

wire o;

alu dut (
  .Clock(Clock), 
  .nReset(nReset),
  .a(a),
  .b(b),
  .o(o)
  );

  always begin Clock = 1; #5 Clock = 0; #5 Clock = 1; end

  initial begin
    a = 7'd2;
    b = 7'd3;
    #100
    a= 7'd4;
    b= 7'd5;
    #100
    $finish; 
  end


endmodule
