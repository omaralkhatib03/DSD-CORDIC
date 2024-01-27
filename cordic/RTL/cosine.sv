module cosine (
    input [31:0] angle,
    output [31:0] result,
    output [31:0] theta,
    output [31:0] x_s_out [32:1],
    output [31:0] w_s_out [32:1]
);

// unpacker: converts from floating point to fixed point
wire [31:0] fixedFractionalAngle;
unpacker upckr(angle, fixedFractionalAngle);

// rom
reg [31:0] angles [0:31];

initial begin // with angles
    $readmemh("mem.hex", angles); 
end

wire [31:0] x_s [32:1];
wire [31:0] y_s [32:1];
wire [31:0] w_s [32:1];

// 26dd38b0 30-u
// 4dba7700 31-u
// 26dd3b80
engine en0(5'b0, angles[0], 32'h26dd3b80, 32'h0, 32'h0, fixedFractionalAngle, x_s[1], y_s[1], w_s[1]);

genvar i;

generate
    for (i = 5'd2; i < 6'd32; i = i + 1) begin : gen_cordic_engines
        wire[4:0] iter = i;
        engine en(iter-1'b1, angles[i-1], x_s[i-1], y_s[i-1], w_s[i-1], fixedFractionalAngle, x_s[i], y_s[i], w_s[i]);
    end
    
endgenerate
  
assign result = x_s[31];
assign theta = w_s[31];
assign x_s_out = x_s;
assign w_s_out = w_s;



// make packer




endmodule
