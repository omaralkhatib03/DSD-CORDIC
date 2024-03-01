module unpacker #(
    parameter FRACTIONAL_BITS = 23,
    parameter INTEGER_BITS = 9,
    parameter SIGNED = 1 // All input values are > 0. x in [0, 255]
)(
    input [31:0] data,
    output [INTEGER_BITS+FRACTIONAL_BITS-1:0] result
);

    `define max2(v1, v2) ((v1) > (v2) ? (v1) : (v2))
    localparam zeros = FRACTIONAL_BITS - 23;
    localparam fbitsMantissa = `max2((23-FRACTIONAL_BITS), 0);    

    wire signed [7:0] e;
    wire signed [7:0] shift;
    wire unsigned [7:0] right_shift;
    wire [7:0] E = data[30:23];
    wire [INTEGER_BITS+FRACTIONAL_BITS-1:0] concated;
    wire [INTEGER_BITS+FRACTIONAL_BITS-1:0] shifted_value;
    
    // TODO: Implement GRS Rounding
    assign e = -E + 8'd127; 
    assign shift = E > (127 - FRACTIONAL_BITS) ? e : FRACTIONAL_BITS[7:0] + 1'b1;

    assign concated = {{(INTEGER_BITS-2 + fbitsMantissa){1'b0}}, SIGNED && data[31], 1'b1, data[22:fbitsMantissa], {(zeros >= 0 ? zeros : 0){1'b0}}}; 
    assign right_shift = -shift; 

    // quartus complains here saying 'changing signed shift to unsigned', but it synthesizes correctly so its fine
    assign shifted_value = shift < 0 ? concated << right_shift : concated >> shift; 
    assign result = data == 0 ? {INTEGER_BITS+FRACTIONAL_BITS{1'b0}} : shifted_value;

endmodule


