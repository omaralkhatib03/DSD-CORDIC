module unpacker (
    input [31:0] data,
    output sign,
    output [7:0] e,
    output [22:0] m,
    output isNaN,
    output isInf,
    output isZero,
    output isSubn
);

    localparam ALL_ONES = 8'hFF, ALL_ZEROS = 8'h00;

    wire exp_FF = e == ALL_ONES;
    wire exp_Z = e == ALL_ZEROS;

    // useful boolean to unpack float  
    wire sig_z = data[22:0] == 30'd0; 
    assign sign = data[31];
    assign e = data[30-:8];
    assign m = data[22:0];

    assign isNaN = exp_FF && ~ sig_z; // is NaN
    assign isInf = exp_FF && sig_z; // is Inf
    assign isZero = exp_Z && sig_z; // is Zero
    assign isSubn = exp_Z && ~ sig_z; // is sub normal range

endmodule
