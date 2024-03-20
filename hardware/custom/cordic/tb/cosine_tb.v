`timescale 100ps / 100ps


module cosine_tb();
    

    reg [31:0] angle;
    wire [31:0] result;
    wire done;
  
    reg clk, clk_en, reset, start;

    initial
      clk = 1'b1;

    always 
      #1 clk = ~clk;

    cos dut(clk, clk_en, reset, start, angle, done, result);
     
    initial begin
        start = 1'b0;
        reset = 1'b1;
        clk_en = 1'b0;
        #2 
        reset = 1'b0;
        clk_en = 1'b1;

        $dumpfile("sim/cosine.vcd");
        $dumpvars();
        
        start = 1'b1; 
        angle = 32'h3f800000; // 1
        #2 
        start = 1'b0;
        #12
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        start = 1'b1; 
        angle = 32'hbf800000; // -1
        #2 
        start = 1'b0;
        #12
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        start = 1'b1; 
        angle = 32'h33800000; // 2^-30, smallest value we can represent
        #2 
        start = 1'b0;
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
        #12

        start = 1'b1; 
        angle = 32'h0;  
        #2 
        start = 1'b0;
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
        #12
       
        start = 1'b1; 
        angle = 32'h3f000000; // 0.5
        #2 
        start = 1'b0;
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
        #12

        $finish;

       angle = 32'hZ;
    end

endmodule




