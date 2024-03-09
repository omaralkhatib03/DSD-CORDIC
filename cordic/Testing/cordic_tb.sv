`timescale 1 ns / 100 ps
module cordic_tb();

    reg [22:0] fixedPoint;
    reg clk,clk_en,reset;
    wire [21:0] fixedPoint_result;

    cordic dut(
        .clk(clk),
        .reset(reset),
        .clk_en(clk_en),
        .fixedPoint_theta(fixedPoint),
        .fixedPoint_result(fixedPoint_result)     
    );

    initial
    clk = 1'b1 ;
    always
    #1
    clk = ~clk;


	initial begin
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
        reset = 1'b0;
		clk_en = 1'b1;
		
		
		// Wait 10 cycles (corresponds to timescale at the top) 
		#100
		
        // Set the input try 0
        fixedPoint <= 23'h0;

		#100
        //try another 0.5405
        fixedPoint <= 23'b00100010100101111000110;
		//try another 0.99
		#100
        fixedPoint <= 23'b00111111010111000010100;
        //try 1
        #100
        fixedPoint <=23'b01000000000000000000000; //dont need to worry about signed as even function
		#100
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
