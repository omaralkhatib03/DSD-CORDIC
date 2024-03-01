import numpy as np
import random


N = 1000 # Number of iterations for the monte-carlo simulation

print(N)
for i in range(0, N):
    angle = np.float32(random.uniform(0,255))
    ieeeFormatedAngle = angle.view("int32") 
    print(f'{ieeeFormatedAngle}')

