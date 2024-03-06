`timescale 100ps / 100ps


`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end

module tb2();

reg clk, reset_n, write, read, address;
reg [31:0] writedata;
wire [31:0] readdata;
wire waitreq;


top dut(
  .clk(clk),
  .reset_n(reset_n),
  .read(read),
  .write(write), 
  .writedata(writedata),
  .address(address),
  .readdata(readdata)
);

 
  initial begin
    clk = 1'b1;
  end

  always 
    #1 clk = ~clk;

  initial begin
  reset_n = 1'b1; // reset should now be active low, in accordance with the rest of the system, its not needed for avalon
  #4   
  write = 1'b1;
  address = 1'b1;
  writedata = 0;
  #2 
  address = 1'b0;
  writedata = 32'h437f0000;
  #2
  write = 1'b0;
  #6 
  write = 1'b1;
  writedata = 32'h43000000;
  #2 
  writedata = 32'h42080000;
  #2 
  writedata = 32'h42be0000;
  #2 
  writedata = 32'h42f40000;
  #2 
  writedata = 32'h42a40000;
  #2 
  writedata = 32'h42800000; 
  #2 
  write = 1'b0;
  read = 1'b1;
  #2 
  read = 1'b0;

  end
endmodule 
