INCLUDE=-I RTL/ -I tb/

bin/aligner: RTL/aligner.v RTL/unpacker.v tb/aligner_tb.v
	iverilog $(INCLUDE) -o $@ $^

bin/unpacker: RTL/unpacker.v tb/unpacker_tb.v
	iverilog $(INCLUDE) -o $@ $^

.PHONY: clean

clean:
	rm -rf bin/*
	rm -rf sim/*