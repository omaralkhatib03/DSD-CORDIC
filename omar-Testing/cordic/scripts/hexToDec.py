import sys

# converts hex to dec

for line in sys.stdin: 
    if line == "\n" or line == "":
        continue
    num, fracBits, sign = line.split('-')
    print(f'{int(num, 16)}-{fracBits}-{sign}')
