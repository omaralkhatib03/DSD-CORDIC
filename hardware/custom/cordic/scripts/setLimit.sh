limit=$1
const=1

sed -i "s/parameter LIMIT = .*,/parameter LIMIT = $limit,/g" ./RTL/cosine.sv
cat ./RTL/cosine.sv | grep 'parameter LIMIT = .*'