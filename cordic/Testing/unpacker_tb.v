`timescale 1 ns / 100 ps
module tb();

    reg [31:0] floatingPoint;
    wire [21:0] fixedPoint;

    float_to_fixed unpacker(
        .floatingPoint(floatingPoint),
        .fixedPoint(fixedPoint)
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
        floatingPoint <= 32'd0;
		#10
        //try another 0.77
        floatingPoint <= 32'h3f451eb8;
		//try another -0.07
		#10
        floatingPoint <= 32'hbd8f5c29;
        //try -1
        #10
        floatingPoint <=32'hbf800000;
		#10
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
