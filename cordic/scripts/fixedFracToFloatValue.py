import sys 
import numpy as np

def fixedLengthFracToFloat(x, frac_bits): # twos complement signed number
    value = np.float128(0.0)
    
    cntr = 0 
    pos = 0-frac_bits 
    while (x > 0):
        cntr+=1
        value += (-1 if cntr == 32 else 1) * (x & 0x1) * (2 ** pos)
        x >>= 1
        pos+=1
 
    return value 

def main():

    for line in sys.stdin:
        num, frac_bits = line.split("-")
        result = fixedLengthFracToFloat(int(num), int(frac_bits))
        print(result)    
    
    
    
    
if __name__ == "__main__":
    main()