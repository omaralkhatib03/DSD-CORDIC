iterations=$1
const=1

sed -i "s/parameter ITERATIONS = .*/parameter ITERATIONS = $iterations/g" ./RTL/cosine.sv
cat ./RTL/cosine.sv | grep 'parameter ITERATIONS = .*'