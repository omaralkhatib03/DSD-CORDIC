`timescale 100ps / 100ps

module tb();

  reg [31:0] x;
  wire [31:0] result;

  reg clk, clk_en, reset, start;
  wire done;

  initial
    clk = 1'b1;

  always 
    #1 clk = ~clk;

  top dut(clk, clk_en, reset, x, result, start, done);
 

  initial begin
    reset = 1'b0;
    clk_en = 1'b0;
    start = 1'b0;
    #4 

    
    clk_en = 1'b1;
    start = 1'b1;
    x = 32'h437f0000;
    #2
    start = 1'b0;
    


    #20
    $display("input: %h,", x, "result: %h", result);

  end
endmodule 
