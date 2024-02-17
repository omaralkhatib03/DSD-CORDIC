`timescale 1 ns / 100 ps


module unpacker_tb();
  
    parameter WIDTH = 24;
  
    reg [31:0] data;

    wire sign, isSpecial; // special values are -1, 1
    wire [WIDTH+1:0] result;

    unpacker dut(data, result);

    initial begin
        $dumpfile("sim/unpacker.vcd");
        $dumpvars();
        
        
        data = 32'h3f800000; // 1
        #1
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);

        data = 32'hbf800000; // -1
        #1
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);
    
        data = 32'h33800000; // 2^-30, smallest value we can represent
        #1
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);

        data = 32'h0;  
        #1 
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);

        data = 32'h350637bd; // 5 * 10^-7, i.e minimum prec needed
        #1
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);
        
        data = 32'h3f000000; // 0.5
        #1
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);
         
        data = 32'h3f47ae14; // 0.78, out of range
        #1
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);
        
        data = 32'h3f1b74ee;
        #1
        $display("data:fl:%h,", data, "result:fi-24-s:%h", result);
        

        data = 32'hZ;
    end

endmodule
