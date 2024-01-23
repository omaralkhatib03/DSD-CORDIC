module cosine (
    input [31:0] angle, 
    output [31:0] result
);

// unpacker: converts from floating point to fixed point
wire [31:0] fixedFractionalAngle;
unpacker upckr(angle, fixedFractionalAngle);

// rom
reg [31:0] angles [0:31];

initial begin // with angles
    $readmemh("mem.hex", angles); 
end

wire [31:0] x_s [31:0];
wire [31:0] y_s [31:0];
wire [31:0] w_s [31:0];

// 26dd38b0 30-s
// 4dba7700 31-u

engine en0(5'b0, angles[0], 32'h4dba7700, 32'h0, 32'h0, fixedFractionalAngle, x_s[0], y_s[0], w_s[0]);

genvar i;

generate
    for (i = 5'd1; i < 6'd32; i = i + 1) begin : gen_cordic_engines
        wire[4:0] iter = i;
        engine en(iter, angles[i], x_s[i-1], y_s[i-1], w_s[i-1], fixedFractionalAngle, x_s[i], y_s[i], w_s[i]); 
    end
endgenerate


assign result = x_s[31];
// assign sin = y_s[31];
// assign w = w_s[31];

//! everything below is **Pure Waffle**

/*
    angle belongs to [-128, 127] i.e [-1, 1) radians
    result belongs to [0.54030230586, 1] 
    This to be as percise as possible we can place the decimal point on the 
    absolute left of the number. Since the input range is from -128 to 127 then we will never represent
    the number -1.

    Hence special cases for packer: 
    if angle == 0; result = 1 fi
    if angleIsNegative; result = - result fi

    By setting the point at the utmost left, our ULP = 2^-32. That is the difference between two
    consecutive floating point numbers.

    As for the input, if its in floating point format it needs to be interperted as fixed point. 
    We have to shift is up of down based on the number of fractionl bits we need.

    The whole number range is the 8 bit signed value. Thus if we want to maximize the accuracy.
    We convert it to a fixed point format we proceed as follows:

    s       E          m
    s      int        frac

    Thus // does our cordic needs to deal with subnormal values ?
    fixed_n = (1.m) * 2^(E-127) = (1.m) << (E-127)

    We feed this value into the cordic circuit.
*/

// pack back into floating point representation
// packer

endmodule
