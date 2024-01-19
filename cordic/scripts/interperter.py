import sys
import struct
import numpy as np
import fixedFracToFloatValue as fFTF

def ieee_754_conversion(n, sgn_len=1, exp_len=8, mant_len=23): # source: https://gist.github.com/AlexEshoo/d3edc53129ed010b0a5b693b88c7e0b5
    """
    Converts an arbitrary precision Floating Point number.
    Note: Since the calculations made by python inherently use floats, the accuracy is poor at high precision.
    :param n: An unsigned integer of length `sgn_len` + `exp_len` + `mant_len` to be decoded as a float
    :param sgn_len: number of sign bits
    :param exp_len: number of exponent bits
    :param mant_len: number of mantissa bits
    :return: IEEE 754 Floating Point representation of the number `n`
    """
    if n >= 2 ** (sgn_len + exp_len + mant_len):
        raise ValueError("Number n is longer than prescribed parameters allows")

    sign = (n & (2 ** sgn_len - 1) * (2 ** (exp_len + mant_len))) >> (exp_len + mant_len)
    exponent_raw = (n & ((2 ** exp_len - 1) * (2 ** mant_len))) >> mant_len
    mantissa = n & (2 ** mant_len - 1)

    sign_mult = 1
    if sign == 1:
        sign_mult = -1

    if exponent_raw == 2 ** exp_len - 1:  # Could be Inf or NaN
        if mantissa == 2 ** mant_len - 1:
            return float('nan')  # NaN

        return sign_mult * float('inf')  # Inf

    exponent = exponent_raw - (2 ** (exp_len - 1) - 1)

    if exponent_raw == 0:
        mant_mult = 0  # Gradual Underflow
    else:
        mant_mult = 1

    for b in range(mant_len - 1, -1, -1):
        if mantissa & (2 ** b):
            mant_mult += 1 / (2 ** (mant_len - b))

    return sign_mult * (2 ** exponent) * mant_mult


# def fixedLengthFracToFloat(x):
#     value = np.float128(0.0)
    
#     pos = -32 
#     while (x > 0):
#         value += (x & 0x1) * (2 ** pos);
#         x >>= 1
#         pos+=1
        
#     return value 
             

def printTest(test):
    signals = test.split(',')
    
    for signal in signals:
        name, type, value = signal.split(":")
        print(name, end=": ")
        match type:
            case 'fl':
                print(f'{ieee_754_conversion(int(value, 16))}')
            case 'fi':
                print(f'{fFTF.fixedLengthFracToFloat(int(value, 16))}')
            case _ : 
                print(f'{value}')

def main():
    rawString = ""
    
    cnt = 0 
    for line in sys.stdin:
        if 0 == cnt:
            cnt+=1
            continue
        rawString += line 
    
    tests = rawString.split('\n') 
   
    # removes the emty cell at the end of the array due to splitting on \n
    tests.pop() 
    
    for test in tests: 
        printTest(test)
        print()        


if __name__ == "__main__":
    main() 