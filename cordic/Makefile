RTL=RTL
TB=tb
INCLUDE=-I $(RTL) -I $(TB) -g2012
INTERPERTER=scripts/interperter.py
FRACTIONAL_BITS=30
SIGN=s


.PHONY: clean unpacker rom cos plot monte_carlo

cos: bin/cos mem.hex $(INTERPERTER)
	./bin/cos | python $(INTERPERTER)

plot: bin/cos mem.hex
	./bin/cos | python $(INTERPERTER) | python scripts/convergencePlotter.py

monte_carlo: bin/monte_carlo mem.hex
	python scripts/sampleCordicRandomly.py | ./bin/monte_carlo | python $(INTERPERTER) | python scripts/monteCarloSimulation.py

rom: bin/rom mem.hex $(INTERPERTER)
	./bin/rom | python $(INTERPERTER)

unpacker: bin/unpacker $(INTERPERTER)
	./bin/unpacker | python $(INTERPERTER)

bin/unpacker: $(RTL)/unpacker.sv $(TB)/unpacker_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

bin/rom: $(RTL)/rom.sv $(TB)/rom_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

bin/cos: $(RTL)/cosine.sv $(RTL)/rom.sv $(RTL)/engine.sv $(RTL)/unpacker.sv $(TB)/cosine_tb.v
	iverilog $(INCLUDE) -o $@ $^

bin/monte_carlo: $(RTL)/cosine.sv $(RTL)/rom.sv $(RTL)/engine.sv $(RTL)/unpacker.sv $(TB)/monte_carlo_tb.sv
	iverilog $(INCLUDE) -o $@ $^

bin:
	mkdir -p bin/

sim:
	mkdir -p sim/

mem.hex: scripts/computeAngles.py scripts/decToHex.py scripts/floatToFixed.py scripts/decToHex.py scripts/stripForMem.py
	echo $(FRACTIONAL_BITS)-$(SIGN) | python scripts/computeAngles.py | python scripts/floatToFixed.py | python scripts/decToHex.py | python scripts/stripForMem.py > mem.hex


clean:
	rm -rf bin/*
	rm -rf sim/*
	rm -rf mem.hex
