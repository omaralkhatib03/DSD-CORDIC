`timescale 1 ns / 100 ps


module tb;

    reg [31:0] angle;
    wire [31:0] result;
    
    cosine dut(angle, result);
    
    initial begin
        $dumpfile("sim/cosine.vcd");
        $dumpvars();
        
        
        angle = 32'h3f800000; // 1
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'hbf800000; // -1
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h33800000; // 2^-30, smallest value we can represent
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);

        angle = 32'h0;  
        #1 
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
       
        angle = 32'h3f000000; // 0.5
        #1
        $display("input:fl:%h,", angle, "cos-cordic:fl:%h", result);
       
       angle = 32'hZ;
    end

endmodule




