import sys
import numpy as np
import seaborn as sns
import pandas as pd
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

def trigSum (list):
    y=np.float32(0)
    for x_i in list:
        y+= np.float32(0.5)*x_i + (x_i * x_i)*np.cos((x_i-np.float32(128))/np.float32(128))
    return y
def errorSum (list):
    y=np.float32(0)
    for x_i in list:
        if np.cos((x_i-np.float32(128))/np.float32(128))>0:
            y+= np.float32(0.5)*x_i + (x_i * x_i)*(np.cos((x_i-np.float32(128))/np.float32(128))+0.5*10**-6)
        else:
            y+= np.float32(0.5)*x_i + (x_i * x_i)*(np.cos((x_i-np.float32(128))/np.float32(128))-0.5*10**-6)
    return y
def trigSumDouble (list):
    y=0
    for x_i in list:
        y+= 0.5*x_i + (x_i * x_i)*np.cos((x_i-128)/128)
    return y

def testfx(x_i):
    print('half x ',np.float32(0.5)*x_i)
    print('x^2 ',x_i * x_i)
    print('cos ',np.cos((x_i-np.float32(128))/np.float32(128)))
    print('x - 128 ',x_i-np.float32(128))
    print ('x-128/128 ', (x_i-np.float32(128))/np.float32(128))
    print('x^2 * cos ',(x_i * x_i)*np.cos((x_i-np.float32(128))/np.float32(128)))
    return np.float32(0.5)*x_i + (x_i * x_i)*np.cos((x_i-np.float32(128))/np.float32(128))

def doubleTerm(x_i):
    return np.cos(x_i)
# def main():

    # results = [ 920413.562500, 36123108.000000, 4621531648.000000]

    # for i in range(0, len(steps)):
    #     print(f"Test {i + 1}")
    #     test_vector = generateVector(Ns[i], steps[i])
    #     y = errorSum(test_vector)
    #     double = trigSumDouble(test_vector)
    #     print(f"Step: {steps[i]}, N: {Ns[i]}, Result: {y}")
    #     #i = y.view("int32")
    #     print(f'IEEE 754 Format: {hex(i)}')
    #     print(f'Double result: {double}') 
    #     accuracy=(abs(y-double)/double) * 100 
    #     print(f'accuracy: {accuracy} %')
def main():
    # fields = ['n', 'input', 'val']
    df = pd.read_csv('C:/Users/james/Desktop/Imperial/year3/DSD/DSD-Binary-Ballet/hardware/software/cosTest.csv')
    
    inputs = df['input']
    
    doubleTerms = []


    for i in inputs:
        doubleTerms.append(doubleTerm(i))
    
    error = doubleTerms - np.array(df['val'])
    df.insert(3, "error", error)

    print(df)
    inputs = np.array(inputs)

    plt.subplot(2, 1, 1)
    sns.kdeplot(inputs, color='red', fill=True)
    plt.title('PDF of Floating-Point Values')
    plt.xlabel('Value')
    plt.ylabel('Probability Density')
    
    mean_error = error.mean()
    print(mean_error)
    plt.subplot(2, 1, 2)
    sns.kdeplot(error, color='blue', fill=True)
    plt.axvline(x=mean_error, color='green', linestyle='--', label=f'Mean Error: {mean_error:.0e}')
    plt.title('PDF of Error against Double Precision')
    plt.xlabel('Error')
    plt.ylabel('Probability Density')
    plt.legend()

    plt.tight_layout()
    plt.show() 


if __name__ == "__main__":
    main()
