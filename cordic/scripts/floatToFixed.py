import sys 
import numpy as np

def floatToFixed(num, fracBits):
    if 0 == num:
        return 0
    
    num = int(num.view('int32'))
    E = (num & 0x7F800000) >> 23
    mant = num & 0x0007FFFFF
    sign = (num & 0x80000000) >> 31
    
    e = - E + 127
    shift = e if E > (127 - fracBits) else fracBits 
    concated = ((0x80000000 if sign else 0x0) + 0x40000000 + ((mant << 7)))
    result = concated >> shift if shift >= 0 else concated
    return result

def main():
    fracBits = 30
    for line in sys.stdin:
        num = np.float32(line)
        result = floatToFixed(num, fracBits=fracBits)
        # print(f'a_i:{num} \t a_i_f:{r esult}')        
        print(result)
        # print(result, end=f'-{fracBits}\n')
    
    
    
if __name__ == "__main__":
    main()