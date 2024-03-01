`timescale 100ps / 100ps


module tb();
    
    parameter WIDTH = 22;

    reg [31:0] angle;
    wire [31:0] result;
    wire [WIDTH+1:0] theta;
    wire [WIDTH+1:0] x_s [31:0]; 
    wire [WIDTH+1:0] w_s [31:0]; 

    cosine dut(angle, result, theta, x_s, w_s);
     
    initial begin
        $dumpfile("sim/cosine.vcd");
        $dumpvars();
        
        angle = 32'h3f800000; // 1
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);

        // angle = 32'hbf800000; // -1 Illegal test case, input range [0, 255]
        // #1
        // $display("x:fl:%h,", angle, "angle:x:%h,", angle, "result:fl:%h", result);

        angle = 32'h33800000; // 2^-30, smallest value we can represent
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h0;  
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);
       
        angle = 32'h3f000000; // 0.5
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);
        
        angle = 32'h3f1b74ee;
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);
        
        angle  = 32'h3f0a9594;
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h437f0000;
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);
 
        angle = 32'h43000000;
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);
 
        angle = 32'h42c80000;
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);
        
        angle = 32'h43400000;
        #1
        $display("x:fl:%h,", angle, "angle:x:%h,", angle, "cos-cordic:fl:%h", result);

        $finish;

       angle = 32'hZ;
    end


    task printIterations;    
      int i;
      for (i = 0; i < 10; i = i + 1) begin
        $display("w_%0d",i,":fi-23-s:%h,", w_s[i], "x_%0d",i,":anc-23-s:%h", x_s[i]);
      end 
    endtask: printIterations


endmodule




