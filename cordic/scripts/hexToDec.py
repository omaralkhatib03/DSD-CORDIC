import sys

# converts hex to dec

for line in sys.stdin: 
    num, fracBits, sign = line.split('-')
    print(f'{int(num, 16)}-{fracBits}-{sign}')
