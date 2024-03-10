module cordic #(
    parameter FRACS = 21,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS + 1,  //sign bit needed for algorithm
    parameter Iterations = 15,
    parameter Stages = 3,
    parameter ItersPerStage = 5 //Iterations / Stages
)
(
    input clk,
    input reset,
    input clk_en,
    input start,
    input [WIDTH-1:0] fixedPoint_theta,
    output done,
    output [WIDTH-1:0] fixedPoint_result //remember to drop sign bit always positive in range 0.5403 to 1 before returning
);

localparam  [WIDTH-1:0] x_start = 23'b00100110110111010011101;//0.607252935008881256169446752827757841587066381156807;
localparam  [WIDTH-1:0] y_start = 23'b0;//0.0;
wire [WIDTH-2:0] tan_terms [0:Iterations];



   assign tan_terms[14] = 22'b0000000000000000111111;
   assign tan_terms[13] = 22'b0000000000000001111111;
   assign tan_terms[12] = 22'b0000000000000011111111;
   assign tan_terms[11] = 22'b0000000000000111111111;
   assign tan_terms[10] = 22'b0000000000011111111111;
   assign tan_terms[9] = 22'b0000000000111111111111;
   assign tan_terms[8] = 22'b0000000001111111111111;
   assign tan_terms[7] = 22'b0000000011111111111101;
   assign tan_terms[6] = 22'b0000000111111111111101;
   assign tan_terms[5] = 22'b0000001111111111101010;
   assign tan_terms[4] = 22'b0000011111111111101010;
   assign tan_terms[3] = 22'b0000111111101010110111;
   assign tan_terms[2] = 22'b0001111101011011011101; 
   assign tan_terms[1] = 22'b0011101101011000110011;
   assign tan_terms[0] = 22'b0110010010000111111011;


//unsigned tan constants

wire signed [WIDTH-1:0] x_s [ItersPerStage:0]; 
wire signed [WIDTH-1:0] y_s [ItersPerStage:0];
wire signed [WIDTH-1:0] z_s [ItersPerStage:0];

reg signed [WIDTH-1:0] x_reg;
reg signed [WIDTH-1:0] y_reg;
reg signed  [WIDTH-1:0] z_reg;

reg [4:0] loops = 5'b0;

typedef enum {IDLE, S1} stage_control;
stage_control current_stage, next_stage;


 always_ff@(posedge clk) begin
    if (reset || ~clk_en) begin
        current_stage <= IDLE;
    end
    else if (clk_en) begin
        current_stage <= next_stage;
    end
end

always_ff@(posedge clk) begin
    if (reset || ~clk_en || current_stage == IDLE) begin
        loops <= 5'b0;
    end
    else if (clk_en && current_stage == S1) begin
        loops <= loops + 1;
    end
end

always_comb begin
    casez (current_stage)
        IDLE: begin
            casez(start)
                1'b1: next_stage = S1;
                default: next_stage = IDLE;
            endcase
        end
        S1: begin
            next_stage = loops >= Stages ? IDLE : S1;
        end
        default: begin
            next_stage = IDLE;
        end
    endcase
end

always_ff @(posedge clk) begin
    if (reset || ~clk_en) begin
      x_reg <= {WIDTH{1'b0}};
      y_reg <= {WIDTH{1'b0}};
      z_reg <= {WIDTH{1'b0}};
    end else begin
      x_reg <= x_s[ItersPerStage];
      y_reg <= y_s[ItersPerStage];
      z_reg <= z_s[ItersPerStage];
    end
end

assign x_s[0] = start ? x_start : x_reg;
assign y_s[0] = start ? y_start : y_reg;
assign z_s[0] = start ? fixedPoint_theta : z_reg;

genvar i;
generate
    for (i = 0; i < ItersPerStage; i++) begin: stage_gen //instantiate 5 iterations
      wire [4:0] index = (loops*ItersPerStage) + i;
      iteration iter(
          .i(index),
          .atan_i(tan_terms[index[3:0]]),
          .x_i(x_s[i]),
          .y_i(y_s[i]),
          .z_i(z_s[i]),
          .x_n(x_s[i+1]),
          .y_n(y_s[i+1]),
          .z_n(z_s[i+1])
      );
    end
endgenerate

assign fixedPoint_result = x_reg;
assign done = loops == Iterations;

endmodule

