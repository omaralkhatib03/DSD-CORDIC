`timescale 100ps / 100ps


module tb();
    
    parameter WIDTH = 24;

    reg [31:0] angle;
    wire [31:0] result;
    wire [WIDTH+1:0] theta;
    wire [WIDTH+1:0] x_s [31:0]; 
    wire [WIDTH+1:0] w_s [31:0]; 

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
        #8
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
        $finish(0);

        angle = 32'hbf800000; // -1
        
        #8
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h33800000; // 2^-30, smallest value we can represent
        #8
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h0;  
        #8
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
       
        angle = 32'h3f000000; // 0.5
        #8
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
        

        $finish;

       angle = 32'hZ;
    end

endmodule




