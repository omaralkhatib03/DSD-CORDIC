`timescale 100ps / 100ps

module term_tb();

  reg [31:0] x;
  wire [31:0] result;

  reg clk, clk_en, reset;

  initial
    clk = 1'b1;

  always 
    #1 clk = ~clk;

  term dut(clk, clk_en, ~reset, x, result);
 

  initial begin
    reset = 1'b1;
    clk_en = 1'b1;
    #4 
    x = 32'h0;
    #4
    x = 32'h437f0000;
    #2
    x = 32'h0;

  end
endmodule 
