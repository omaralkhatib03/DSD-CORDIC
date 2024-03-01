`timescale 1 ns / 100 ps


module tb();
    
    parameter WIDTH = 24;

    reg [31:0] angle;
    wire [31:0] result;
    wire [WIDTH+1:0] theta;
    wire [WIDTH+1:0] x_s [31:0]; 
    wire [WIDTH+1:0] w_s [31:0]; 

    cosine dut(angle, result, theta, x_s, w_s);
    
    int i;
    int N;
    int _;
    initial begin
        $dumpfile("sim/cosine.vcd");
        // $dumpvars();
        
        _ = $fscanf('h8000_0000, "%d", N);

        for (i = 0; i < N; i = i + 1) begin 
          _ = $fscanf('h8000_0000, "%d", angle);
          #1
          $display("input:fl:%h,", angle, "cos-cordic:fl:%h,", result, "theta:fl:%h", angle);
        end
       // printIterations();
        
    end


  task printIterations;    
      int i;
      for (i = 0; i < 2; i = i + 1) begin
        $display("w_%0d",i,":fi-24-s:%h,", w_s[i], "x_%0d",i,":anc-24-s:%h", x_s[i]);
      end 
    endtask: printIterations
endmodule





