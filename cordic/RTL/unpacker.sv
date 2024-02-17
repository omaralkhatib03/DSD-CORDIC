module unpacker #(
    parameter FRACTIONAL_BITS = 24,
    parameter SIGNED = 0 // no need to be able to unpack negative values
)(
    input [31:0] data,
    output [25:0] result
);


    wire [7:0] e;
    wire [5:0] shift;
    wire [7:0] E = data[30:23];
    wire [25:0] concated = {SIGNED && data[31], 1'b1, data[22:0], {FRACTIONAL_BITS - 23{1'b0}}};
    
    // TODO: Implement GRS Rounding
    assign e = -E + 8'd127; 
    assign shift = E > (127 - FRACTIONAL_BITS) ? e[5:0] : FRACTIONAL_BITS;
    assign result = data == 0 ? 32'b0 : concated >> shift;

endmodule


