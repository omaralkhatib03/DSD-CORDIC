`timescale 100 ps / 100 ps
module cordic_tb();

    reg [22:0] fixedPoint;
    reg clk,clk_en,reset,start;
    wire [22:0] fixedPoint_result;
    wire done;

    cordic dut (
      .clk(clk),
      .reset(reset),
      .clk_en(clk_en),
      .start(start),
      .done(done),
      .fixedPoint_theta(fixedPoint),
      .fixedPoint_result(fixedPoint_result)     
    );

    initial
    clk = 1'b1 ;
    always
    #1
    clk = ~clk;


	initial begin
		// intialise/set input
    reset = 1'b0;
		clk_en = 1'b1;
		#4
    start = 1'b1;
    fixedPoint = 23'b01000000000000000000000;
    #2
    start = 1'b0;
	end

endmodule
