import sys


for line in sys.stdin:
    num, fracBits, sign = line.split("-")
    hexNumber = hex(int(num))[2:]
    print(f'{hexNumber}-{fracBits}-{sign}', end='')
