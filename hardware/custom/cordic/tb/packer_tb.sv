`timescale 1 ns / 100 ps


module tb() ;
    
    // parameter WIDTH = 22;

    reg [31:0] data; 
    wire [22+1:0] fixed;
    wire [31:0] result;

    float_to_fixed upckr(data, fixed);
    fixed_to_float dut(fixed, result);

    initial begin
        $dumpfile("sim/unpacker.vcd");
        $dumpvars();
        
        
        data = 32'h3f800000; // 1
        #1
        $display("data:fl:%h,", data, "result:fl:%h", result);

        
        data = 32'hbf800000; // -1
        #1
        $display("data:fl:%h,", data, "result:fl:%h", result);
   

        data = 32'h3f000000; // 0.5
        #1 
        $display("data:fl:%h,", data, "result:fl:%h", result);


        data = 32'h3f47ae14;  
        #1 
        $display("data:fl:%h,", data, "result:fl:%h", result);

        data = 32'h3f0a9594;
        #1 
        $display("data:fl:%h,", data, "result:fl:%h", result);

        data = 32'hZ;
    end

endmodule


        // data = 32'h350637bd; // 5 * 10^-7, i.e minimum prec needed
        // #1
        // $display("data:fl:%h,", data, "result:fi-30-s:%h", result);
        // 
        // data = 32'h3f000000; // 0.5
        // #1
        // $display("data:fl:%h,", data, "result:fi-30-s:%h", result);
        //  
        // data = 32'h3f47ae14; // 0.78, out of range
        // #1
        // $display("data:fl:%h,", data, "result:fi-30-s:%h", result);
        // 
        // data = 32'h3f1b74ee; // 0.78, out of range
        // #1
        // $display("data:fl:%h,", data, "result:fi-30-s:%h", result);
        

