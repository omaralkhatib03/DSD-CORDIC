module fx_opt(
    input [31:0] x,
    input clk,
    input reset,
    input clk_en,
    input start,
    output done,
    output [31:0] f_x
);

typedef enum {DIV2_SUB128, DIV128, CORDIC_X2, X2_COS, ADD} proc_state; //test without idle
proc_state current_proc, next_proc;

reg [2:0] count;
reg [31:0] x_squared;
reg [31:0] half_x;
wire cordic_done;
wire cordic_start;
// state transition
always_ff @(posedge clk)begin
    if (reset || ~clk_en) 
        current_proc <= DIV2_SUB128;//IDLE;
    else 
        current_proc <= next_proc;      
end
//counter
always_ff @(posedge clk)begin
    if (reset || ~clk_en  || start || (count >=2 && current_proc != CORDIC_X2) || cordic_done)
        count <= 0;
    else if (current_proc != next_proc) 
        count <= 0;
    else
        count <= count + 1;       
end
//next state logic
always_comb begin
    case (current_proc)
        DIV2_SUB128: 
            next_proc = (count >= 1) ? DIV128 : DIV2_SUB128; //need to wait at least one cycle :result of x-128 needed for next state
        DIV128 : 
            next_proc = (count >= 1) ? CORDIC_X2 : DIV128;
        CORDIC_X2 : 
            next_proc = (cordic_done) ? X2_COS : CORDIC_X2;
        X2_COS : 
            next_proc = (count >= 0) ? ADD : X2_COS;
        ADD : 
            next_proc = (count >=2) ? DIV2_SUB128: ADD;
        default : 
            next_proc = DIV2_SUB128;
    endcase
end

assign cordic_start = (current_proc == CORDIC_X2 && count == 0) ? 1'b1 : 1'b0;
assign done = ((current_proc == ADD) && (count >=2 ))? 1'b1 : 1'b0;

//input logic
wire [31:0] mul_op_a;
wire [31:0] mul_op_b;
wire [31:0] mul_result;
wire [31:0] add_op_a;
wire [31:0] add_op_b;
wire [31:0] add_result;
wire [31:0] cordic_input;
wire [31:0] cordic_result;

assign mul_op_a = current_proc == DIV2_SUB128 ? x : 
                 current_proc == DIV128 ? add_result : //wire directly to save a cycle
                 current_proc == CORDIC_X2 && ~cordic_done? x : 
                 current_proc == CORDIC_X2 && cordic_done ? x_squared:
                 current_proc == X2_COS ? x_squared : 32'h0;

assign mul_op_b = current_proc == DIV2_SUB128 ? 32'h3f000000 : //*0.5
                    current_proc == DIV128 ? 32'h3c000000 : //div 128
                    current_proc == CORDIC_X2 && ~cordic_done? x : //x*x
                    current_proc == CORDIC_X2 && cordic_done ? cordic_result : 32'h0;//wire directly to save a cycle

assign add_op_a = current_proc == DIV2_SUB128 ? x :
                    current_proc == ADD ? mul_result: 32'h0; //wire directly to save a cycle

assign add_op_b = current_proc == DIV2_SUB128 ? 32'hc3000000 : //-128
                    current_proc == ADD ? half_x : 32'h0; //x/2 * cos

assign cordic_input = current_proc == CORDIC_X2 ? mul_result : 32'h0;

assign f_x = current_proc == ADD ? add_result : 32'h0;

//result logic
always_ff @(posedge clk)begin
    if (reset || ~clk_en) begin
        x_squared <= 32'h0;
        half_x <= 32'h0;
    end
    else begin    
        case (current_proc)
            DIV128 : 
                half_x <= mul_result; //write on next state
            CORDIC_X2 : 
                x_squared <= mul_result;
        endcase
    end
end

fp_mult fp_mul(//used for squared half x_squared*cos and divide by 128
    .clk (clk),
    .areset (reset),
    .en (clk_en),
    .a(mul_op_a),
    .b(mul_op_b),
    .q(mul_result)
);

fp_add add(//used for final adding 
    .clk (clk),
    .areset (reset),
    .en (clk_en),
    .a(add_op_a),
    .b(add_op_b),
    .q(add_result)
);

cosine cordic(
    .clk(clk),
    .reset(reset),
    .clk_en(clk_en),
    .start(cordic_start), //need to form this
    .done(cordic_done),
    .floatingPoint_theta(cordic_input),
    .floatingPoint_result(cordic_result)
);

endmodule