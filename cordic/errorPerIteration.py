import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D 
import sys
import subprocess as sp
import math
import itertools


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


def main():
    errors = []
    confidences = []
    iterations = []
    widths = []
    plotMap = []
    minimum_iterations = 32 
    minimum_width = 32
    error_at_minimum = 0.0
    confidence_at_minimum = 0.0
    stdDiv_at_minimum = 0.0
    
    target_error = 0.5 * (10 ** -6)
    target_confidence = 0.95
    found_minimum = 0
    

    error_cnt = 0
    for width in range(22, 23):

        # print(limit_factor)
        
        sp.run([f'./scripts/setWidth.sh {width}'], shell=True)

        widths.append(width)
        iterations.append([])
        
        for i in range(10, 26):
        
            limit_factor = f'{width+2}\\\'h' + hex(floatToFixed(np.float32(limit(i)), width, True))[2:]
            sp.run([f'./scripts/setLimit.sh {limit_factor}'], shell=True)
            sp.run([f'./scripts/setIterations.sh {i}'], shell=True) 
            sp.run(['make clean'], shell=True)
            cmdResult = sp.Popen("make monte_carlo", shell=True, stdout=sp.PIPE)


            error = 1000
            margin = 0
            confidence = 0
            stdDiv = 0
            line_number = np.longlong(0) 
            for line in cmdResult.stdout: 
                # print(line)
                line_number += 1
                if line_number == 4:
                    string_line = str(line)
                    string_line = string_line[2:-3]
                    # print(string_line)
                    print(f'line: {line}')
                    mean, std, marginOfError = string_line.split(',') 
                    error = float(mean)
                    errors.append(abs(error))
                    
                    stdDiv = float(std)
                    margin = float(marginOfError)
                    confidences.append(margin)
                    
            iterations[error_cnt].append(i)

        error_cnt += 1        
        print(f'Error: {error}, Error + margin: {abs(error + margin)}, Error - margin: {abs(error - margin)}')
        if error < target_error and abs(error - margin) < target_error and abs(error + margin) < target_error and not found_minimum:
            
            minimum_iterations = i
            error_at_minimum = error
            confidence_at_minimum = confidence
            stdDiv_at_minimum = stdDiv
            minimum_width = width
            found_minimum = 1

    # print(errors)
    print(f'Minimum Iterations: {minimum_iterations}, Minimum Width: {minimum_width}, Error At Minimum: {error_at_minimum}, Confidence At Minimum: {confidence_at_minimum}, Standard Deviation at Minimum: {stdDiv_at_minimum}')
    x_iter = list(itertools.chain.from_iterable(iterations))
    # y_err = list(itertools.chain.from_iterable(errors))
    plt.errorbar(x=np.array(x_iter), y=np.array(errors), yerr=confidences,fmt='o', color='blue', ecolor='red', capsize=5, elinewidth=1, capthick=1, markersize=5)
    plt.axhline(y = target_error, color='b', linestyle='--', linewidth=1)
    plt.axhline(y = -target_error, color='b', linestyle='--', linewidth=1)
    # plt.axhline(y = error_at_minimum - stdDiv, color='r', linestyle='--', linewidth=1)
    # plt.axvline(x = minimum_iterations, color='g', linestyle='--', linewidth=1)
    
    plt.xlabel('Number of Iterations')
    plt.ylabel('Mean Error (Monte Carlo)')
    plt.title('Mean Error Vs Number Of Iterations')
    plt.grid(True)


    # # Convert lists to numpy arrays
    # # iterations = np.array(iterations)
    # # errors = np.array(errors)
    # # widths = np.array(widths)
    
    # X = [] 
    # for i in range(0, len(iterations)):    
    #     for _ in iterations[i]:
    #         X.append(widths[i])

    # Y = list(itertools.chain.from_iterable(iterations))
    
    # X = np.array(X)
    # Y = np.array(Y)
    # Z = np.array(errors)
    
    # print(f'X: {X}')

    
    # # Create 3D plot
    # fig = plt.figure()
    # ax = fig.add_subplot(111, projection='3d')

    # # Plot surface
    # # ax.scatter(X, Y, Z, cmap='viridis')
    # ax.scatter(X, Y, Z)

    # # Set labels and title
    # ax.set_xlabel('Iterations')
    # ax.set_ylabel('Widths')
    # ax.set_zlabel('Errors')
    # ax.set_title('3D Surface Plot of Errors, Iterations, and Widths')

    
    plt.show()
    
    print('debug') 
    

if __name__ == "__main__":
    main()
