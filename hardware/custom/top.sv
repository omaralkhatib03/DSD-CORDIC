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
wire xo, ao, xu;

// ---------------------------------------------------  //
// ---------------     Write Logic    ----------------  //
// ---------------------------------------------------  //

// CLK Enables
reg [cycles:0] clk_enables;
int i;

initial begin
  clk_enables = 0;
end

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
wire clk_en = |clk_enables[cycles:0];

term trm (
  .clk(clk),
  .clk_en(clk_en),
  .reset(~reset_n),
  .x(writereg),
  .result(result)
);

localparam acc_cycles = 4;
reg [acc_cycles:0] acc_clk_enables;
int j;

initial begin
  acc_clk_enables = 0;
end

always @(posedge clk) begin
  if (~reset_n) 
    acc_clk_enables <= {acc_cycles+1{1'b0}};
  else 
    for (j = 0; j < acc_cycles; j = j + 1)  begin
      acc_clk_enables[j+1] <= acc_clk_enables[j];
    end
    acc_clk_enables[0] <= clk_enables[cycles-1];
end


localparam idle=0, wait_for_set=1;
reg state, next_state;
wire n;

/// n state machine 
initial begin
  state = idle;
end

always_comb begin
  case(state)
    idle: next_state = (write && address) ? wait_for_set : idle;
    wait_for_set: next_state = acc_clk_enables[0] ? idle : wait_for_set;
  endcase
end

always @(posedge clk) begin
  if (~reset_n) 
    state <= 1'b0;
  else 
    state <= next_state;
end

assign n = state == wait_for_set;

wire [31:0] q;
wire acc_en = |acc_clk_enables[acc_cycles:0]; 
wire [31:0] acc_in;


fp_acc fp_accer (
  .clk    (clk),    //    clk.clk
  .areset (~reset_n), // areset.reset
  .x      (acc_en && clk_en ? result : 0),      //      x.x
  .n      (n),      //      n.n
  .r      (q),      //      r.r
  .xo     (xo),     //     xo.xo
  .xu     (xu),     //     xu.xu
  .ao     (ao),     //     ao.ao
  .en     (acc_en)      //     en.en
);


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


// readreg : Write 
always @(posedge clk) begin
  if (~reset_n)
    readreg <= 0;
  else 
    if (write && address == 1)
      readreg <= writedata; // when we ~reset_n to 0
    else 
      if (acc_clk_enables[acc_cycles])
        readreg <= q;
      else 
        readreg <= readreg;
end


// ---------------------------------------------------  //
// ---------------     Read Logic    -----------------  //
// ---------------------------------------------------  //

// Delay by cycles
int k;
reg [cycles + acc_cycles:0] delay_read;


always_ff@(posedge clk) begin
  if (~reset_n)
    delay_read <= {cycles+acc_cycles+1{1'b0}};
  else
    for (k = 0; k < cycles + acc_cycles; k = k + 1) 
      delay_read[k+1] <= delay_read[k];

  delay_read[0] <= (read == 1);
end

assign readdata = (~reset_n) ? 0 : (delay_read[cycles+acc_cycles]) ? readreg : 0;

endmodule



