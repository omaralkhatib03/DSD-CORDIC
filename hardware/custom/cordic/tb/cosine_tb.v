`timescale 100ps / 100ps


module tb();
    

    reg [31:0] angle;
    wire [31:0] result;
  
    reg clk, clk_en, reset;

    initial
      clk = 1'b1;

    always 
      #1 clk = ~clk;

    cos dut(clk, reset, clk_en, angle, result);
     
    initial begin
        reset = 1'b0;
        clk_en = 1'b1;

        $dumpfile("sim/cosine.vcd");
        $dumpvars();
        
        
        angle = 32'h3f800000; // 1
        #10
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




