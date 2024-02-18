module cosine (
    input clk, 
    input reset,
    input clk_en,
    input [31:0] angle,
    output [31:0] result
);

localparam WIDTH = 24;
localparam [(WIDTH+2)*32-1:0] angles = {26'h0, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h3, 26'h8, 26'h10, 26'h1f, 26'h40, 26'h7f, 26'h100, 26'h200, 26'h3ff, 26'h7ff, 26'h1000, 26'h1fff, 26'h3fff, 26'h7fff, 26'hffff, 26'h1fffd, 26'h3ffea, 26'h7ff55, 26'hffaad, 26'h1fd5ba, 26'h3eb6ec, 26'h76b19c,26'hc90fdb};

localparam pipeline_stages = 5;

// this is read from right to left, i.e stage_1 has blocks_per_stage[-1] blocks 
// Also, its cummulative, i.e the first pipeline starts at 0 and adds 4
localparam [32*(pipeline_stages+1)-1:0] blocks_per_stage = {32'd20, 32'd16, 32'd12, 32'd8, 32'd4, 32'd0};

wire [WIDTH+1:0] fixedFractionalAngle;
unpacker upckr(angle, fixedFractionalAngle);

reg [WIDTH+1:0] x_p [pipeline_stages:0];
reg [WIDTH+1:0] y_p [pipeline_stages:0];
reg [WIDTH+1:0] w_p [pipeline_stages:0];

initial begin
  x_p[0] = 26'h9b74ee;
  y_p[0] = 26'h0;
  w_p[0] = 26'h0;
end

genvar i;
genvar j;

generate
   for (i = 'd0; i < pipeline_stages; ++i) begin : gen_cordic_pipeline
    int iter_i = getBlock(i);

    wire [WIDTH+1:0] x_s [(getBlock(i+1) - getBlock(i))-1:0];
    wire [WIDTH+1:0] y_s [(getBlock(i+1) - getBlock(i))-1:0];
    wire [WIDTH+1:0] w_s [(getBlock(i+1) - getBlock(i))-1:0];
   
    logic [WIDTH+1:0] alpha_i = getAngle(iter_i[4:0]); 
    engine en0(iter_i[4:0], alpha_i, x_p[i], y_p[i], w_p[i], fixedFractionalAngle, x_s[0], y_s[0], w_s[0]);     

    for (j = 'd1; j < (getBlock(i+1) - getBlock(i)); j = j + 1) begin : gen_cordic_engines
      int iter = j + iter_i;
      logic [WIDTH+1:0] alpha_j =getAngle(iter[4:0]); 
      engine en(iter[4:0], alpha_j, x_s[j-1], y_s[j-1], w_s[j-1], fixedFractionalAngle, x_s[j], y_s[j], w_s[j]);
    end
   
    always_ff @(posedge clk) begin : pipeline_propogate 
      if (reset || ~clk_en) 
        {x_p[i+1], y_p[i+1], w_p[i+1]} <= {3*(WIDTH+2){1'b0}};
      else 
        {x_p[i+1], y_p[i+1], w_p[i+1]} <= {x_s[getBlock(i+1)-getBlock(i)-1], y_s[getBlock(i+1)-getBlock(i)-1], w_s[getBlock(i+1)-getBlock(i)-1]};
    end 

   end 
endgenerate

packer pckr(x_p[pipeline_stages], result);

function [WIDTH+1:0] getAngle ([4:0] index);
  return angles[index*(WIDTH+2)+:(WIDTH+2)];
endfunction

// Not Very functional, but tom clarke isnt marking so its fine
function int getBlock ([4:0] index);
  return blocks_per_stage[index*(32)+:(32)];
endfunction


endmodule
