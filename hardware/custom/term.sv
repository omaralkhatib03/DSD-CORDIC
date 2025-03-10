`timescale 100ps / 100ps

module term (
  input clk, 
  input clk_en, 
  input reset, 
  input [31:0] x,
  output [31:0] result
);
  

/// --------------------------------------------------------------------- ///
/// -------------------------    MIDDLE LANE    ------------------------- ///
/// --------------------------------------------------------------------- ///

  
  reg [31:0] x_2_delay_line [2:0];
  wire [31:0] x_2_s;
    
  fp_mult fp_mul_sqr (
    .clk    (clk),    //    clk.clk
    .areset (reset), // areset.reset
    .en     (clk_en),     //     en.en
    .a      (x),      //      a.a
    .b      (x),      //      b.b
    .q      (x_2_delay_line[0])       //      q.q
  );
  

  genvar j;

  generate
    for (j = 0; j < ($bits(x_2_delay_line) / 32) - 1 ; j = j + 1) begin : x_2_delay_line_gen
      always_ff @(posedge clk)
        x_2_delay_line[j+1] <= x_2_delay_line[j];
    end
  endgenerate
 


/// --------------------------------------------------------------------- ///
/// -------------------------    TOP LANE    ---------------------------- ///
/// --------------------------------------------------------------------- ///

  wire [31:0] cos_angle;
  cosine cordic_cos (
     .clk(clk), 
     .reset(reset),
     .clk_en(clk_en),
     .angle(x),
     .result(cos_angle)
  );

/// --------------------------------------------------------------------- ///
/// ---------------------    BOTTOM LANE    ----------------------------- ///
/// --------------------------------------------------------------------- ///


  reg [31:0] half_x_delay_line [6:0];
  wire [31:0] half_x_s;

  fp_mult half_x (
    .clk    (clk),    //    clk.clk
    .areset (reset), // areset.reset
    .en     (clk_en),     //     en.en
    .a      (x),      //      a.a
    .b      (32'h3f000000),      //      b.b
    .q      (half_x_delay_line[0])
  );



  generate
    for (j = 0; j < ($bits(half_x_delay_line) / 32) - 1 ; j = j + 1) begin : x_half_delay_line_gen
      always_ff @(posedge clk)
        half_x_delay_line[j+1] <= half_x_delay_line[j];
    end
  endgenerate
 

/// --------------------------------------------------------------------- ///
/// ----------------------    COMBINE LANES    -------------------------- ///
/// --------------------------------------------------------------------- ///
  
  wire [31:0] x_2_cos;

  fp_mult combine_top_mid (
    .clk    (clk),    //    clk.clk
    .areset (reset), // areset.reset
    .en     (clk_en),     //     en.en
    .a      (cos_angle),      //      a.a
    .b      (x_2_delay_line[($bits(x_2_delay_line) / 32) - 1]),      //      b.b
    .q      (x_2_cos)
  );

  
  fp_add final_adder (
    .clk    (clk),    //    clk.clk
    .areset (reset), // areset.reset
    .en     (clk_en),     //     en.en
    .a      (x_2_cos),      //      a.a
    .b      (half_x_delay_line[($bits(half_x_delay_line) / 32) - 1]),      //      b.b
    .q      (result)
  );

  

endmodule
