module fp_1dder # (
    parameter DWIDTH = 32;
    parameter   = ;
) (
    input clk, 
    input rest,
    input valid_in, // input databus valid
    input start,
    input [7:0] n, // for extended 
    input [31:0] dataa, // number 1
    input [31:0] datab, // number 2
    output reg done,
    output reg busy
);

    // unpacking 
    wire sign_1, sign_2,
         isNan_1, isNaN_2,
         isZero_1, isZero_2,
         isInf_1, isInf_2,
         isSubn_1, isSubn_2;

    wire [7:0] e_1, e_2;
    wire [22:0] m_1, m_2;

    unpacker ua(dataa, sign_1, e_1, m_1);
    unpacker ub(datab, sign_2, e_2, m_2);


// alignment 

// addition

// normalization

// rounding

    
endmodule


    
endmodule
