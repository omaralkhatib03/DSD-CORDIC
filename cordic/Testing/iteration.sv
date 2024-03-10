module iteration #(
    parameter FRACS = 21,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS + 1  //sign bit needed for algorithm
)
(
    input [4:0] i,
    input [WIDTH-2:0] atan_i,
    input signed [WIDTH-1:0] x_i,
    input signed [WIDTH-1:0] y_i,
    input [WIDTH-1:0] z_i,
    output signed [WIDTH-1:0] x_n,
    output signed [WIDTH-1:0] y_n,
    output [WIDTH-1:0] z_n
);

wire di = z_i[WIDTH-1];
assign x_n = di ? x_i + (y_i >>> i) : x_i - (y_i >>> i);
assign y_n = di ? y_i - (x_i >>> i) : y_i + (x_i >>> i);
assign z_n = di ? z_i + {1'b0 ,atan_i} : z_i - {1'b0, atan_i};

endmodule