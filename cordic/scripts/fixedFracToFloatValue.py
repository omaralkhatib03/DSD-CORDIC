import sys 
import numpy as np

def fixedLengthFracToFloat(x, frac_bits, signed): # twos complement signed number
    value = np.float128(0.0)
     
    cnt = 0
    sign = 1
    pos = 0-frac_bits 
    while (x > 0):
        if signed and cnt == frac_bits + 1:
            sign = -1
        value += sign * (x & 0x1) * (2 ** pos)
        x >>= 1
        pos+=1
        cnt += 1
    
    return value 

def main():
    for line in sys.stdin:
        if line == "\n" or line == "":
            continue   
        num, frac_bits, sign = line.split("-")
        result = fixedLengthFracToFloat(int(num), int(frac_bits), (True if sign == 's' else False))
        print(result)    
    
     
if __name__ == "__main__":
    main()
