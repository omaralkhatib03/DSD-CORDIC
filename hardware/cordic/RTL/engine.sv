module engine #(
  parameter WIDTH = 24
)(
    input [4:0] i,
    input [WIDTH+1:0] a_i, 
    input signed [WIDTH+1:0] x_i,
    input signed [WIDTH+1:0] y_i, 
    input [WIDTH+1:0] w_i,
    input [WIDTH+1:0] theta,
    output signed [WIDTH+1:0] x_n,
    output signed [WIDTH+1:0] y_n, 
    output [WIDTH+1:0] w_n
);
    wire sign_w = w_i[25] ? (w_i >= theta) : (w_i <= theta); // high is w_i is negative
     
    assign x_n = sign_w ? x_i - (y_i >>> i) : x_i + (y_i >>> i);
    assign y_n = sign_w ? y_i + (x_i >>> i) : y_i - (x_i >>> i);
    assign w_n = sign_w ? w_i + a_i : w_i - a_i; 

endmodule
