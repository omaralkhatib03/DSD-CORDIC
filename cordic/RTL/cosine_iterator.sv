module cosine_iterator #(
  parameter WIDTH = 24
)
(
    input [31:0] angle,
    output [31:0] result,
    output [WIDTH+1:0] theta,
    output [WIDTH+1:0] x_s_out [31:0],
    output [WIDTH+1:0] w_s_out [31:0]
);

wire [WIDTH+1:0] fixedFractionalAngle;
unpacker upckr(angle, fixedFractionalAngle);

localparam [(WIDTH+2)*32-1:0] angles = {26'h0, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h3, 26'h8, 26'h10, 26'h1f, 26'h40, 26'h7f, 26'h100, 26'h200, 26'h3ff, 26'h7ff, 26'h1000, 26'h1fff, 26'h3fff, 26'h7fff, 26'hffff, 26'h1fffd, 26'h3ffea, 26'h7ff55, 26'hffaad, 26'h1fd5ba, 26'h3eb6ec, 26'h76b19c,26'hc90fdb};


wire [WIDTH+1:0] x_s [0:31];
wire [WIDTH+1:0] y_s [0:31];
wire [WIDTH+1:0] w_s [0:31];

engine en0(5'b0, angles[0+:26], 26'h9b74ee, 26'h0, 26'h0, fixedFractionalAngle, x_s[0], y_s[0], w_s[0]);

genvar i;

generate
    for (i = 'd1; i < 6'd24; i = i + 1) begin : gen_cordic_engines
        wire[4:0] iter = i;
        engine en(iter, angles[(i*26)+:26], x_s[i-1], y_s[i-1], w_s[i-1], fixedFractionalAngle, x_s[i], y_s[i], w_s[i]);
    end
endgenerate

packer pckr(x_s[23], result);

assign theta = w_s[23];
assign x_s_out = x_s;
assign w_s_out = w_s;


endmodule
