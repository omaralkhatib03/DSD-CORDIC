`timescale 1 ns / 100 ps


module tb() ;
  
    parameter WIDTH = 22;
  
    reg [31:0] data;

    wire [31:0] interm;
    wire [WIDTH+1:0] result;

    unpacker dut(data, interm);
    sdiv dut2(interm, result);
  

    initial begin
        $dumpfile("sim/unpacker.vcd");
        $dumpvars();
        
        
        data = 32'h3f800000; // 1
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);

        // data = 32'hbf800000; // -1  Illegal test case, input range [0, 255]
        // #1
        // $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
    
        data = 32'h33800000; // 2^-30, smallest value we can represent
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);

        data = 32'h0;  
        #1 
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);

        data = 32'h350637bd; // 5 * 10^-7, i.e minimum prec needed
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
        
        data = 32'h3f000000; // 0.5
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
         
        data = 32'h3f47ae14; // 0.78, out of range
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
        
        data = 32'h3f1b74ee;
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
        
        data = 32'h3f0a9594;
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);

        data = 32'h437f0000;
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
 
        data = 32'h43000000;
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
 
        data = 32'h42c80000;
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);
        
        data = 32'h43400000;
        #1
        $display("x:fl:%h,", data, "data:x:%h,", data, "result:fi-22-s:%h", result);



        data = 32'hZ;
    end

endmodule
