module float_to_fixed #(
    parameter FRACS = 20,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS  //sign bit not needed cos is even function
)
(
    input [31:0] floatingPoint,
    output [WIDTH-1:0] fixedPoint
);

wire [7:0] RawExponent = floatingPoint[30:23];
wire [7:0] Exponent = -RawExponent + 8'd127;
wire [WIDTH-1:0] Mantissa = {1'b1 , floatingPoint[22:24-WIDTH]};

assign fixedPoint = (floatingPoint == 32'b0) ? {WIDTH{1'b0}} : Mantissa >> Exponent;

endmodule

