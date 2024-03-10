`timescale 1 ns / 100 ps


module tb() ;

    reg [4:0] address;
    wire [25:0] data;

    rom dut(address, data);

    integer i;
    initial begin
        $dumpfile("sim/rom.vcd");
        $dumpvars();

        for (i = 0; i < 32; i = i + 1) begin
            address = i;
            #1
            $display("address:i:%d,", address, "data:fi-24-s:%h", data);
        end
    end

endmodule


        // $display("address:i:%h,", address, "data:fi:%h", data);
