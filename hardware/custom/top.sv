`timescale 100ps / 100ps

//Avalon
module top (
  input clk,
  input reset_n,
  input read,
  input write, 
  input [31:0] writedata,
  input  address,
  output [31:0] readdata,
  output wire waitreq
);



localparam cycles = 7;
localparam idle = 3'b001, count = 3'b010, feed = 3'b100;


reg [2:0] state, next_state;
reg [3:0] counter;

reg [31:0] writereg; // address 0 
reg [31:0] readreg; // address 1

initial begin
  state = idle;
end

// waitreq state logic
always@ (*) begin
  case (state)
    idle: begin 
      if (write)
        next_state = count;
      else if (read)
        next_state = idle;
      else
        next_state = state;
    end  
    count: begin 
      if (write)
        next_state = feed;
      else if (counter >= cycles - 2) 
        next_state = idle;
      else 
        next_state = state;
    end
    feed: begin 
      if (write)
        next_state = feed;
      else if (read)
        next_state = count;
      else
        next_state = state;
    end
    default: 
      next_state = idle;
  endcase
end



// state registers
always @(posedge clk) begin : state_register 
  if (~reset_n) 
    state <= idle;
  else 
    state <= next_state;
end


// counter register update
always @(posedge clk) begin : counter_register
  if (~reset_n || state == idle || state == feed) 
    counter <= 4'b0;
  else  // state = count
    counter <= counter + 1'b1;
end


// ---------------------------------------------------  //
// ---------------     Write Logic    ----------------  //
// ---------------------------------------------------  //


// CLK Enables
reg [cycles-1:0] clk_enables;
integer i;
always @(posedge clk) begin 
  if (~reset_n) begin
    clk_enables <= {cycles{1'b0}};
  end else begin
    for (i = 0; i < cycles-1; i = i + 1) begin
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
      if (clk_enables[cycles-1])
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


// output logic
// always @(*) begin
//   if (reset_n)
//     waitreq = 1'b0;
//   else
//     case (state)
//        idle: waitreq = 1'b0;
//        feed: waitreq = ~write;
//        count: waitreq = ~(read && counter >= cycles || write); 
//        default: waitreq = 1'b1; 
//     endcase
// end

assign waitreq = (~reset_n) ? 1'b0 : (state != idle) && (((state == feed) & (~write)) || ((state == count) & (~(read && counter >= cycles || write))));


// readreg : Read
// always @(*) begin 
//   if (~reset_n) 
//     readdata = 0;
//   else
//     readdata = (read && ~waitreq) ? readreg : 0;
// end

assign readdata = (~reset_n) ? 0 : (read && ~waitreq) ? readreg : 0;




endmodule



