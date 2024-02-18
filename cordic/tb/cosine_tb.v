`timescale 1 ns / 100 ps


module tb();
    
    reg clk, reset, clk_en;
    reg [31:0] angle;
    wire [31:0] result;
    
    initial
      clk = 1'b0;

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
        
        angle = 32'hbf800000; // -1
        #10
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h33800000; // 2^-30, smallest value we can represent
        #10
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h0;  
        #10
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
       
        angle = 32'h3f000000; // 0.5
        #10
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
        

        $finish;

       angle = 32'hZ;
    end

endmodule




