
module int_mult (
  input [31:0] dataa,
  input [31:0] datab,
  output [31:0] result
);
 
  assign result = datab * dataa;

endmodule
