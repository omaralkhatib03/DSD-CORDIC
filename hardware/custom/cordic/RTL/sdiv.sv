module sdiv#(
  parameter FRACTIONAL_BITS = 22
) (
  input [31:0] data,
  output [FRACTIONAL_BITS+1:0] angle
);
  

  `define max2(v1, v2) ((v1) > (v2) ? (v1) : (v2))
  localparam zeros = FRACTIONAL_BITS - 23;
  localparam fbitsMantissa = `max2((23-FRACTIONAL_BITS), 0);    



  wire [31:0] fullAngle = ((data + 32'hC0000000) >> 7);
  assign angle = {fullAngle[25:fbitsMantissa], {(zeros >= 0 ? zeros : 0){1'b0}}};

endmodule
