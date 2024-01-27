module engine (
    input [4:0] i,
    input [31:0] a_i, 
    input signed [31:0] x_i,
    input signed [31:0] y_i, 
    input [31:0] w_i,
    input [31:0] theta,
    output signed [31:0] x_n,
    output signed [31:0] y_n, 
    output [31:0] w_n
);
    // w_i[31] ? (w_i >= theta) :
    wire sign_w = (w_i <= theta); // high is w_i is negative

    assign x_n = sign_w ? x_i - (y_i >>> i) : x_i + (y_i >>> i);
    assign y_n = sign_w ? y_i + (x_i >>> i) : y_i - (x_i >>> i);
    assign w_n = sign_w ? w_i + a_i : w_i - a_i; 

endmodule
