iterations=$1
const=1

sed -i "s/for (i = 5'd1; i < 6'd.*; i = i + 1) begin : gen_cordic_engines/for (i = 5'd1; i < 6'd$iterations; i = i + 1) begin : gen_cordic_engines/g" ./RTL/cosine_iterator.sv
cat ./RTL/cosine_iterator.sv | grep ': gen_cordic_engines'
# sed -i "s/for (i = 5'd1; i < 6'd.*; i = i + 1) begin : gen_cordic_engines/for (i = 5'd1; i < 6'd$iterations; i = i + 1) begin : gen_cordic_engines/g" ./RTL/cosine.sv
ramAddess=$(( iterations - 1 ))
# echo $ramAddess
sed -i "s/assign result = x\_s\[.*\];/assign result = x\_s\[$ramAddess\];/g" ./RTL/cosine_iterator.sv
cat ./RTL/cosine_iterator.sv | grep 'assign result = '

sed -i "s/assign theta = w\_s\[.*\];/assign theta = w\_s\[$ramAddess\];/g" ./RTL/cosine_iterator.sv
cat ./RTL/cosine_iterator.sv | grep 'assign theta = '
