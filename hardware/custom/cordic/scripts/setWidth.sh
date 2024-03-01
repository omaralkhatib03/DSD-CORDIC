width=$1
const=1


sed -i "s/parameter WIDTH = .*,/parameter WIDTH = $width,/g" ./RTL/cosine.sv
cat ./RTL/cosine.sv | grep 'parameter WIDTH ='

sed -i "s/FRACTIONAL_BITS=.*/FRACTIONAL_BITS=$width/g" ./Makefile
cat ./Makefile | grep 'FRACTIONAL_BITS='

sed -i "s/parameter FRACTIONAL_BITS = .*,/parameter FRACTIONAL_BITS = $width,/g" ././RTL/unpacker.sv
cat ./RTL/unpacker.sv | grep 'parameter FRACTIONAL_BITS = '

sed -i "s/parameter WIDTH = .*;/parameter WIDTH = $width;/g" ./tb/monte_carlo_tb.sv
cat ./tb/monte_carlo_tb.sv | grep 'parameter WIDTH ='

sed -i "s/\$display(\"input:fl:%h,\", angle, \"cos-cordic:fl:%h,\", result, \"theta:fi-.*-s:%h\", theta);/\$display(\"input:fl:%h,\", angle, \"cos-cordic:fl:%h,\", result, \"theta:fi-$width-s:%h\", theta);/g" ./tb/monte_carlo_tb.sv
cat ./tb/monte_carlo_tb.sv | grep '\$display(\"input:fl:%h,\", angle, \"cos-cordic:fl:%h,\", result, \"theta:fi-.*-s:%h\", theta);'

sed -i "s/\$display(\"data:fi-.*-s:%h,\", data, \"result:fl:%h\", result);/\$display(\"data:fi-$width-s:%h,\", data, \"result:fl:%h\", result);/g" ./tb/packer_tb.sv
cat ./tb/packer_tb.sv | grep '$display(\"data:fi-.*-s:%h,\", data, \"result:fl:%h\", result);'

sed -i "s/parameter WIDTH = .*;/parameter WIDTH = $width;/g" ./tb/packer_tb.sv
cat ./tb/packer_tb.sv | grep 'parameter WIDTH ='

sed -i "s/\$display(\"data:fl:%h,\", data, \"result:fi-.*-s:%h\", result);/\$display(\"data:fl:%h,\", data, \"result:fi-$width-s:%h\", result);/g" ./tb/unpacker_tb.v
cat ./tb/unpacker_tb.v | grep '\$display(\"data:fl:%h,\", data, \"result:fi-.*-s:%h\", result);'

sed -i "s/parameter WIDTH = .*;/parameter WIDTH = $width;/g" ./tb/unpacker_tb.v
cat ./tb/unpacker_tb.v | grep 'parameter WIDTH ='

sed -i "s/parameter WIDTH = .*;/parameter WIDTH = $width;/g" ./tb/cosine_tb.v
cat ./tb/cosine_tb.v | grep 'parameter WIDTH ='


sed -i "s/\$display(\"input:fl:%h,\", angle, \"cos-cordic:fl:%h,\", result, \"theta:fi-.*-s:%h\", theta);/\$display(\"input:fl:%h,\", angle, \"cos-cordic:fl:%h,\", result, \"theta:fi-$width-s:%h\", theta);/g" ./tb/cosine_tb.v
cat ./tb/cosine_tb.v | grep '\$display(\"data:fl:%h,\", data, \"result:fi-.*-s:%h\", result);'




# sed -i "s/for (i = 5'd1; i < 6'd.*; i = i + 1) begin : gen_cordic_engines/for (i = 5'd1; i < 6'd$iterations; i = i + 1) begin : gen_cordic_engines/g" ./RTL/cosine.sv
# cat ./RTL/cosine.sv | grep ': gen_cordic_engines'
# # sed -i "s/for (i = 5'd1; i < 6'd.*; i = i + 1) begin : gen_cordic_engines/for (i = 5'd1; i < 6'd$iterations; i = i + 1) begin : gen_cordic_engines/g" ./RTL/cosine.sv
# ramAddess=$(( iterations - 1 ))
# # echo $ramAddess
#
# # packer pckr(x_s[18], result);
#
# sed -i "s/packer pckr(x\_s\[.*\], result);/packer pckr(x\_s\[$ramAddess\], result);/g" ./RTL/cosine.sv
# cat ./RTL/cosine.sv | grep 'packer pckr'
#
# sed -i "s/assign theta = w\_s\[.*\];/assign theta = w\_s\[$ramAddess\];/g" ./RTL/cosine.sv
# cat ./RTL/cosine.sv | grep 'assign theta = '
