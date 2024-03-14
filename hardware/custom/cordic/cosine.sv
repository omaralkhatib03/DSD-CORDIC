module cosine #(
    parameter FRACS = 22,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS + 1  //sign bit needed for algorithm
)
(
    input clk,
    input reset,
    input clk_en,
    input start,
    output done,
    input [31:0] floatingPoint_theta,
    output [31:0] floatingPoint_result
);

wire [WIDTH-1:0] fixedPoint_result;
wire [WIDTH-2:0] fixedPoint_theta;


float_to_fixed float_to_fixed(
    .floatingPoint(floatingPoint_theta), 
    .fixedPoint(fixedPoint_theta)
);

fixed_to_float fixed_to_float(
    .ufixedPoint(fixedPoint_result[WIDTH-2:0]), 
    .floatingPoint(floatingPoint_result)
);

cordic cordic(
    .clk(clk),
    .reset(reset),
    .clk_en(clk_en),
    .done(done),
    .start(start),
    .fixedPoint_theta({1'b0, fixedPoint_theta}),
    .fixedPoint_result(fixedPoint_result)     
);


endmodule