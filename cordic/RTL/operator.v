module operator (
    input [26:0] m_1, m_2,
    input [26:0] aligned_guarded_m_1, aligned_guarded_m_2,
    input sign_in, new_sign_2, isZero_1, isZero_2, op, isNaN_1, isInf_1, isNaN_2, isInf_2,
    input [7:0] diff,
    output [27:0] m,
    output sign_out // the sign of the result after the operation 
);


    wire isSUB; // TODO: implement is sub, i.e figure out if we are subtracting or adding the two numbers
    wire [27:0] add_1_2 = aligned_guarded_m_1 + aligned_guarded_m_2;
    wire [27:0] sub_1_2 = aligned_guarded_m_1 - aligned_guarded_m_2;
    wire [27:0] result = isSUB ? sub_1_2 : add_1_2;
    wire [27:0] alt_result = {2'b01, m_2, 3'b000} - {2'b01, m_1, 3'b000};

    assign m = isZero_1 ? {2'b01, m_2, 3'b000} : 
               isZero_2 ? {2'b01, m_1, 3'b000} :
               isSUB & (diff == 8'h0) & ~alt_result[27] ? alt_result :
               result; 

    // TODO: implement special operation flags
    // assign sign_out = ; // TODO: implement sign output after operation

endmodule