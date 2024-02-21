module packer #(
  parameter WIDTH = 24
)(
  input [WIDTH+1:0] result,
  output [31:0] floatResult
);

  assign floatResult = {result[WIDTH+1], result[WIDTH] ? 8'd127 : 8'd126, result[WIDTH] ? 23'h0 : result[WIDTH-2:0], {WIDTH-24{1'b0}}};
  
endmodule
