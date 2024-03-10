`timescale 1 ns / 100 ps
module packer_tb();

    reg [21:0] fixedPoint;
    wire [31:0] floatingPoint;

    fixed_to_float packer(
        .ufixedPoint(fixedPoint),
        .floatingPoint(floatingPoint)      
    );

    initial
	begin
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		// clk = 1'b0;
		
		// If using a clock
		// @(posedge clk); 
		
		// Wait 10 cycles (corresponds to timescale at the top) 
		#10
		
        // Set the input try 0
        fixedPoint = 22'h0;

		#10
        //try another 0.5405
        fixedPoint <= 22'b0100010100101111000110;
		//try another 0.99
		#10
        fixedPoint <= 22'b0111111010111000010100;
        //try 1
        #10
        fixedPoint <=22'b1000000000000000000000;
		#10
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
