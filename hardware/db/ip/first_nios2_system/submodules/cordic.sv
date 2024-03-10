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
    output logic [WIDTH-1:0] fixedPoint_result //remember to drop sign bit always positive in range 0.5403 to 1 before returning
);

localparam  [WIDTH-1:0] x_start = 23'b00100110110111010011101;//0.607252935008881256169446752827757841587066381156807;
localparam  [WIDTH-1:0] y_start = 23'b0;//0.0;
wire [WIDTH-1:0] tan_terms [0:Iterations-1]; //= {22'b0000000000000000111111, 22'b0000000000000001111111, 22'b0000000000000011111111, 22'b0000000000000111111111,
//22'b0000000000011111111111, 22'b0000000000111111111111, 22'b0000000001111111111111, 22'b0000000011111111111101, 22'b0000000111111111111101, 
//22'b0000001111111111101010, 22'b0000011111111111101010, 22'b0000111111101010110111, 22'b0001111101011011011101, 22'b0011101101011000110011, 22'b0110010010000111111011};
//unsigned tan constants

assign tan_terms[14] = 23'b00000000000000000111111;
assign tan_terms[13] = 23'b00000000000000001111111;
assign tan_terms[12] = 23'b00000000000000011111111;
assign tan_terms[11] = 23'b00000000000000111111111;
assign tan_terms[10] = 23'b00000000000011111111111;
assign tan_terms[9]  = 23'b00000000000111111111111;
assign tan_terms[8]  = 23'b00000000001111111111111;
assign tan_terms[7]  = 23'b00000000011111111111111;
assign tan_terms[6]  = 23'b00000000111111111111101;
assign tan_terms[5]  = 23'b00000001111111111101010;
assign tan_terms[4]  = 23'b00000011111111101010101;
assign tan_terms[3]  = 23'b00000111111101010110111;
assign tan_terms[2]  = 23'b00001111101011011011101;
assign tan_terms[1]  = 23'b00011101101011000110011;
assign tan_terms[0]  = 23'b00110010010000111111011;


reg [4:0] loops = 5'b0;

typedef enum {IDLE, S1} stage_control;
stage_control current_stage, next_stage;


 always_ff@(posedge clk) begin
    if (reset || ~clk_en) begin
        current_stage <= IDLE;
        loops <= 5'b0;
    end
    else if (clk_en) begin
        current_stage <= next_stage;
        if (next_stage == S1) begin
            loops <= loops + 1'b1;
             end
        else begin
            loops <= 5'b0;      
        end
    end
 end

// always_ff@(posedge clk) begin
//     if (reset || ~clk_en) begin
//         loops <= 5'b0;
//     end
//     else if ((current_stage == S1)) begin
//         loops <= loops+1'b1;
//     end
// end

always_comb begin
    casez (current_stage)
        IDLE: begin
            casez(start) 
                1'b1: next_stage = S1;
                default: next_stage = IDLE;
            endcase
        end
        S1: begin
            next_stage = (loops >= Stages) ? IDLE : S1;
        end
        default: begin
            next_stage = IDLE;
        end
    endcase
end

reg signed [WIDTH-1:0] x_reg;
reg signed [WIDTH-1:0] y_reg;
reg signed [WIDTH-1:0] z_reg;

wire signed [WIDTH-1:0] x_s [ItersPerStage:0]; 
wire signed [WIDTH-1:0] y_s [ItersPerStage:0];
wire signed [WIDTH-1:0] z_s [ItersPerStage:0];

always_ff@(posedge clk) begin
    if (reset || ~clk_en) begin
        x_reg <= {WIDTH{1'b0}};
        y_reg <= {WIDTH{1'b0}};
        z_reg <= {WIDTH{1'b0}};
    end
    else if (clk_en) begin
        x_reg <= start ? x_start: x_s[ItersPerStage];
        y_reg <= start ? y_start: y_s[ItersPerStage];
        z_reg <= start ? fixedPoint_theta: z_s[ItersPerStage];
    end
end

assign x_s[0] = x_reg;
assign y_s[0] = y_reg;
assign z_s[0] = z_reg;

genvar i;


generate 
    
    for (i = 0; i < ItersPerStage; i++) begin: stage_gen //instantiate 5 iterations in a single stage
    wire [4:0] index;
    assign index = loops*ItersPerStage + i;   
    iteration iter(
        .i(index),
        .atan_i(tan_terms[index]),
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
assign done = loops == Stages;

endmodule

// genvar i;
// generate
//     for (i = 0; i < Cycles; i++) begin: stage_gen
//     wire [WIDTH-1:0] x_internal [Cycles:0];
//     wire [WIDTH-1:0] y_internal [Cycles:0];
//     wire [WIDTH-1:0] z_internal [Cycles:0];
//         stage #(
//             .FRACS(FRACS),
//             .INTS(INTS),
//             .WIDTH(WIDTH)
//         ) stage(//fix this 
//             .i(i),
//             .atan_i(tan_terms[i]),
//             .x_i(x_s[i]),
//             .y_i(y_s[i]),
//             .z_i(z_s[i]),
//             .x_n(x_s[i+1]),
//             .y_n(y_s[i+1]),
//             .z_n(z_s[i+1])
//         );
//     end
// endgenerate

// always_ff@(posedge clk) begin 
//     if (reset) begin
//         stage_counter <= 0;
//     end
//     else if (clk_en) begin
//         if (stage_counter == 0) begin
//             x_s[0] <= x_start;
//             y_s[0] <= y_start;
//             z_s[0] <= fixedPoint_theta;
//         end
//         else begin
//             x_s[stage_counter] <= x_1;
//             y_s[stage_counter] <= y_1;
//             z_s[stage_counter] <= z_1;
//         end
//         stage_counter <= stage_counter + 1;
//     end



// end

// endmodule

