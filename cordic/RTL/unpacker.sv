module unpacker #(
    parameter FRACTIONAL_BITS = 22,
    parameter SIGNED = 0
)(
    input [31:0] data,
    output [FRACTIONAL_BITS+1:0] result
);

    `define max2(v1, v2) ((v1) > (v2) ? (v1) : (v2))
    localparam zeros = FRACTIONAL_BITS - 23;
    localparam fbitsMantissa = `max2((23-FRACTIONAL_BITS), 0);
    
    wire [7:0] e;
    wire [5:0] shift;
    wire [7:0] E = data[30:23];
    wire [FRACTIONAL_BITS+1:0] concated = {SIGNED && data[31], 1'b1, data[22:fbitsMantissa], {zeros >= 0 ? zeros : 0{1'b0}}};
    
    // TODO: Implement GRS Rounding
    assign e = -E + 8'd127; 
    assign shift = E > (127 - FRACTIONAL_BITS) ? e[5:0] : FRACTIONAL_BITS;
    assign result = data == 0 ? {FRACTIONAL_BITS+2{1'b0}} : concated >> shift;

endmodule


