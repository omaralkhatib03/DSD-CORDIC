import sys
import numpy as np
import subprocess as sp
import math


def floatToFixed(num, fracBits, signed):
    if 0 == num:
        return 0

    
    num = int(num.view('int32'))
    E = (num & 0x7F800000) >> 23
    mant = num & 0x0007FFFFF
    sign = (num & 0x80000000) >> 31

    
    e = - E + 127
    shift = e if E > (127 - fracBits) else fracBits
     
    sign = (0x1000000 if sign else 0x0) if signed else 0x0 
    
    RshiftAmount = (fracBits - 23) if (fracBits - 23) >= 0 else 0
    LshiftAmount = (-fracBits + 23) if (-fracBits + 23) >= 0 else 0
    

    fullMant = sign + 0x800000 + mant
    
     
    concated = fullMant << RshiftAmount

    concated = concated >> LshiftAmount
    
    
    result = concated >> shift if shift >= 0 else concated
    

    return result



def limit(iterations):
    val = 1
    for i in range(0, iterations):
        val *= 1 / (math.sqrt(1 + 2 ** (-2 * i)))

    return val

for line in sys.stdin:

    width, iterations = line.split(',')
    width = int(width)
    iterations = int(iterations) 
    limit_factor = f'{width+2}\\\'h' + hex(floatToFixed(np.float32(limit(iterations)), width, True))[2:]

    # print(f'Limit Factor: {limit(iterations)}')
    sp.run([f'./scripts/setLimit.sh {limit_factor}'], shell=True)
    sp.run([f'./scripts/setWidth.sh {width}'], shell=True)
    sp.run(['make clean'], shell=True)
