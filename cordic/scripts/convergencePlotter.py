import matplotlib.pyplot as plt 
import sys
import numpy as np
import regex_spm as rspm

alphas = [np.arctan(1/2**i) for i in range(0,32)]
w_i = []
input_angles = []
x_i = []


def main():
    cnt = 0
    writePtr = -1
    for line in sys.stdin:
        if 0 == cnt or "\n" == line:
            cnt += 1
            continue
        
        name, value = line.split(":")
        print(f'name:{name}, value:{value}')
        
        match rspm.match_in(name):
            case r'w_':
                w_i[writePtr].append(np.float32(value))
            
            case r'x_':
                x_i[writePtr].append(np.float32(value))
            
            case r'input':
               input_angles.append(np.float32(value))
               writePtr+= 1
               x_i.append([])
               w_i.append([])
            
            case _:            
                cnt+= 1
    
    print(x_i)
    for i in range(len(x_i)):
        errors = [np.cos(input_angles[i])-x_i[i][j] for j in range(1, len(x_i[i]))]
        plt.plot(errors)
        plt.xlabel("Iterations")
        plt.ylabel("Error")
        plt.title(f'Convergence plot of anlge = {input_angles[i]}')
        plt.show()
    
    
     

    
    

    
    
     
    



if __name__ == "__main__":
    main()