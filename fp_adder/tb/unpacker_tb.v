`timescale  1 ns / 100 ps 



module tb () ;

    reg [31:0] data; 
    // we dont need a clk now;
    // reg clk;

    wire sign, isNaN, isInf, isZero, isSubn;
    wire [7:0] e;
    wire [22:0] m;

    unpacker dut(data, sign, e, m, isNaN, isInf, isZero, isSubn);


    initial begin
        $dumpfile("sim/unpacker.vcd");
        $dumpvars();

        data = 32'h7f800000; // should be inf
        #1
        data = 32'h7fffffff; // should be Nan
        #1
        data = 32'h0020aac8; // should be subn
        #1
        data = 32'h0; // should be 0
        #1 
        data = 32'h42000000; // no flags, 32
        #1
        data = 32'he97e1c91;
        #1
        data = 32'hZ;
    end

endmodule