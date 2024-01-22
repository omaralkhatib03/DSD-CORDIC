module unpacker #(
    parameter FRACTIONAL_BITS = 29,
    parameter SIGNED = 1
)(
    input [31:0] data,
    output [31:0] result
);


    wire [7:0] e;
    wire [5:0] shift;
    wire [7:0] E = data[30:23];
    // wire [31:0] concated = {1'b1, data[22:0], {FRACTIONAL_BITS - 23{1'b0}}};
    wire [31:0] concated = {data[31], 1'b1, data[22:0], {FRACTIONAL_BITS - 22{1'b0}}};

    assign e = -E + 8'd127; 
    assign shift = E > (127 - FRACTIONAL_BITS) ? e[5:0] : FRACTIONAL_BITS;
    assign result = data == 0 ? 32'b0 : concated >> (shift);

endmodule


