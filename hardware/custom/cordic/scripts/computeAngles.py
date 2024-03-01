import numpy as np
import sys

# fracBits = 31
# sign = 'u'

def main(): 
    for line in sys.stdin:
       fracBits, sign = line.split('-')

    for i in range(0, 32):
        angle = np.arctan(1/(2**i))
        printValue = '{:.9f}'.format(angle)
        print(f'{printValue}-{fracBits}-{sign}', end='')
        


if __name__ == "__main__":
    main()
