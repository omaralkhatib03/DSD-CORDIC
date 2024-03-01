import numpy as np
import sys

# fracBits = 31
# sign = 'u'

def cordicAngles(fracBits, sign):
    values = []
    for i in range(0, 32):
        angle = np.arctan(1/(2**i))

        printValue = '{:.9f}'.format(angle)
    
        values.append(printValue)

    return values

def main(): 
    for line in sys.stdin:
       fracBits, sign = line.split('-')

    values = cordicAngles(fracBits, sign)     
    
    for value in values:
        print(f'{value}-{fracBits}-{sign}', end='')

if __name__ == "__main__":
    main()
