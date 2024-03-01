module cosine #(
parameter WIDTH = 22,
parameter LIMIT = 24'h26dd3b,
parameter ITERATIONS = 25

)(
    input [31:0] angle,
    output [31:0] result,
    output [WIDTH+1:0] theta,
    output [WIDTH+1:0] x_s_out [31:0],
    output [WIDTH+1:0] w_s_out [31:0]
);

// unpacker: converts from floating point to fixed point
wire [WIDTH+1:0] fixedFractionalAngle;
wire [31:0] interm;
unpacker upckr(angle, interm);
sdiv #(.FRACTIONAL_BITS(WIDTH)) subdiv128(interm, fixedFractionalAngle);

// rom
reg [WIDTH+1:0] angles [0:31];

initial begin // with angles
    $readmemh("mem.hex", angles); 
end

    wire [WIDTH+1:0] x_s [0:31];
    wire [WIDTH+1:0] y_s [0:31];
    wire [WIDTH+1:0] w_s [0:31];

engine #(.WIDTH(WIDTH)) en0(5'b0, angles[0], LIMIT, {WIDTH+2{1'h0}}, fixedFractionalAngle, x_s[0], y_s[0], w_s[0]);

genvar i;

generate
    for (i = 32'd1; i < ITERATIONS; i = i + 1) begin : gen_cordic_engines
        wire[4:0] iter = i[4:0];
        engine #(.WIDTH(WIDTH)) en(iter, angles[i], x_s[i-1], y_s[i-1], w_s[i-1], x_s[i], y_s[i], w_s[i]);
    end
endgenerate


packer #(.WIDTH(WIDTH)) pckr(x_s[ITERATIONS-1], result);

assign theta = fixedFractionalAngle;
assign x_s_out = x_s;
assign w_s_out = w_s;


endmodule
