value=$1
echo $value | python scripts/floatToFixed.py | python scripts/fixedFracToFloatValue.py