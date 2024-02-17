`timescale 1 ns / 100 ps


module packer_tb();
    
    parameter width = 24;

    reg [width+1:0] data; 

    wire [31:0] result;

    packer dut(data, result);

    initial begin
        $dumpfile("sim/unpacker.vcd");
        $dumpvars();
        
        
        data = 26'h1000000; // 1
        #1
        $display("data:fi-24-s:%h,", data, "result:fl:%h", result);

        data = 32'h3000000; // -1
        #1
        $display("data:fi-24-s:%h,", data, "result:fl:%h", result);
   
        data = 32'h0800000;  
        #1 
        $display("data:fi-24-s:%h,", data, "result:fl:%h", result);


        data = 32'h0c0f909;  
        #1 
        $display("data:fi-24-s:%h,", data, "result:fl:%h", result);


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
        

