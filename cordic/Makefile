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


mem.hex: 
	python scripts/mem.py | python scripts/floatToFixed.py > mem.hex


clean:
	rm -rf bin/*
	rm -rf sim/*
	rm -rf mem.hex