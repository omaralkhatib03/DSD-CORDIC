module unpacker #(
    parameter FRACTIONAL_BITS = 30
)(
    input [31:0] data,
    // output sign,
    output [31:0] result
    // output isSpecial
);

    wire [7:0] e;
    wire [5:0] shift;
    wire [7:0] E = data[30:23];
    wire [7:0] test = (127 - FRACTIONAL_BITS);


    assign e = -E + 8'd127; 
    assign shift = E > (127 - FRACTIONAL_BITS) ? e[5:0] : FRACTIONAL_BITS;
    assign result = data == 0 ? 32'b0 : {data[31], 1'b1, data[22:0], 7'b00} >> shift;

endmodule


