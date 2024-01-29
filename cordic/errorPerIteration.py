import numpy as np
import matplotlib.pyplot as plt
import sys
import subprocess as sp

def main():
    mean_errors = []
    points = []
    minimum_iterations = 32 
    error_at_minimum = 0.0
    
    target_error = 0.5 * (10 ** -6)
    found_minimum = 0
     
    for i in range(14, 32):
    
        sp.run([f'./scripts/setIterations.sh {i}'], shell=True) 
        # print(tmp) 
        
        cmdResult = sp.Popen("make iterations", shell=True, stdout=sp.PIPE)

        mean_error = 0    
        line_number = 0 
        for line in cmdResult.stdout: 
            # print(f'{line_number}: {line}')
            line_number+=1
            if line_number == 3:
                mean_error = float(line)
                mean_errors.append(float(line)) 
        
        if  abs(mean_error) < target_error and not found_minimum:
            minimum_iterations = i
            error_at_minimum = mean_error
            found_minimum = 1
             
        points.append(i)
        
    # print(mean_errors)
    print(f'Minimum Iterations: {minimum_iterations}, Error At Minimum: {error_at_minimum}')
    
    plt.plot(points, mean_errors)
    plt.xlabel('Number of Iterations')
    plt.ylabel('Mean Error (Monte Carlo)')
    plt.title('Mean Error Vs Number Of Iterations')
    plt.grid(True)
    plt.show() 

if __name__ == "__main__":
    main()
