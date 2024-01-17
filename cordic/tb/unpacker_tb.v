`timescale 1 ns / 100 ps


module tb() ;

    reg [31:0] data; 

    wire sign, isSpecial; // special values are -1, 1
    wire [31:0] result;

    unpacker dut(data, sign, result, isSpecial);

    initial begin
        $dumpfile("sim/unpacker.vcd");
        $dumpvars();

        data = 32'h3f800000; // should be special, result_invalid
        #1
        data = 32'hbf800000; // second special value, sign = 1
        #1
        data = 32'h2f800000; // 2^-32, smallest value we can represent
        #1
        data = 32'h0; // special goes high
        #1 
        data = 32'h350637bd; // 5 * 10^-7, i.e minimum prec needed
        #1
        data = 32'h3f000000; // 0.5
        #1
        data = 32'hZ;
    end

endmodule