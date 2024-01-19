import sys 
import numpy as np

def fixedLengthFracToFloat(x):
    value = np.float128(0.0)
    
    pos = -32 
    while (x > 0):
        value += (x & 0x1) * (2 ** pos);
        x >>= 1
        pos+=1
 
    return value 

def main():

    for line in sys.stdin:
        num = int(line)
        result = fixedLengthFracToFloat(num)
        print(result)    
    
    
    
    
if __name__ == "__main__":
    main()