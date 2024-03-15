`timescale 100ps / 100ps

module top (
  input clk, 
  input clk_en, 
  input reset, 
  input [31:0] x, // held until done is asserted, can assume its always available
  output [31:0] result,
  input start, 
  output done
);


// fsm to control system
localparam IDLE = 1'b0, BUSY = 1'b1;
localparam cycles = 14;

reg s, ns; 
reg [4:0] count;

always @(*) begin 
  casez(s)
    IDLE: ns = start ? BUSY : IDLE;
    BUSY: ns = count >= cycles ? IDLE : BUSY;
    default: ns = IDLE;
  endcase
end 


always_ff @(posedge clk) begin
  if (reset || ~clk_en)
    s <= IDLE;
  else 
    s <= ns;
end
  
assign done = count == cycles;


// count logic 
always_ff @(posedge clk) begin 
  if (reset || ~clk_en || s == IDLE && ns == IDLE)
    count <= 0;
  else 
    count <= count + 1'b1;
end 


// data path 
reg [31:0] a_a; 
reg [31:0] b_a; 
wire [31:0] q_a; 
wire en = s == BUSY || (s == IDLE && ns == BUSY);

reg [31:0] a_m; 
reg [31:0] b_m; 
wire [31:0] q_m; 

reg [31:0] angle; 
wire [31:0] cos_angle; 


fp_add addr(
		.clk(clk),    //    clk.clk
		.areset(reset), // areset.reset
    .en(en),     //     en.en
		.a(s == IDLE && ns == BUSY ? x : a_a),      //      a.a
		.b(s == IDLE && ns == BUSY ? 32'hc3000000 : b_a),      //      b.b
		.q(q_a)       //      q.q
);


fp_mult mult (
		.clk    (clk),    //    clk.clk
		.areset (reset), // areset.reset
		.en     (en),     //     en.en
		.a      (s == IDLE && ns == BUSY ? x : a_m),      //      a.a
		.b      (s == IDLE && ns == BUSY ? x : b_m),      //      b.b
		.q      (q_m)       //      q.q
	);


cosine cos(
    .clk(clk), 
    .reset(reset),
    .clk_en(en),
    .angle(angle),
    .result(cos_angle)
);


// data logic 
// i.e what gets added when
reg [31:0] x_2_latch;
reg [31:0] half_x_latch;

// adder logic 
always_ff@(posedge clk) begin 
  if (reset || ~clk_en || (s == IDLE && ns == IDLE)) begin 
    a_a <= 0;
    b_a <= 0;
  end else begin 
    casez(count)
    11: begin
      a_a <= half_x_latch;
      b_a <= q_m;
   end
   default: begin 
      a_a <= 0;
      b_a <= 0;
    end
    endcase
  end
end

// mult logic 
always_ff@(posedge clk) begin 
  if (reset || ~clk_en || (s == IDLE && ns == IDLE)) begin
    a_m <= 0;
    b_m <= 0;
  end else begin
    casez(count)
      0: begin 
        a_m <= x;
        b_m <= 32'h3f000000; 
      end
      2: begin 
        a_m <= q_a;
        b_m <= 32'h3c000000;
      end
      8: begin 
        a_m <= x_2_latch;
        b_m <= cos_angle;
      end
      default: begin 
        a_m <= 0;
        b_m <= 0;
      end
      endcase
  end
end

// cordic logic 
always_ff @(posedge clk) begin 
  if (reset || ~clk_en || s == IDLE)
    angle <= 0;
  else 
    angle = q_m;
end



// latches to store x^2
always_ff @(posedge clk) begin 
  if (reset || ~clk_en || s == IDLE) 
    x_2_latch <= 0;
  else if (count == 2) 
    x_2_latch <= q_m;
  else 
    x_2_latch <= x_2_latch;
end 


// latches to store x/2
always_ff @(posedge clk) begin 
  if (reset || ~clk_en || s == IDLE) 
    half_x_latch <= 0;
  else if (count == 3) 
    half_x_latch <= q_m;
  else 
    half_x_latch <= half_x_latch;
end 


// output logic 
assign result = done ? q_a : 0;

endmodule










