import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

steps = np.array(
    [5, 0.125, 1 / 1024],
    dtype=np.float32,
)
Ns = np.array([52, 2041, 261121], dtype=np.float32)


def generateVector(N, step):
    x = np.zeros(int(N), dtype=np.float32)
    for i in range(1, int(N)):
        x[i] = x[i - 1] + step

    return x

def sumVector(lst):
    y = np.float32(0)
    for x_i in lst:
        y += x_i + np.power(x_i, np.float32(2))
    return y

def term(x_i):
    return np.float32(0.5)*x_i + (x_i * x_i)*np.cos((x_i-np.float32(128))/np.float32(128))

def trigSum (list):
    y=np.float32(0)
    for x_i in list:
        y+=term(x_i) 
    return y

def doubleTerm(x_i):
    return 0.5*x_i + (x_i * x_i)*np.cos((x_i-128)/128)

def trigSumDouble (list):
    y=0
    for x_i in list:
        y+= doubleTerm(x_i)
    return y    


def test_cases():
    results = [ 920413.562500, 36123108.000000, 4621531648.000000]

    for i in range(0, len(steps)):
        print(f"Test {i + 1}")
        test_vector = generateVector(Ns[i], steps[i])
        y = trigSum(test_vector)
        double = trigSumDouble(test_vector)
        print(f"Step: {steps[i]}, N: {Ns[i]}, Result: {results[i]}")
        i = y.view("int32")
        print(f'IEEE 754 Format: {hex(i)}')
        print(f'Double result: {double}') 
        accuracy=(abs(y-double)/double) * 100 
        print(f'accuracy: {accuracy} %')


def main():
    # fields = ['n', 'input', 'val']
    df = pd.read_csv('data.csv')
    
    inputs = df['input']
    
    doubleTerms = []


    for i in inputs:
        doubleTerms.append(doubleTerm(i))
    
    error = doubleTerms - np.array(df['val'])
    df.insert(3, "error", error)

    # print(df)
    inputs = np.array(inputs)

    # plt.subplot(2, 1, 1)
    # sns.kdeplot(inputs, color='red', fill=True)
    # plt.title('PDF of Floating-Point Values')
    # plt.xlabel('Value')
    # plt.ylabel('Probability Density')
    
    # Mean Error
    mean_error = error.mean()
    
    # Standard deviation
    std_dev = error.std()
    
    # 95 % Confidence interval
    ci = 1.96 * std_dev / np.sqrt(len(error))
    
    print(f'Mean Error: {mean_error:.2e}, Standard Deviation: {std_dev:.2e}, 95% CI: {ci:.2e}') 
    
    
    
    # print(mean_error)
    # plt.subplot(2, 1, 2)
    # sns.kdeplot(error, color='blue', fill=True)
    # plt.axvline(x=mean_error, color='green', linestyle='--', label=f'Mean Error: {mean_error:.4f}')
    # plt.title('PDF of Error against Double Precision')
    # plt.xlabel('Error')
    # plt.ylabel('Probability Density')
    # plt.legend()
    #
    # plt.tight_layout()
    # plt.show() 


if __name__ == "__main__":
    main()











