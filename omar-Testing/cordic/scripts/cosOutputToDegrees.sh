val=$1
echo $val | python scripts/fixedFracToFloatValue.py | python scripts/radToDegrees.py 