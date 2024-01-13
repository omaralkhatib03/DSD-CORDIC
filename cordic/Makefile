INCLUDE=-I RTL/ -I tb/

bin/aligner: RTL/aligner.v RTL/unpacker.v tb/aligner_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

bin/unpacker: RTL/unpacker.v tb/unpacker_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

bin:
	mkdir -p bin/

sim:
	mkdir -p sim/

.PHONY: clean

clean:
	rm -rf bin/*
	rm -rf sim/*