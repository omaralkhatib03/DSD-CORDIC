`timescale 1 ns / 100 ps


module tb();
    
    parameter WIDTH = 22;

    reg [31:0] angle;
    wire [31:0] result;
    reg clk, clk_en, reset;

    cosine dut(clk, reset, clk_en, angle, result);
    
    int i;
    int N;
    int _;

    initial
      clk = 1'b1;

    always 
      #1 clk = ~clk;


    initial begin
        reset = 1'b0;
        clk_en = 1'b1;

        $dumpfile("sim/cosine.vcd");
        // $dumpvars();
        
        _ = $fscanf('h8000_0000, "%d", N);

        for (i = 0; i < N; i = i + 1) begin 
          _ = $fscanf('h8000_0000, "%d", angle);
          #10
          $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fl:%h", angle);
        end

        $finish(0);

    end


endmodule





