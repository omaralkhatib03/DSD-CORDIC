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
  .readdata(readdata)
);

 
  initial begin
    reset_n = 1'b1; // reset should now be active low, in accordance with the rest of the system, its not needed for avalon
    clk = 1'b1;
  end

  always 
    #1 clk = ~clk;

  initial begin

    // set acc register
    writedata = 32'h0;
    address = 1'b1;
    write = 1'b1;

    #2
    // write = 1'b0;

    // initially no data in register should have an accumalator of 0
    // #10// delay to ensure that is true
    
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
    read = 1'b0; // -> waitreq should remain 0
    // read = 1'b0;

    #20 // wait 6 cycles for computation to finish
    read = 1'b0; // -> waitreq should remain 0

    // set acc register
    writedata = 32'h0;
    address = 1'b1;
    write = 1'b1;
    #2

    // writedata = 32'h43000000;
    // address = 1'b0;
    // write = 1'b1;
    // #2 // wait 1 cycle 

    // write value 255 into x
    writedata = 32'h437f0000;
    address = 1'b0;
    write = 1'b1;
    #2 // wait 1 cycle 

    writedata = 32'h43000000;
    address = 1'b0;
    write = 1'b1;
    #2 // wait 1 cyc

    address = 1'b1;
    write = 1'b0;
    read = 1'b1; // -> should result in wait req going high
    #2 
    read = 1'b0; // -> waitreq should remain 0
    // #16


    //
    // #4 
    // read = 1'b0;
    //
    // // set acc register
    // writedata = 32'h0;
    // address = 1'b1;
    // write = 1'b1;
    //
    // #2
    // writedata = 32'h437f0000;
    // address = 1'b0;
    // 
    // #2 
    // write = 1'b0;
    // read = 1'b1;
    // address = 1'b1;
    //
     
    // $finish(0);

  end
endmodule 
