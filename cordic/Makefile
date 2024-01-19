INCLUDE=-I RTL/ -I tb/


.PHONY: clean unpacker rom

rom: bin/rom mem.hex scripts/interperter.py
	./bin/rom | python scripts/interperter.py

unpacker: bin/unpacker scripts/interperter.py
	./bin/unpacker | python scripts/interperter.py

bin/unpacker: RTL/unpacker.sv tb/unpacker_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

bin/rom: RTL/rom.sv tb/rom_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

bin:
	mkdir -p bin/

sim:
	mkdir -p sim/

mem.hex: scripts/computeAngles.py scripts/decToHex.py
	python scripts/computeAngles.py | python scripts/floatToFixed.py | python scripts/decToHex.py > mem.hex


clean:
	rm -rf bin/*
	rm -rf sim/*
	rm -rf mem.hex