module cosine #(
  parameter WIDTH = 24
)
(
    input [31:0] angle,
    output [31:0] result,
    output [WIDTH+1:0] theta,
    output [WIDTH+1:0] x_s_out [31:0],
    output [WIDTH+1:0] w_s_out [31:0]
);

// unpacker: converts from floating point to fixed point
wire [WIDTH+1:0] fixedFractionalAngle;
unpacker upckr(angle, fixedFractionalAngle);

// rom
reg [WIDTH+1:0] angles [0:31];

initial begin // with angles
    $readmemh("mem.hex", angles); 
end

    wire [WIDTH+1:0] x_s [0:31];
    wire [WIDTH+1:0] y_s [0:31];
    wire [WIDTH+1:0] w_s [0:31];

engine en0(5'b0, angles[0], 26'h9b74ee, 26'h0, fixedFractionalAngle, x_s[0], y_s[0], w_s[0]);

genvar i;

generate
    for (i = 32'd1; i < 6'd19; i = i + 1) begin : gen_cordic_engines
        wire[4:0] iter = i[4:0];
        engine en(iter, angles[i], x_s[i-1], y_s[i-1], w_s[i-1], x_s[i], y_s[i], w_s[i]);
    end
    
endgenerate



packer pckr(x_s[18], result);

assign theta = w_s[18]; // cant use packer for this
assign x_s_out = x_s;
assign w_s_out = w_s;


endmodule
