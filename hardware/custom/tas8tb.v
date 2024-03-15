`timescale 100 ps / 100 ps
module task8_tb();
    reg [31:0] x , sum;
    reg clk,clk_en,reset,start;
    wire [31:0] new_sum;
    wire  done;

    task_8 task8(
        .x(x),
        .sum(sum),
        .clk(clk),
        .reset(reset),
        .clk_en(clk_en),
        .start(start),
        .done(done),
        .new_sum(new_sum)
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
    start = 1'b0;
    #2
    //clk_en = 1'b1;
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
    //x = 32'h00000000;//0
    x = 32'h43480000;
    sum = 32'h470490fb;//33936.98046875 
    #2
    start = 1'b0;
    #32 //wait 10 cycles
    //clk_en = 1'b0;
    
    //#2 //wait 1 cycle
    // clk_en = 1'b0;
    start = 1'b1;
    //clk_en = 1'b1;
    x = 32'h43800000;//1
    #2
    start = 1'b0;
    #26//wait 4 cycles
    clk_en = 1'b0;


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