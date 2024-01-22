`timescale 1 ns / 100 ps


module tb();

    reg [31:0] theta;
    wire [31:0] result;

    cosine dut(theta, result);

    initial begin
        $dumpfile("sim/cosine.vcd");
        $dumpvars();
        
        
        theta = 32'h3f800000; // 1
        #1
        $display("theta:fl:%h,", theta, "cos-cordic:anc-29-u:%h", result);

        theta = 32'hbf800000; // -1
        #1
        $display("theta:fl:%h,", theta, "cos-cordic:anc-30-u:%h", result);

        theta = 32'h30800000; // 2^-30, smallest value we can represent
        #1
        $display("theta:fl:%h,", theta, "cos-cordic:anc-30-u:%h", result);

        theta = 32'h0;  
        #1 
        $display("theta:fl:%h,", theta, "cos-cordic:anc-30-u:%h", result);
       
        theta = 32'h3f000000; // 0.5
        #1
        $display("theta:fl:%h,", theta, "cos-cordic:anc-30-u:%h", result);

        theta = 32'hZ;
    end

endmodule
