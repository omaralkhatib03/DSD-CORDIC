import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from fixedpoint import FixedPoint
import math
import string
import struct
import csv
import random
import concurrent.futures

def processData(filename):
    curfracbits = 1
    error_vs_fracbits = []
    fracbitArray =[1]
    errors = []
    with open(filename) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            #print(type(row['error_vs_iteration']))
            fracbits=int(row['fractional_bits'])
            if fracbits != curfracbits:
                error_vs_fracbits.append(meanError(errors))
                fracbitArray.append(int(fracbits))
                curfracbits = fracbits
                errors.clear()
            errors.append(float(row['error_vs_iteration'].split(',')[25]))
            #print(row['error_vs_iteration'].split(',')[25],row['fractional_bits'])
    return {'fracbits':fracbitArray,'mean_error':error_vs_fracbits}

def meanError(errorArray):
    errorArray = np.array(errorArray)
    return np.mean(errorArray)
def main(): 
    meanErrorvsIter=processData('C:/Users/james/Desktop/Imperial/year3/DSD/DSD-Binary-Ballet/Resultsrand.csv')
    print(meanErrorvsIter)
    return
if __name__ == "__main__":
    main()
