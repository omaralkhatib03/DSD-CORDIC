`timescale 1 ns / 100 ps


module tb();

    reg [31:0] angle;
    wire [31:0] result;
    wire [31:0] theta;
    wire [31:0] x_s [31:0]; 
    wire [31:0] w_s [31:0]; 
    reg status;

    cosine dut(angle, result, theta, x_s, w_s);
    
    int i;
    int seed = 123;
    int N;
    int _;
    initial begin
        $dumpfile("sim/cosine.vcd");
        // $dumpvars();
        
        _ = $fscanf('h8000_0000, "%d", N);

        for (i = 0; i < N; i = i + 1) begin 
          _ = $fscanf('h8000_0000, "%d", angle);
          #1
          $display("input:fl:%h,", angle, "cos-cordic:anc-30-s:%h,", result, "theta:fi-30-s:%h", theta);
        end
       // printIterations();
        
    end


    task printIterations;    
      int i;
      for (i = 0; i < 2; i = i + 1) begin
        $display("w_%0d",i,":fi-30-s:%h,", w_s[i], "x_%0d",i,":anc-30-s:%h", x_s[i]);
      end 
    endtask: printIterations

    // function real randomAngle(int seed);
    //   real r;
    //   r = ($urandom) >> 9;
    //   return r;
    // endfunction : randomAngle

    // function bit [31:0] to_ieee754_float(input real value);
    //     bit [31:0] ieee754_float;
    //     bit [31:0] mantissa;
    //     bit [7:0] exponent;
    //     real normalized_value;
    //     int signed biased_exponent;
    //     
    //     // Special cases handling
    //     if (value == 0.0) begin
    //         ieee754_float = 32'h00000000; // Positive zero
    //     end else if ($isinf(value)) begin
    //         ieee754_float = value > 0.0 ? 32'h7F800000 : 32'hFF800000; // Positive or negative infinity
    //     end else if ($isnan(value)) begin
    //         ieee754_float = 32'h7FC00000; // NaN (Not a Number)
    //     end else begin
    //         // Extract the sign bit
    //         ieee754_float[31] = value < 0 ? 1'b1 : 1'b0;
    //         
    //         // Take the absolute value for further processing
    //         normalized_value = $abs(value);
    //         
    //         // Find the exponent and mantissa
    //         biased_exponent = $clog2(normalized_value);
    //         exponent = 127 + biased_exponent;
    //         mantissa = {23{0}}; // Initialize mantissa with leading zeros
    //         
    //         // Compute the normalized mantissa
    //         if (biased_exponent > 0) begin
    //             mantissa = (normalized_value / (2 ** biased_exponent)) * 2 ** 23;
    //         end
    //         
    //         // Construct the IEEE 754 float representation
    //         ieee754_float[30:23] = exponent;
    //         ieee754_float[22:0] = mantissa[22:0];
    //     end
    //     
    //     return ieee754_float;
    // endfunction

endmodule





