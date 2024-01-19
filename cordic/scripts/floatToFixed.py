import sys 
import numpy as np

def floatToFixed(num):
    num = int(num.view('int32'))
    E = (num & 0x7F800000) >> 23
    mant = num & 0x0007FFFFF
    sign = (num & 0x80000000) >> 31
    
    e = - E + 127
    shift = e if E > 95 else 32 
    result = (0x80000000 + (mant << 8)) >> (shift - 1)
    return result

def main():

    for line in sys.stdin:
        num = np.float32(line)
        result = floatToFixed(-num)
        # print(f'a_i:{num} \t a_i_f:{result}')        
        print(result)    
    
    
    
    
if __name__ == "__main__":
    main()