import sys 
import numpy as np

def floatToFixed(num, fracBits, signed):
    if 0 == num:
        return 0

    # print(signed)
    
    num = int(num.view('int32'))
    E = (num & 0x7F800000) >> 23
    mant = num & 0x0007FFFFF
    sign = (num & 0x80000000) >> 31
    
    e = - E + 127
    shift = e if E > (127 - fracBits) else fracBits 
    sign = (0x1000000 if sign else 0x0) if signed else 0x0 
    fullMant = sign + 0x800000 + mant
    concated = fullMant << (fracBits - 23)
    result = concated >> shift if shift >= 0 else concated
    return result


def main():
    for line in sys.stdin:
        if line == "\n" or line == "":
            continue

        num, fracBits, sign = line.split('-')
        num = np.float32(num)
        result = floatToFixed(num, int(fracBits), True if sign == 's' else False)
        print(result, end=f'-{fracBits}-{sign}')
    
    
    
if __name__ == "__main__":
    main()
