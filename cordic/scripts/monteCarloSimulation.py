import numpy as np
import matplotlib.pyplot as plt
import sys
import regex_spm as rspm
import scipy.stats
import seaborn as sns

def mean_confidence_interval(data, confidence=0.95):
    a = 1.0 * data
    n = len(a)
    m, se = np.mean(a), scipy.stats.sem(a)
    h = se * scipy.stats.t.ppf((1 + confidence) / 2., n-1)
    return m, m-h, m+h 
                  
def main():
    cordic_angles = []
    theta = []
    
    cnt = 0;
    for line in sys.stdin:
        if line == "\n":
            continue       

        name, value = line.split(":")
        
        match rspm.match_in(name):
            case r'cos-cordic': 
                cordic_angles.append(np.float32(value))
                cnt += 1
                     
            case r'input':
                theta.append(np.float32(value))

            # case r'np\.cos':
            #     cosines.append(np.float32(value))
                 
            case _:
                continue 

    # print(theta)
    # print(cordic_angles)
    
    assert len(theta) == len(cordic_angles) 
    
    
    cordic_angles = np.array(cordic_angles)
    cosines = np.array([np.cos(angle) for angle in theta])
    assert len(cosines) == len(cordic_angles)
    
    error = cordic_angles - cosines
    mean_error = np.mean(error)
    stdDiv = np.std(error)
    _, lower_bound, upper_bound = mean_confidence_interval(error)
    
    confidence = np.sum([1 for i in error if (i > (mean_error - 2 * stdDiv) and (i < mean_error + 2 * stdDiv))]) / (cnt + 1)

    
    
    # for i in range(0, len(cordic_angles)):
        # print(f'cos({theta[i]}) = {cosines[i]}, np.cos = {np.cos(theta[i])}, apx = {cordic_angles[i]}, exact = {cosines[i] == cordic_angles[i]}')
    

    # print(f'N:{cnt}, Mean Error: {mean_error}, stdDiv: {stdDiv}, confidence:{confidence}')  
   
    print(f'{mean_error}, {stdDiv}, {confidence}')
   
    # sns.set(style="whitegrid")  # Set the style of the plot
    # sns.kdeplot(error, fill=True, color="skyblue")  # Kernel Density Estimation plot
    # plt.xlabel('Error')
    # plt.ylabel('Density')
    # plt.title('Distribution of Error')
    # plt.show()  
   
if __name__ == "__main__":
    main()
