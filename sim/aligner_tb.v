`timescale  1 ns / 100 ps 

module tb () ;

    reg [31:0] data_1;
    reg [31:0] data_2; 
    // we dont need a clk now;
    // reg clk;

    
    
    wire sign_1, isNaN_1, isInf_1, isZero_1, isSubn_1;
    wire sign_2, isNaN_2, isInf_2, isZero_2, isSubn_2;
    wire [7:0] e_1, e_2;
    wire [22:0] m_1, m_2;

    unpacker unp1(data_1, sign_1, e_1, m_1, isNaN_1, isInf_1, isZero_1, isSubn_1);
    unpacker unp2(data_2, sign_2, e_2, m_2, isNaN_2, isInf_2, isZero_2, isSubn_2);

    wire [7:0] e, diff;
    wire sign, new_sign_2;
    wire [26:0] aligned_guarded_m_1, aligned_guarded_m_2;

    aligner dut(e_1, e_2, 1'b0, sign_1, sign_2, m_1, m_2, 
                e, diff, sign, new_sign_2, aligned_guarded_m_1, aligned_guarded_m_2);


    initial begin
        $dumpfile("aligner.vcd");
        $dumpvars();

        data_1 = 32'h40400000; // 3
        data_2 = 32'h40000000; // 2
        #1
        data_1 = 32'h40400000; // 3
        data_2 = 32'h3f400000; // 0.75
        #1  
        data_1 = 32'h40400000; // 3
        data_2 = 32'h34c00000; // 3 * 2^-23 
        #1
        data_1 = 32'h3f800000; // 1
        data_2 = 32'hbF7FFFFF; // -(1.11...11)_2 * 2^-1 
        #1
        data_1 = 32'hz; // 3
        data_2 = 32'hz; // 3
    end

endmodule