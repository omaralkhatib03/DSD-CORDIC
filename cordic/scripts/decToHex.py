import sys


for line in sys.stdin:
    print(hex(int(line))[2:])