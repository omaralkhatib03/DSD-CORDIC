module fx(
    input [31:0] x,
    input clk,
    input reset,
    input clk_en,
    input start,
    output done,
    output [31:0] f_x
);

typedef enum {IDLE, DIV2_SUB128, DIV128, CORDIC_X2, X2_COS, ADD} proc_state;
proc_state current_proc, next_proc;

reg [2:0] count;
//intermediate result registers
reg [31:0] x_minus_128;
reg [31:0] x_squared_cos;
reg [31:0] x_squared;
reg [31:0] half_x;
reg [31:0] x_minus_128_div_128;
reg [31:0] cos_result;

wire cordic_done;
wire cordic_start;
// state transition
always_ff @(posedge clk)begin
    if (reset || ~clk_en) 
        current_proc <= IDLE;
    else 
        current_proc <= next_proc;      
end
//counter
always_ff @(posedge clk)begin
    if (reset || ~clk_en  || (current_proc == IDLE) || (count >=2 && current_proc != CORDIC_X2) || cordic_done)
        count <= 0;
    else if (current_proc != next_proc) 
        count <= 0;
    else
        count <= count + 1;       
end
//next state logic
always_comb begin
    case (current_proc)
        IDLE : 
            next_proc = (start) ? DIV2_SUB128 : IDLE;
        DIV2_SUB128: 
            next_proc = (count >= 2) ? DIV128 : DIV2_SUB128;
        DIV128 : 
            next_proc = (count >= 2) ? CORDIC_X2 : DIV128;
        CORDIC_X2 : 
            next_proc = (cordic_done) ? X2_COS : CORDIC_X2;
        X2_COS : 
            next_proc = (count >= 2) ? ADD : X2_COS;
        ADD : 
            next_proc = (count >=2) ? IDLE : ADD;
        default : 
            next_proc = IDLE;
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
                 current_proc == DIV128 ? x_minus_128 : 
                 current_proc == CORDIC_X2 ? x : 
                 current_proc == X2_COS ? x_squared : 32'h0;

assign mul_op_b = current_proc == DIV2_SUB128 ? 32'h3f000000 : //*0.5
                    current_proc == DIV128 ? 32'h3c000000 : //div 128
                    current_proc == CORDIC_X2 ? x : //x*x
                    current_proc == X2_COS ? cos_result : 32'h0;

assign add_op_a = current_proc == DIV2_SUB128 ? x :
                    current_proc == ADD ? x_squared_cos : 32'h0;

assign add_op_b = current_proc == DIV2_SUB128 ? 32'hc3000000 : //-128
                    current_proc == ADD ? half_x : 32'h0; //x/2 * cos

assign cordic_input = current_proc == CORDIC_X2 ? x_minus_128_div_128 : 32'h0;

assign f_x = current_proc == ADD ? add_result : 32'h0;

//result logic
always_ff @(posedge clk)begin
    if (reset || ~clk_en) begin
        x_minus_128 <= 32'h0;
        x_squared_cos <= 32'h0;
        x_squared <= 32'h0;
        half_x <= 32'h0;
        x_minus_128_div_128 <= 32'h0;
        cos_result <= 32'h0;
    end
    else begin    
        case (current_proc)
            DIV2_SUB128 : 
            begin
                x_minus_128 <= add_result;
                half_x <= mul_result;
            end
            DIV128 : 
                x_minus_128_div_128 <= mul_result;
            CORDIC_X2 : 
            begin
                cos_result <= cordic_result;
                x_squared <= mul_result;
            end
            X2_COS : 
                x_squared_cos <= mul_result;
            // ADD : 
            //     f_x <= count >=2 ? add_result: 32'h0;
            default : {x_minus_128,x_squared_cos,x_squared,half_x,x_minus_128_div_128,cos_result} = {6{32'h0}};
        endcase
    end
end

// always_comb begin
//     case (current_proc)
//         IDLE:
//             begin//initialise inputs
//                 mul_op_a = 32'h0;
//                 mul_op_b = 32'h0;
//                 add_op_a = 32'h0;
//                 add_op_b = 32'h0;
//                 cordic_input = 32'h0;
//             end
//         DIV2_SUB128:
//             begin
//                 mul_op_a = x;
//                 mul_op_b = 32'h3f000000; //times by 0.5
//                 half_x = mul_result; 
//                 add_op_a = x;
//                 add_op_b = 32'hc3000000; //add -128
//                 sub_128 = add_result;
//             end

//     endcase
// end
//wiring


// wire [31:0] mul_result;
// wire [31:0] half_x;
// wire [31:0] sub_128;
// wire [31:0] div_128;
// wire [31:0] add_result;
// wire [31:0] cordic_input;
// wire [31:0] cordic_result;
// wire [31:0] x_squared;
// wire [31:0] x_squared_cos;

// reg start_ff; //delayed start signal for cordic block

// if (current_proc == DIV2_SUB128) begin
//     assign mul_op_a = x;
//     assign mul_op_b = 32'h3f000000; //times by 0.5
//     assign half_x = mul_result; 
//     assign add_op_a = x;
//     assign add_op_b = 32'hc3000000; //add -128
//     assign sub_128 = add_result;
// end else if (current_proc == DIV128) begin
//     assign mul_op_a = sub_128;
//     assign mul_op_b = 32'h3c000000; //times by 1/128
//     assign div_128 = mul_result;        
// end else if (current_proc == CORDIC_X2) begin
//     assign mul_op_a = x;
//     assign mul_op_b = x;
//     assign x_squared = mul_result;
//     assign cordic_input = div_128;   
// end else if (current_proc == X2_COS) begin
//     assign mul_op_a = x_squared;
//     assign mul_op_b = cordic_result; //times x_squared by cos
//     assign x_squared_cos = mul_result;
// end else if (current_proc == ADD) begin
//     assign add_op_a = x_squared_cos;
//     assign add_op_b = half_x;  //add results
//     assign f_x = add_result;
// end else begin
//     assign {half_x,div_128,x_squared,x_squared_cos}  = {4{32'h0}};
// end

// case (current_proc)
//     DIV2_SUB128 : assign mul_op_a = x;
//     DIV128 : assign mul_op_a = sub_128;
//     CORDIC_X2 : assign mul_op_a = x;
//     X2_COS : assign mul_op_a = x_squared;
//     default : assign mul_op_a = 32'h0;
// endcase

// case (current_proc)
//     DIV2_SUB128 : assign mul_op_b = 32'h3f000000; //times by 0.5
//     DIV128 : assign mul_op_b = 32'h3c000000; //times by 1/128
//     CORDIC_X2 : assign mul_op_b = x;
//     X2_COS : assign mul_op_b = cordic_result; //times x_squared by cos
//     default : assign mul_op_b = 32'h0;
// endcase

// case (current_proc)
//     DIV2_SUB128 : assign half_x = mul_result;
//     DIV128 : assign div_128 = mul_result;
//     CORDIC_X2 : assign x_squared = mul_result;
//     X2_COS : assign x_squared_cos = mul_result;
//     default : assign {half_x,div_128,x_squared,x_squared_cos}  = {4{32'h0}};
// endcase

// case (current_proc)
//     DIV2_SUB128 : assign add_op_a = x;
//     ADD : assign add_op_a = x_squared_cos;
//     default : assign add_op_a = 32'h0;
// endcase

// case (current_proc)
//     DIV2_SUB128 : assign add_op_b = 32'hc3000000; //add -128
//     ADD : assign add_op_b = half_x;  //add results
//     default : assign add_op_b = 32'h0;
// endcase

// case (current_proc)
//     DIV2_SUB128 : assign sub_128 = add_result;
//     ADD : assign f_x = add_result;
//     default : assign {sub_128,f_x} = {2{32'h0}};
// endcase


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