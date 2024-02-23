import math

val = 1
for i in range(0, 32):
    val *= 1 / (math.sqrt(1 + 2 ** (-2 * i)))

print(val)
