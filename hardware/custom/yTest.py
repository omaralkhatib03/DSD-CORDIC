import numpy as np


x = 255
y = 0.5 * x + (x**2) * np.cos( (x - 128) / 128)
hy = np.float32(y).view('int32')
print(f'result: {y}, ieee: {hex(hy)}')
