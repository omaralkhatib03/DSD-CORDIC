module fixed_to_float #(
    parameter SIGN_BITS = 1,
    parameter INT_BITS  = 1,
    parameter FRAC_BITS = 22,
    parameter WIDTH     = SIGN_BITS + INT_BITS + FRAC_BITS
)(
  input  [WIDTH-1:0] fixed,
  output [31:0]      float
);

assign float = {1'b0, 7'd63, fixed[WIDTH-2], fixed[FRAC_BITS-2:0], 2'b00};
 
endmodule
