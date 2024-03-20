module cordic #(
    parameter SIGN_BITS = 1,
    parameter INT_BITS  = 1,
    parameter FRAC_BITS = 22,
    parameter WIDTH     = SIGN_BITS + INT_BITS + FRAC_BITS 
)(
    input         [4:0]       i,
    input         [WIDTH-1:0] a_i,
    input  signed [WIDTH-1:0] x_in,
    input  signed [WIDTH-1:0] y_in,
    input  signed [WIDTH-1:0] theta_in,
    output signed [WIDTH-1:0] x_out,
    output signed [WIDTH-1:0] y_out,
    output        [WIDTH-1:0] theta_out
);


assign x_out     = theta_in[WIDTH-1] ? x_in + (y_in >>> i) : x_in - (y_in >>> i);
assign y_out     = theta_in[WIDTH-1] ? y_in - (x_in >>> i) : y_in + (x_in >>> i);
assign theta_out = theta_in[WIDTH-1] ? theta_in + a_i : theta_in - a_i;

endmodule
