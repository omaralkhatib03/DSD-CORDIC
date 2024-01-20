module rom (
    input [4:0] address,
    output [31:0] q
);

    logic [31:0] rom_array [0:31];

    initial begin
        $readmemh("mem.hex", rom_array); 
        // $display("reading mem.hex");
    end

    assign q = rom_array[address];

endmodule