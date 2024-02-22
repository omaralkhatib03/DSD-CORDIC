module cosine #(
parameter WIDTH = 24,
parameter LIMIT = 26'h9b74ee,
parameter ITERATIONS = 25

)
(
    input clk, 
    input reset,
    input clk_en,
    input [31:0] angle,
    output [31:0] result
);

localparam [(WIDTH+2)*32-1:0] angles = {26'h0, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h1, 26'h3, 26'h8, 26'h10, 26'h1f, 26'h40, 26'h7f, 26'h100, 26'h200, 26'h3ff, 26'h7ff, 26'h1000, 26'h1fff, 26'h3fff, 26'h7fff, 26'hffff, 26'h1fffd, 26'h3ffea, 26'h7ff55, 26'hffaad, 26'h1fd5ba, 26'h3eb6ec, 26'h76b19c,26'hc90fdb};
localparam x_p_init = 26'h9b74ee;

localparam pipeline_stages = 3;
localparam [32*(pipeline_stages+1)-1:0] blocks_per_stage = {32'd16, 32'd11, 32'd5, 32'd0};

// this is read from right to left, i.e stage_1 has blocks_per_stage[-1] blocks 
// Also, its cummulative, i.e the first pipeline starts at 0 and adds 4
// localparam [32*(pipeline_stages+1)-1:0] blocks_per_stage = {32'd18, 32'd12, 32'd6, 32'd0};


wire [WIDTH+1:0] fixedFractionalAngle;
unpacker #(.FRACTIONAL_BITS(WIDTH)) upckr(angle, fixedFractionalAngle);

logic [WIDTH+1:0] x_p [pipeline_stages:0];
logic [WIDTH+1:0] y_p [pipeline_stages:0];
logic [WIDTH+1:0] w_p [pipeline_stages:0];

genvar i;
genvar j;

  // assign x_p[0] = x_p_init;  
  // assign y_p[0] = 26'h0;
  // assign w_p[0] = fixedFractionalAngle;

always_ff @(posedge clk) begin 
  x_p[0] <= x_p_init;  
  y_p[0] <= 26'h0;
  w_p[0] <= fixedFractionalAngle;
end

generate
   for (i = 'd0; i < pipeline_stages; i++) begin : gen_cordic_pipeline
    // int iter_i = getBlock(i);
    localparam [31:0] currStage = blocks_per_stage[i*32+:32];
    localparam [31:0] nextStage = blocks_per_stage[(i+1)*32+:32];

    wire [WIDTH+1:0] x_s [(nextStage - currStage)-1:0];
    wire [WIDTH+1:0] y_s [(nextStage - currStage)-1:0];
    wire [WIDTH+1:0] w_s [(nextStage - currStage)-1:0]; 
   
    engine en0(currStage[4:0], angles[currStage[4:0]*(WIDTH+2)+:(WIDTH+2)], x_p[i], y_p[i], w_p[i], x_s[0], y_s[0], w_s[0]);     

    for (j = 'd1; j < (nextStage - currStage); j = j + 1) begin : gen_cordic_engines
      localparam [31:0] iter = j + currStage;
      engine en(iter[4:0], angles[iter[4:0]*(WIDTH+2)+:(WIDTH+2)], x_s[j-1], y_s[j-1], w_s[j-1], x_s[j], y_s[j], w_s[j]);
    end
   
    always_ff @(posedge clk) begin : pipeline_propogate 
      if (reset || ~clk_en) begin 
        x_p[i+1] <= {WIDTH+2{1'b0}};
        y_p[i+1] <= {WIDTH+2{1'b0}};
        w_p[i+1] <= {WIDTH+2{1'b0}};
      end else begin 
        x_p[i+1] <= x_s[(nextStage - currStage) - 1];
        y_p[i+1] <= y_s[(nextStage - currStage) - 1];
        w_p[i+1] <= w_s[(nextStage - currStage) - 1];
      end
    end 
   end 
endgenerate

packer #( .WIDTH(WIDTH)) pckr(x_p[pipeline_stages], result);



endmodule
