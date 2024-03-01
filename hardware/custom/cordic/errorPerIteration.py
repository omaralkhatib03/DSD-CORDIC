import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D 
import sys
import subprocess as sp
import math
import itertools
import seaborn as sns
from matplotlib.colors import ListedColormap


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
    minimum_iterations = 32 
    minimum_width = 32
    error_at_minimum = 0.0
    confidence_at_minimum = 0.0
    stdDiv_at_minimum = 0.0
    
    target_error = 0.5 * (10 ** -6)
    # target_confidence = 0.95
    found_minimum = 0
    
    WIDTH_START = 15
    WIDTH_END = 23
    ITERATIONS_START = 11
    ITERATIONS_END = 19

    cnt = 0
    for width in range(WIDTH_START, WIDTH_END):

        # print(limit_factor)
        
        sp.run([f'./scripts/setWidth.sh {width}'], shell=True)

        widths.append(width)
        iterations.append([])
        errors.append([]) 
        confidences.append([]) 


        for i in range(ITERATIONS_START, ITERATIONS_END):
        
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
                    errors[cnt].append(abs(error))
                    
                    stdDiv = float(std)
                    margin = float(marginOfError)
                    confidences[cnt].append(margin)
                    
            iterations[cnt].append(i)

        cnt += 1        
        print(f'Error: {error}, Error + margin: {abs(error + margin)}, Error - margin: {abs(error - margin)}')
        # if error < target_error and abs(error - margin) < target_error and abs(error + margin) < target_error and not found_minimum:
            
        #     minimum_iterations = i
        #     error_at_minimum = error
        #     confidence_at_minimum = confidence
        #     stdDiv_at_minimum = stdDiv
        #     minimum_width = width
        #     found_minimum = 1

    
    for i in range(0, len(widths)):
        plt.errorbar(x=np.array(iterations[i]), y=np.array(errors[i]), yerr=confidences[i], fmt='o', capsize=5, elinewidth=1, capthick=1, markersize=5, label=f'Fractional Bits: {widths[i]}')
       

    # plt.errorbar(x=np.array(iterations), y=np.array(errors), yerr=confidences,fmt='o', color='blue', capsize=5, elinewidth=1, capthick=1, markersize=5)
    plt.legend(bbox_to_anchor=(1.1, 1.05))
    plt.axhline(y = target_error, color='b', linestyle='--', linewidth=1)
    plt.axhline(y = -target_error, color='b', linestyle='--', linewidth=1)
   
    plt.xlabel('Number of Iterations')
    plt.ylabel('Mean Error (Monte Carlo)')
    plt.title('Mean Error Vs Number Of Iterations')
    plt.grid(True)



    widths_3d = []
    iterations_3d = []
    errors_3d = []
    # confidences_3d = []
    for i in range(0, len(widths)):
        for j in range(0, len(iterations[i])):
            widths_3d.append(widths[i])
            iterations_3d.append(iterations[i][j])
            errors_3d.append(errors[i][j])
            # confidences_3d.append(confidences[i][j])
            
    cmap = ListedColormap(sns.color_palette("viridis", 256).as_hex())
 
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(widths_3d, iterations_3d, errors_3d, c=widths_3d, marker='o', cmap=cmap)
    ax.set_xlabel('Fractional Bits')
    ax.set_ylabel('Number of Iterations')
    ax.set_zlabel('Mean Error (Monte Carlo)')
    ax.set_title('Mean Error Vs Number Of Iterations Vs Fractional Bits')
    ax.legend() 


    plt.show()
    
    

if __name__ == "__main__":
    main()
