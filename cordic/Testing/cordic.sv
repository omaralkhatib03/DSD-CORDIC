module cordic #(
    parameter FRACS = 21,
    parameter INTS = 1,
    parameter WIDTH = INTS + FRACS + 1,  //sign bit needed for algorithm
    parameter Iterations = 15
)
(
    input clk,
    input reset,
    input clk_en,
    input [WIDTH-1:0] fixedPoint_theta,
    output logic [WIDTH-2:0] fixedPoint_result //remember to drop sign bit always positive in range 0.5403 to 1 before returning
);

localparam  [WIDTH-1:0] x_start = 23'b00100110110111010011101;//0.607252935008881256169446752827757841587066381156807;
localparam  [WIDTH-1:0] y_start = 23'b0;//0.0;
localparam [WIDTH-2:0] tan_terms [0:Iterations-1] = {22'b0110010010000111111011, 22'b0011101101011000110011, 22'b0001111101011011011101, 22'b0000111111101010110111,
22'b0000011111111101010101, 22'b0000001111111111101010, 22'b0000000111111111111101, 22'b0000000011111111111111, 22'b0000000001111111111111, 
22'b0000000000111111111111, 22'b0000000000011111111111, 22'b0000000000001111111111, 22'b0000000000000111111111, 22'b0000000000000011111111, 22'b0000000000000001111111};
//unsigned tan constants

logic [WIDTH-1:0] z_0 ; //concatenated sign bit needed for algorithm in top module
logic [WIDTH-1:0] x_0;
logic [WIDTH-1:0] y_0;
logic [WIDTH-1:0] x_1;
logic [WIDTH-1:0] y_1;
logic [WIDTH-1:0] z_1;
wire di = z_0[WIDTH-1]; //high is negative 

always_ff @(posedge clk) begin
    if (clk_en) begin
        z_0 <= fixedPoint_theta;
        x_0 <= x_start;
        y_0 <= y_start;
        for (int i = 0; i < Iterations; i++) begin
            x_1 <= di ? x_0 + (y_0 >>> i) : x_0 - (y_0 >>> i);
            y_1 <= di ? y_0 - (x_0 >>> i) : y_0 + (x_0 >>>i);
            z_1 <= di ? z_0 + {1'b0, tan_terms[i]} : z_0 - {1'b0 ,tan_terms[i]};
            x_0 <= x_1;
            y_0 <= y_1;
            z_0 <= z_1;
            if (i == Iterations-1) begin
                fixedPoint_result <= x_1;
            end
        end 
    end
    if (reset) begin
        x_0 <= x_start;
        y_0 <= y_start;
        z_0 <= {fixedPoint_theta};
    end  
end

endmodule

