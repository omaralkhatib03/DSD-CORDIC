

bin/aligner: aligner.v unpacker.v aligner_tb.v
	iverilog -o $@ $^

bin/unpacker: unpacker.v unpacker_tb.v
	iverilog -o $@ $^


.PHONY: clean


clean:
	rm -rf bin/*
