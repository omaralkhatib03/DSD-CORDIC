angles=$1
const=1

sed -i "s/localparam \[(WIDTH+2)\*32-1\:0\] angles = .*;/localparam \[(WIDTH+2)\*32-1\:0\] angles = $angles;/g" ./RTL/cosine.sv
cat ./RTL/cosine.sv | grep 'localparam \[(WIDTH+2)\*32-1\:0\] angles = .*;'



