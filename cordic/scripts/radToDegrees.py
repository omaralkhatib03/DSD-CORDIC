import math
import sys


for line in sys.stdin:
    num, fracBits, sign = line.split('-')
    print(math.degrees(float(num)))
