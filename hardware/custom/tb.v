`timescale 100ps / 100ps

module tb();

  reg [31:0] x;
  wire [31:0] result;

  reg clk, clk_en, reset;

  initial
    clk = 1'b1;

  always 
    #1 clk = ~clk;

  top dut(clk, reset, clk_en, x, result);
 

  initial begin
    reset = 1'b0;
    clk_en = 1'b1;

    x = 32'h437f0000;
    #20
    $display("input: %h,", x, "result: %h", result);

  end
endmodule 
