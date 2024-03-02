`timescale 100ps / 100ps


`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end

module tb();

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
  .readdata(readdata),
  .waitreq(waitreq)
);

 
  initial
    clk = 1'b1;

  always 
    #1 clk = ~clk;

  initial begin
    reset_n = 1'b1; // reset should now be active low, in accordance with the rest of the system, its not needed for avalon

    // set acc register
    writedata = 32'h0;
    address = 1'b1;
    write = 1'b1;

    #2
    write = 1'b0;

    // initially no data in register should have an accumalator of 0
    #10 // delay to ensure that is true
    
    // write value 255 into x
    writedata = 32'h437f0000;
    address = 1'b0;
    write = 1'b1;
    #2 // wait 1 cycle 

    writedata = 32'h43000000;
    address = 1'b0;
    write = 1'b1;
    #2 // wait 1 cycle 

    // try to read the value
    address = 1'b1;
    write = 1'b0;
    read = 1'b1; // -> should result in wait req going high
    #2 
    read = 1'b0;

    #12 // wait 6 cycles for computation to finish
    read = 1'b1; // -> waitreq should remain 0

    #4 
    read = 1'b0;
    #2

    // set acc register
    writedata = 32'h0;
    address = 1'b1;
    write = 1'b1;

    #2
    writedata = 32'h437f0000;
    address = 1'b0;
    
    #2 
    write = 1'b0;
    read = 1'b1;
    address = 1'b1;

     
    // $finish(0);

  end
endmodule 
