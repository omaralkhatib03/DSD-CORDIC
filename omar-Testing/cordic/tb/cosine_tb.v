`timescale 1 ns / 100 ps


module tb();
    
    parameter width = 24;

    reg [31:0] angle;
    wire [31:0] result;
    wire [width+1:0] theta;
    wire [width+1:0] x_s [31:0]; 
    wire [width+1:0] w_s [31:0]; 

    cosine dut(angle, result, theta, x_s, w_s);
    
    initial begin
        $dumpfile("sim/cosine.vcd");
        $dumpvars();
        
        
        angle = 32'h3f800000; // 1
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fi-24-s:%h", theta);
        // printIterations();

        angle = 32'hbf800000; // -1
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fi-24-s:%h", theta);
        // printIterations();

        angle = 32'h33800000; // 2^-30, smallest value we can represent
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fi-24-s:%h", theta);
        // printIterations();

        angle = 32'h0;  
        #1 
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fi-24-s:%h", theta);
        // printIterations();
       
        angle = 32'h3f000000; // 0.5
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fi-24-s:%h", theta);
        // printIterations();
       
        angle = 32'h3fe00000; // 1.75, should not be possible, expecting aprrox 1.74
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fi-24-s:%h", theta);
        // printIterations();

        angle = 32'hZ;
    end


    task printIterations;    
      int i;
      for (i = 0; i < 0; i = i + 1) begin
        $display("w_%0d",i,":fi-24-s:%h,", w_s[i], "x_%0d",i,":anc-24-s:%h", x_s[i]);
      end 
    endtask: printIterations

endmodule




