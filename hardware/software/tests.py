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

def main():
    for i in range(0, len(steps)):
        print(f"Test {i + 1}")
        test_vector = generateVector(Ns[i], steps[i])
        y = sumVector(test_vector)
        # y /= 1024
        print(f"Step: {steps[i]}, N: {Ns[i]}, y: {y}")
        i = y.view("int32")
        print(f'IEEE 754 Format: {hex(i)}') 


if __name__ == "__main__":
    main()
