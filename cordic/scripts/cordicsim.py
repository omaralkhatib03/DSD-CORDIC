import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from fixedpoint import FixedPoint
import math
import string
import struct

#from __future__ import division

def plot(x_values, y_values, x_label, y_label, plot_label):
    # Plot of Value of gain with number of iterations
    fig = plt.figure()
    ax = fig.add_subplot(111)

    line, = ax.plot(x_values, y_values,  lw=2)

    ax.set_title(plot_label)
    ax.set_xlabel(x_label)
    ax.set_ylabel(y_label)
    plt.show()

    return

#Scale factor K
def scale_factor(max_iterations):
    scale_factors = [math.sqrt(2)]
    num_iterations = [0]
    for i in range(1, max_iterations):
        scale_factors.append(scale_factors[i-1] * math.sqrt(1 + 2**(-2*i)))
        num_iterations.append(i)
    plot(num_iterations, scale_factors, "Number of Iterations", "Scale Factor", "Scale Factor vs Number of Iterations")
    return num_iterations, scale_factors

def rotation_mode(curz,iterations,num_ints, num_frac): 
    curx = FixedPoint(1/1.646760258120067).resize(num_ints, num_frac,rounding="")
    cury = FixedPoint(0).resize(num_ints, num_frac)
    x_vals=[]
    y_vals=[]
    z_vals=[]
    num_iterations = []
    iteration_count = 0
    di = FixedPoint(0).resize(num_ints, num_frac)
    for i in range(0, iterations):
        if curz < 0:
            di = FixedPoint(-1).resize(num_ints, num_frac)
        else:
            di = FixedPoint(1).resize(num_ints, num_frac)
        x_next = curx - di*cury*FixedPoint(2**(-i)).resize(num_ints, num_frac)
        y_next = cury + di*curx*FixedPoint(2**(-i)).resize(num_ints, num_frac)
        tan_term = math.atan(2**(-i))
        z_next = curz - di*FixedPoint(tan_term).resize(num_ints, num_frac)
        curx = x_next
        cury = y_next
        curz = z_next
        x_vals.append(curx)
        y_vals.append(cury)
        z_vals.append(curz)
        num_iterations.append(iteration_count)
        iteration_count += 1
    return {'x': x_vals, 'y': y_vals, 'z': z_vals, 'num_iterations': num_iterations}

def main(): 
    max_iterations = 20
    #num_iterations, scale_factors = scale_factor(max_iterations)
    results=rotation_mode(-1,max_iterations,32,32)
    plot(results['num_iterations'], results['x'], "Number of Iterations", "cos(0)", "cos(0) vs Number of Iterations")
    return

if __name__ == "__main__":
    main()





