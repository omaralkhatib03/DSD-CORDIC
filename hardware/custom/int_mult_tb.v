`timescale 1ns/100ps

module tb();
  
  reg [31:0] a;
  reg [31:0] b;

  wire [31:0] result;
  
  int_mult dut(a, b, result);
  
  initial begin 
    $display($time, " << Starting Simulation >> ");
    $dumpvars();

    a = 3;
    b = 4;
    #1;
    
    a = 5;
    b = 3;
    #1;

  end 

endmodule 

