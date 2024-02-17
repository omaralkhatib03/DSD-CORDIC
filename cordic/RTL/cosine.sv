module cosine #(
  parameter WIDTH = 24
)(
    input [31:0] angle,
    output [31:0] result
);

wire [WIDTH+1:0] fixedFractionalAngle;
unpacker upckr(angle, fixedFractionalAngle);

reg [WIDTH+1:0] angles [0:31];

initial begin 
  angles[0] = 26'hc90fdb;
  angles[1] = 26'h76b19c;
  angles[2] = 26'h3eb6ec;
  angles[3] = 26'h1fd5ba;
  angles[4] = 26'hffaad;
  angles[5] = 26'h7ff55;
  angles[6] = 26'h3ffea;
  angles[7] = 26'h1fffd;
  angles[8] = 26'hffff;
  angles[9] = 26'h7fff;
  angles[10] = 26'h3fff;
  angles[11] = 26'h1fff;
  angles[12] = 26'h1000;
  angles[13] = 26'h7ff;
  angles[14] = 26'h3ff;
  angles[15] = 26'h200;
  angles[16] = 26'h100;
  angles[17] = 26'h7f;
  angles[18] = 26'h40;
  angles[19] = 26'h1f;
  angles[20] = 26'h10;
  angles[21] = 26'h8;
  angles[22] = 26'h3;
  angles[23] = 26'h1;
  angles[24] = 26'h1;
  angles[25] = 26'h1;
  angles[26] = 26'h1;
  angles[27] = 26'h1;
  angles[28] = 26'h1;
  angles[29] = 26'h1;
  angles[30] = 26'h1;
  angles[31] = 26'h0;
end

  wire [WIDTH+1:0] x_s [0:31];
  wire [WIDTH+1:0] y_s [0:31];
  wire [WIDTH+1:0] w_s [0:31];

engine en0(5'b0, angles[0], 26'h9b74ee, 26'h0, 26'h0, fixedFractionalAngle, x_s[0], y_s[0], w_s[0]);

genvar i;

generate
    for (i = 5'd1; i < 6'd19; i = i + 1) begin : gen_cordic_engines
        wire[4:0] iter = i;
        engine en(iter, angles[i], x_s[i-1], y_s[i-1], w_s[i-1], fixedFractionalAngle, x_s[i], y_s[i], w_s[i]);
    end
endgenerate

packer pckr(x_s[18], result);

endmodule
