`timescale 100ps / 100ps

//Avalon
module top (
  input clk,
  input reset_n,
  input read,
  input write, 
  input [31:0] writedata,
  input  address,
  output [31:0] readdata
);



localparam cycles = 6;

reg [31:0] writereg; // address 0 
reg [31:0] readreg; // address 1

// ---------------------------------------------------  //
// ---------------     Write Logic    ----------------  //
// ---------------------------------------------------  //

// CLK Enables
reg [cycles:0] clk_enables;
integer i;
always @(posedge clk) begin 
  if (~reset_n) begin
    clk_enables <= {cycles+1{1'b0}};
  end else begin
    for (i = 0; i < cycles; i = i + 1) begin
      clk_enables[i+1] <= clk_enables[i];
    end
  end
  clk_enables[0] <= write && address == 0; // we only need to update sum if a new input is written
end

wire [31:0] result;

term trm (
  .clk(clk),
  .clk_en(|clk_enables),
  .reset(~reset_n),
  .x(writereg),
  .result(result)
);

// readreg : Write 
always @(posedge clk) begin
  if (~reset_n)
    readreg <= 0;
  else 
    if (write && address == 1)
      readreg <= writedata; // when we ~reset_n to 0
    else 
      if (clk_enables[cycles])
        readreg <= readreg + result;
      else 
        readreg <= readreg;
end


// writereg : Write
always @(posedge clk) begin
  if (~reset_n)
    writereg <= 0;
  else 
    if (write && address == 0)
      writereg <= writedata;
    else 
      writereg <= writereg;
end


// ---------------------------------------------------  //
// ---------------     Read Logic    -----------------  //
// ---------------------------------------------------  //

// Delay by cycles
int j;
reg [cycles:0] delay_read;


always_ff@(posedge clk) begin
  if (~reset_n)
    delay_read <= {cycles+1{1'b0}};
  else
    for (j = 0; j < cycles; j = j + 1) 
      delay_read[j+1] <= delay_read[j];

  delay_read[0] <= (read == 1);
end

assign readdata = (~reset_n) ? 0 : (delay_read[cycles]) ? readreg : 0;


endmodule



