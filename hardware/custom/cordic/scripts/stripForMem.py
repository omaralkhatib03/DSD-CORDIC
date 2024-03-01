import sys

for line in sys.stdin:
    num, fracBits, sign = line.split('-')
    print(num)
