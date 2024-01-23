import sys


for line in sys.stdin:
    if line == "\n" or line == "":
        continue   
    num, fracBits, sign = line.split("-")
    hexNumber = hex(int(num))[2:]
    print(f'{hexNumber}-{fracBits}-{sign}', end='')
