module float_to_fixed #(
    parameter SIGN_BITS = 1,
    parameter INT_BITS  = 1,
    parameter FRAC_BITS = 22,
    parameter WIDTH = SIGN_BITS + INT_BITS + FRAC_BITS
)(
    input  [31:0]      float,
    output [WIDTH-1:0] fixed
);

    wire        sign    ;
    wire [7:0]  exponent;
    wire [22:0] mantissa;

assign {sign, exponent, mantissa} = float;

assign fixed = (float == 0) ? 0 : {1'b0, {1'b1, mantissa} >> (128-exponent)};

endmodule


