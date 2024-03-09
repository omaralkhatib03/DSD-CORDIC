module cosine #(
    parameter FRACS = 21,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS + 1  //sign bit needed for algorithm
)
(
    input clk,
    input reset,
    input clk_en,
    input [31:0] floatingPoint_theta,
    output [31:0] floatingPoint_result
);

float_to_fixed float_to_fixed(
    .floatingPoint(floatingPoint_theta), 
    .fixedPoint(fixedPoint_theta)
);

fixed_to_float fixed_to_float(
    .ufixedPoint(ufixedPoint_result), 
    .floatingPoint(floatingPoint_result)
);

cordic cordic(
    .fixedPoint_theta(signed_theta), 
    .fixedPoint_result(fixedPoint_result)
    .clk(clk),
    .reset(reset),
    .clk_en(clk_en)
);

wire [WIDTH-1:0] signed_theta {1'b0, fixedPoint_theta}; //concatenate sign bit needed for algorithm
    
endmodule