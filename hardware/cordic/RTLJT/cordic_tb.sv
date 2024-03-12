`timescale 100 ps / 100 ps
module cordic_tb();

    //reg [22:0] fixedPoint;
    reg [31:0] floatingPoint;
    reg clk,clk_en,reset,start;
    wire [22:0] fixedPoint_result;
    wire [31:0] floatingPoint_result;
    wire done;

    // cordic dut(
    //     .clk(clk),
    //     .reset(reset),
    //     .clk_en(clk_en),
    //     .start(start),
    //     .done(done),
    //     .fixedPoint_theta(fixedPoint),
    //     .fixedPoint_result(fixedPoint_result)     
    // );

    cosine cosine(
        .clk(clk),
        .reset(reset),
        .clk_en(clk_en),
        .start(start),
        .done(done),
        .floatingPoint_theta(floatingPoint),
        .floatingPoint_result(floatingPoint_result)
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
		clk_en = 1'b0;  
		
		#2
        clk_en = 1'b1;
		// Wait 2 cycles (corresponds to timescale at the top) 
		// #4
        // // Set the input try -1
        // start = 1'b1;
        // floatingPoint = 32'hbf451eb8;
        // #2
        // start = 1'b0;
        
		// #8 //wait 4 cycles
        // clk_en = 1'b0;
        start = 1'b1;
        clk_en = 1'b1;
        floatingPoint = 32'hbf800000;//-1
        #2
        start = 1'b0;
        #8
        clk_en = 1'b0;
        
        #2 //wait 4 cycles
        // clk_en = 1'b0;
        start = 1'b1;
        clk_en = 1'b1;
        floatingPoint = 32'h3f800000;//1
        #2
        start = 1'b0;
        #8 //wait 4 cycles


        //try another 0.5405

        // fixedPoint <= 23'b00100010100101111000110;
		// //try another 0.99
		// #4
        // fixedPoint <= 23'b00111111010111000010100;
        // //try 1
        #4
        // fixedPoint <=23'b01000000000000000000000; //dont need to worry about signed as even function
		#4
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
