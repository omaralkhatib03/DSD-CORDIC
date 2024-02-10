import numpy as np

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
def trigSumDouble (list):
    y=0
    for x_i in list:
        y+= 0.5*x_i + (x_i * x_i)*np.cos((x_i-128)/128)
    return y
def main():
    for i in range(0, len(steps)):
        print(f"Test {i + 1}")
        test_vector = generateVector(Ns[i], steps[i])
        y = trigSum(test_vector)
        double = trigSumDouble(test_vector)
        print(f"Step: {steps[i]}, N: {Ns[i]}, Result: {y}")
        i = y.view("int32")
        print(f'IEEE 754 Format: {hex(i)}')
        print(f'Double result: {double}') 
        accuracy=100-(abs(y-double)*100/double) 
        print(f'accuracy: {accuracy} %')


if __name__ == "__main__":
    main()