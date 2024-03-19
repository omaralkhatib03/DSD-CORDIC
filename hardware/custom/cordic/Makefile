RTL=RTL
TB=tb
INCLUDE=-I $(RTL) -I $(TB) -g2012
INTERPERTER=scripts/interperter.py
FRACTIONAL_BITS=22
SIGN=s


.PHONY: clean unpacker  cos plot monte_carlo

cos: bin/cos mem.hex $(INTERPERTER)
	./bin/cos | python $(INTERPERTER)

plot: bin/plot mem.hex
	./bin/plot | python $(INTERPERTER) | python scripts/convergencePlotter.py

monte_carlo: bin/monte_carlo mem.hex
	python scripts/sampleCordicRandomly.py | ./bin/monte_carlo | python $(INTERPERTER) | python scripts/monteCarloSimulation.py


unpacker: bin/unpacker $(INTERPERTER)
	./bin/unpacker | python $(INTERPERTER)

packer: bin/packer $(INTERPERTER)
	./bin/packer | python $(INTERPERTER)

bin/unpacker: $(RTL)/unpacker.sv $(TB)/unpacker_tb.v bin sim
	iverilog $(INCLUDE) -o $@ $^

	iverilog $(INCLUDE) -o $@ $^

bin/cos: $(RTL)/cosine.sv $(RTL)/iter.sv $(RTL)/unpacker.sv $(TB)/cosine_tb.v $(RTL)/fixed2float.sv 
	iverilog $(INCLUDE) -o $@ $^

bin/monte_carlo: $(RTL)/cosine.sv $(RTL)/iter.sv $(RTL)/unpacker.sv $(TB)/monte_carlo_tb.sv $(RTL)fixed2float.sv
	iverilog $(INCLUDE) -o $@ $^


bin/packer: $(RTL)/fixed2float.sv $(RTL)/unpacker.sv $(TB)/packer_tb.sv bin sim
	iverilog $(INCLUDE) -o $@ $^

bin/plot: $(RTL)/cosine.sv $(RTL)/iter.sv $(RTL)/unpacker.sv $(TB)/iterations_tb.v $(RTL)/fixed2float.sv
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
