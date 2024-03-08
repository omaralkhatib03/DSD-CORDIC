// module cordic #(
//     parameter INTS = 1,
//     parameter FRACS = 21,
//     parameter ITER = 16,
//     parameter WIDTH = INTS + FRACS + 1 //sign bit
// )
// (
//     input [31:0] angle,
//     output [31:0] result,
//     output [WIDTH:0] theta,
//     output [WIDTH+2:0] x_s_out [31:0],
//     output [WIDTH+2:0] w_s_out [31:0]
// );


// endmodule

module float_to_fixed #(
    parameter FRACS = 21,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS + 1 //sign bit
)
(
    input [31:0] floatingPoint,
    output [WIDTH:0] fixedPoint
);

logic [7:0] RawExponent = floatingPoint[30:23];
logic [7:0] Exponent = -RawExponent + 8'd127;
logic [22:0] Mantissa = {1'b1 , floatingPoint[22:0]};

assign fixedPoint = (floatingPoint == 32'b0) ? 32'b0 : Mantissa >> Exponent;

endmodule

