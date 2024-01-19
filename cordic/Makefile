INCLUDE=-I RTL/ -I tb/


.PHONY: clean unpacker

unpacker: bin/unpacker interperter/main.py
	./bin/unpacker | python interperter/main.py

bin/unpacker: RTL/unpacker.sv tb/unpacker_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

bin:
	mkdir -p bin/

sim:
	mkdir -p sim/


clean:
	rm -rf bin/*
	rm -rf sim/*