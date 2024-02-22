module packer #(
  parameter WIDTH = 23
)(
  input [WIDTH+1:0] result,
  output [31:0] floatResult
);

  // `define max2(v1, v2) ((v1) > (v2) ? (v1) : (v2))
  // localparam zeros = `max2(0, 24-WIDTH);

  localparam extension = (0 > 24-WIDTH) ? 0 : 24-WIDTH;

  assign floatResult = {result[WIDTH+1], result[WIDTH] ? 8'd127 : 8'd126, result[WIDTH] ? 23'h0 : {result[WIDTH-2:0], {extension{1'b0}}}};
  
endmodule
