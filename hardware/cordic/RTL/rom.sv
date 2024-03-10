module rom (
    input [4:0] address,
    output [25:0] q
);

    logic [25:0] rom_array [0:31];

    initial begin
        $readmemh("mem.hex", rom_array); 
        // $display("reading mem.hex");
    end

    assign q = rom_array[address];

endmodule
