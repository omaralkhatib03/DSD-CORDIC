module unpacker (
    input [31:0] data,
    output sign,
    output [31:0] result,
    output isSpecial
);

    wire [7:0] e;
    wire [5:0] shift;
    wire [7:0] E = data[30:23];

    // subtractor here, not the main bottleneck of the algorithm
    // do we need it ? can we avoid it maybe ?
    assign e = -E + 8'd127; 
    assign shift = E > 8'd95 ? e[5:0] : 6'd32; 
    assign isSpecial = E == 8'd127 && data != 0;
    assign sign = data[31];
    assign result = data == 0 ? 32'b0 : {1'b1, data[22:0], 8'b00} >> (shift - 1);

endmodule


