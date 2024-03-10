import numpy as np
import matplotlib.pyplot as plt
import sys
import subprocess as sp

def main():
    errors = []
    confidences = []
    points = []
    minimum_iterations = 32 
    error_at_minimum = 0.0
    confidence_at_minimum = 0.0
    stdDiv_at_minimum = 0.0
    
    target_error = 0.5 * (10 ** -6)
    target_confidence = 0.95
    found_minimum = 0
     
    for i in range(10, 25):
    
        sp.run([f'./scripts/setIterations.sh {i}'], shell=True) 
        
        cmdResult = sp.Popen("make iterations", shell=True, stdout=sp.PIPE)


        error = 1000
        margin = 0
        confidence = 0
        stdDiv = 0
        line_number = 0 
        for line in cmdResult.stdout: 
            line_number+=1
            if line_number == 3:
                string_line = str(line)
                string_line = string_line[2:-3]
                # print(string_line)
                mean, std, marginOfError = string_line.split(',') 
                
                error = float(mean)
                errors.append(abs(error))
                
                stdDiv = float(std)
                margin = float(marginOfError)
                confidences.append(margin)
                
        points.append(i)
        
        # if error < target_error and  and not found_minimum:
            # minimum_iterations = i
            # error_at_minimum = error
            # confidence_at_minimum = confidence
            # stdDiv_at_minimum = stdDiv
            
            # found_minimum = 1

    # print(errors)
    # print(f'Minimum Iterations: {minimum_iterations}, Error At Minimum: {error_at_minimum}, Confidence At Minimum: {confidence_at_minimum}, Standard Deviation at Minimum: {stdDiv_at_minimum}')

    plt.errorbar(x=points, y=errors, yerr=confidences,fmt='o', color='blue', ecolor='red', capsize=5, elinewidth=1, capthick=1, markersize=5)
    plt.axhline(y = target_error, color='b', linestyle='--', linewidth=1)
    plt.axhline(y = -target_error, color='b', linestyle='--', linewidth=1)
    # plt.axhline(y = error_at_minimum - stdDiv, color='r', linestyle='--', linewidth=1)
    # plt.axvline(x = minimum_iterations, color='g', linestyle='--', linewidth=1)
    
    plt.xlabel('Number of Iterations')
    plt.ylabel('Mean Error (Monte Carlo)')
    plt.title('Mean Error Vs Number Of Iterations')
    plt.grid(True)
    plt.show() 

if __name__ == "__main__":
    main()
