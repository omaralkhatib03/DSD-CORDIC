import time
import numpy as np

# Test case 1
# define step 5
# define N 52

# Test case 2
# step = 1/8.0
# N = 2041

# Test case 3
# define step 1/1024.0
# define N 261121

steps = [5, 2, 1/8.0]
Ns = [52, 2041, 261121]

def generateVector(N, step):
    i = 0
    x = [0]*N
    for i in range(0, N):
        x[i] = x[i-1] + step
    return x


def sumVector(test_vector):
    y = 0
    for x_i in test_vector:
        y += 0.5 * x_i + np.power(x_i, 2)*np.cos((x_i - 128) / 128)
    return y

def main():
    for i in range(0, len(steps)):
        print(f'Test {i + 1}')
        test_vector = generateVector(Ns[i], steps[i])
        y = sumVector(test_vector=test_vector)
        print(f'Step: {steps[i]}, N: {Ns[i]}, y: {y}')


if __name__ == '__main__':
    main()