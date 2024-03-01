`timescale 100ps / 100ps


module tb();
    

    reg [31:0] angle;
    wire [31:0] result;
  
    reg clk, clk_en, reset;

    initial
      clk = 1'b1;

    always 
      #1 clk = ~clk;

    cosine dut(clk, reset, clk_en, angle, result);
     
    initial begin
        reset = 1'b0;
        clk_en = 1'b1;

        $dumpfile("sim/cosine.vcd");
        $dumpvars();
        
        angle = 32'h3f800000; // 1
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);

        angle = 32'hbf800000; // -1
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);

        angle = 32'h33800000; // 2^-30, smallest value we can represent
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);

        angle = 32'h0;  
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);
       
        angle = 32'h3f000000; // 0.5
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);
        
        angle = 32'h3f1b74ee;
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);
        
        angle  = 32'h3f0a9594;
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);

        angle = 32'h437f0000;
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);
 
        angle = 32'h43000000;
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);
 
        angle = 32'h42c80000;
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);
        
        angle = 32'h43400000;
        #10
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);

        $finish;

       angle = 32'hZ;
    end

endmodule




