module cosine #(
parameter WIDTH = 22,
parameter LIMIT = 24'h26dd3b
)(
    input clk, 
    input reset,
    input clk_en,
    input [31:0] angle,
    output [31:0] result
);

localparam [(WIDTH+2)*32-1:0] angles = {24'h0,24'h1,24'h1,24'h1,24'h1,24'h1,24'h1,24'h1,24'h1,24'h1,24'h2,24'h4,24'h7,24'h10,24'h1f,24'h40,24'h80,24'hff,24'h1ff,24'h400,24'h7ff,24'hfff,24'h1fff,24'h3fff,24'h7fff,24'hfffa,24'h1ffd5,24'h3feab,24'h7f56e,24'hfadbb,24'h1dac67,24'h3243f6};

localparam pipeline_stages = 3;
localparam [32*(pipeline_stages+1)-1:0] blocks_per_stage = {32'd16, 32'd9, 32'd3, 32'd0};

// this is read from right to left, i.e stage_1 has blocks_per_stage[-1] blocks 
// Also, its cummulative, i.e the first pipeline starts at 0 and adds 4
// localparam [32*(pipeline_stages+1)-1:0] blocks_per_stage = {32'd18, 32'd12, 32'd6, 32'd0};


wire [WIDTH+1:0] fixedFractionalAngle;
wire [31:0] interm;
unpacker upckr(angle, interm);
sdiv #(.FRACTIONAL_BITS(WIDTH)) subdiv128(interm, fixedFractionalAngle);


logic [WIDTH+1:0] x_p [pipeline_stages:0];
logic [WIDTH+1:0] y_p [pipeline_stages:0];
logic [WIDTH+1:0] w_p [pipeline_stages:0];
logic [WIDTH+1:0] packerInput;

genvar i;
genvar j;

assign x_p[0] = LIMIT;  
assign y_p[0] = {WIDTH+2{1'h0}};
assign w_p[0] = fixedFractionalAngle;

// always_ff @(posedge clk) begin 
//   x_p[0] <= LIMIT;  
//   y_p[0] <={WIDTH+2{1'h0}};
//   w_p[0] <= fixedFractionalAngle;
// end

generate
   for (i = 'd0; i < pipeline_stages; i++) begin : gen_cordic_pipeline
    // int iter_i = getBlock(i);
    localparam [31:0] currStage = blocks_per_stage[i*32+:32];
    localparam [31:0] nextStage = blocks_per_stage[(i+1)*32+:32];

    wire [WIDTH+1:0] x_s [(nextStage - currStage)-1:0];
    wire [WIDTH+1:0] y_s [(nextStage - currStage)-1:0];
    wire [WIDTH+1:0] w_s [(nextStage - currStage)-1:0]; 
   
    engine #(.WIDTH(WIDTH)) en0(currStage[4:0], angles[currStage[4:0]*(WIDTH+2)+:(WIDTH+2)], x_p[i], y_p[i], w_p[i], x_s[0], y_s[0], w_s[0]);     

    for (j = 'd1; j < (nextStage - currStage); j = j + 1) begin : gen_cordic_engines
      localparam [31:0] iter = j + currStage;
      engine #(.WIDTH(WIDTH)) en(iter[4:0], angles[iter[4:0]*(WIDTH+2)+:(WIDTH+2)], x_s[j-1], y_s[j-1], w_s[j-1], x_s[j], y_s[j], w_s[j]);
    end

    if (i == pipeline_stages - 1)
      assign packerInput = x_s[(nextStage-currStage) - 1];
    else begin
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
   end 
endgenerate

packer #( .WIDTH(WIDTH)) pckr(packerInput, result);

endmodule
