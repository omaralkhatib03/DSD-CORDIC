import numpy as np
import matplotlib.pyplot as plt
import subprocess as sp
import math
import seaborn as sns



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
   
    target_error = 0.5 * (10 ** -6)
   
    WIDTH_START = 22
    WIDTH_END = 23
    ITERATIONS_START = 10  
    ITERATIONS_END = 18

    cnt = 0
    for width in range(WIDTH_START, WIDTH_END):

        
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
                    errors[cnt].append(error)
                    
                    margin = float(marginOfError)
                    confidences[cnt].append(margin)
                    
            iterations[cnt].append(i)





        cnt += 1        
        print(f'Error: {error}, Error + margin: {abs(error + margin)}, Error - margin: {abs(error - margin)}')
   
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
    confidences_3d = []
    
    for i in range(0, len(widths)):
        widths_3d.append([])
        for j in range(0, len(iterations[i])):
            widths_3d[i].append(widths[i])
            iterations_3d.append(iterations[i][j])
            errors_3d.append(errors[i][j])
            confidences_3d.append(confidences[i][j])
            
     
    w_np = np.array(widths_3d) # y
    i_np = np.array(iterations) # x
    er_np = np.array(errors) # z
    con_np = np.array(confidences)
    upper =  er_np + con_np    
    lower = er_np - con_np 
    

    print(f'w: {w_np.shape}, i: {i_np.shape}, er: {er_np.shape}, con: {con_np.shape}')
    print(f'wel0: w{w_np[0]}, iel: {i_np[0]}')
    print((upper < 0.5e-6) & (lower > -0.5e-6))


    meetSpec =  w_np[(upper < 0.5e-6) & (lower > -0.5e-6)], i_np[(upper < 0.5e-6) & (lower > -0.5e-6)]
    nonSpec = w_np[(upper > 0.5e-6) | (lower < -0.5e-6)], i_np[(upper > 0.5e-6) | (lower < -0.5e-6)]


 
    fig = plt.figure()
    ax = fig.add_subplot(111)
    scatter = ax.scatter(w_np, i_np, c=er_np, marker='o', cmap='winter', zorder=1)
    cons = ax.scatter(meetSpec[0], meetSpec[1],  marker='x', zorder=2)

    ax.legend([cons], ['-0.5e-6 < Sample mean error < 0.5e-6 with 95% confidence'])
    ax.set_xlabel('Fractional Bits')
    ax.set_ylabel('Number of Iterations')
    ax.set_title('Mean Error Vs Number Of Iterations Vs Fractional Bits')

    cbar = plt.colorbar(scatter)
    cbar.set_label("Mean Error")

    plt.show()
    
    

if __name__ == "__main__":
    main()
