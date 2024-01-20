val=$1
echo $val | python scripts/hexToDec.py | python scripts/fixedFracToFloatValue.py | python scripts/radToDegrees.py 