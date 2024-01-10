module fp_adder # (
    parameter DWIDTH = 32;
    parameter   = ;
) (
    input clk, 
    input rest,
    input valid_in, // input databus valid
    input start,
    input [7:0] n, // for extended 
    input [31:0] dataa,
    input [31:0] datab,
    output reg done,
    output reg busy
);

    // unpacking 
    wire sign_a, sign_b,
         isNan_a, isNaN_b,
         isZero_a, isZero_b,
         isInf_a, isInf_b,
         isSubn_a, isSubn_b;

    wire [7:0] e_a, e_b;
    wire [22:0] m_a, m_b;

    unpacker ua(dataa, sign_a, e_a, m_a);
    unpacker ub(datab, sign_b, e_b, m_b);


// alignment 

// addition

// normalization

// rounding

    
endmodule


    
endmodule