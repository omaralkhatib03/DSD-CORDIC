
//input drops sign bit (unsigned fixed)
module fixed_to_float #(
    parameter FRACS = 22,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS //sign not needed output range between 0.5403 to 1
)(
    input [WIDTH-1:0] ufixedPoint,
    output [31:0] floatingPoint
);

localparam padding = (24 - FRACS < 0) ? 0 : 24 - FRACS;
//extract sign, integer bit has exponent 127, >0.5 has exponent 126 , 
assign floatingPoint = {1'b0, ufixedPoint[WIDTH-1] ? 8'd127 : 8'd126 , 
//mantissa is the rest of the bits , padding needed to make it 23 bits, implied one in floating consider range of 0.5403 to 1
ufixedPoint[WIDTH-1] ? 23'h0 : {ufixedPoint[WIDTH-3:0], {padding{1'b0}}}}; 

endmodule
