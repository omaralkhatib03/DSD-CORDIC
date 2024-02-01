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
     
    for i in range(10, 33):
    
        sp.run([f'./scripts/setIterations.sh {i}'], shell=True) 

        tmp = [] 
        for _ in range(0, 5): 
            cmdResult = sp.Popen("make iterations", shell=True, stdout=sp.PIPE)

            mean_error = 0    
            line_number = 0 
            for line in cmdResult.stdout: 
                line_number+=1
                if line_number == 3:
                  tmp.append(abs(float(line))) 
            
        points.append(i)

        snd_avg = np.mean(np.array(tmp))
        mean_errors.append(abs(snd_avg))
        
        
        if abs(snd_avg) < target_error and not found_minimum:
            minimum_iterations = i
            error_at_minimum = snd_avg
            found_minimum = 1
        
        tmp = []


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
