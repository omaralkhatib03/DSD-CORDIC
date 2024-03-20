module cos #(
    parameter WIDTH = 24
)(
    input              clk, 
    input              clk_en,
    input              reset,
    input              start,
    input  [31:0] theta_in,
    output             done,
    output [31:0] result
);

// FSM
localparam IDLE = 0, COS = 1, maxCycle = 6;
reg       state;
reg       nextState;
reg [3:0] cycle;

always_comb begin 
    casez (state)
        IDLE:     nextState = start ? COS : IDLE;
        COS:      nextState = done  ? IDLE : COS; 
        default : nextState = IDLE; 
    endcase

end

always_ff @(posedge clk) begin
    if (reset || ~clk_en) state <= IDLE;
    else                  state <= nextState;
end

always_ff @(posedge clk) begin 
    if (reset || ~clk_en || nextState == IDLE) 
        cycle <= 0;
    else
        cycle <= cycle + 1;
end 

assign done = cycle >= maxCycle;

// Data path
    localparam iterations        = 22;
    localparam cordics_per_cycle = 4;

    wire signed [WIDTH-1:0] theta_fx;

    float_to_fixed fpfx(theta_in,theta_fx); 
    wire signed [WIDTH-1:0] x[cordics_per_cycle:0];
    wire signed [WIDTH-1:0] y[cordics_per_cycle:0];
    wire signed [WIDTH-1:0] theta[cordics_per_cycle:0];

    reg signed [WIDTH-1:0] x_reg;
    reg signed [WIDTH-1:0] y_reg;
    reg signed [WIDTH-1:0] theta_reg;

    reg [WIDTH-1:0] arctan[iterations-1:0];

assign arctan[0] = 24'h3243f6;
assign arctan[1] = 24'h1dac67;
assign arctan[2] = 24'hfadbb;
assign arctan[3] = 24'h7f56e;
assign arctan[4] = 24'h3feab;
assign arctan[5] = 24'h1ffd5;
assign arctan[6] = 24'hfffa;
assign arctan[7] = 24'h7fff;
assign arctan[8] = 24'h3fff;
assign arctan[9] = 24'h1fff;
assign arctan[10] = 24'hfff;
assign arctan[11] = 24'h7ff;
assign arctan[12] = 24'h400;
assign arctan[13] = 24'h1ff;
assign arctan[14] = 24'hff;
assign arctan[15] = 24'h80;
assign arctan[16] = 24'h40;
assign arctan[17] = 24'h1f;
assign arctan[18] = 24'h10;
assign arctan[19] = 24'h7;
assign arctan[20] = 24'h4;
assign arctan[21] = 24'h2;

always_ff @(posedge clk) begin
    if (start) begin 
        x_reg     <= 'h26dd3b;//1/k
        y_reg     <=   0;
        theta_reg <=   theta_fx; 
    end else begin 
        x_reg     <= x[cordics_per_cycle];
        y_reg     <= y[cordics_per_cycle];
        theta_reg <= theta[cordics_per_cycle];
    end
end

assign x[0]     = x_reg;
assign y[0]     = y_reg;
assign theta[0] = theta_reg;

genvar i;
generate
    for (i = 0; i < cordics_per_cycle; i = i + 1) begin : cordc_stages
        wire [4:0] j = i + (cycle * cordics_per_cycle);
        cordic iteration(
            .i(j),
            .a_i(arctan[j]),
            .x_in(x[i]),
            .y_in(y[i]),
            .theta_in(theta[i]),
            .x_out(x[i+1]),
            .y_out(y[i+1]),
            .theta_out(theta[i+1])
        );
    end
endgenerate

fixed_to_float fxfp(x[2], result);

endmodule

