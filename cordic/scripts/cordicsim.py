import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from fixedpoint import FixedPoint
import math
import string
import struct
import csv
import random
import concurrent.futures
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
    test_angle = curz
    curx = FixedPoint(1/1.646760258120067,True)
    curx.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
    #print(curx.qformat)
    cury = FixedPoint(0,True)
    cury.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
    curz = FixedPoint(curz,True)
    curz.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
    x_vals=[]
    y_vals=[]
    z_vals=[]
    num_iterations = []
    iteration_count = 0
    di = FixedPoint(0,True)
    di.resize(num_ints, num_frac)
    for i in range(0, iterations):
        if curz < 0:
            di = FixedPoint(-1,True)
            di.resize(num_ints, num_frac)
        else:
            di = FixedPoint(1,True)
            di.resize(num_ints, num_frac)
        tan_alpha = FixedPoint(2**(-i),True)
        tan_alpha.resize(num_ints, num_frac,alert='warning', overflow='wrap')
        curx.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
        cury.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
        x_next = curx - di*cury*tan_alpha
        y_next = cury + di*curx*tan_alpha
        x_next.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
        y_next.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
        tan_term = FixedPoint(math.atan(2**(-i)),True)
        tan_term.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
        curz.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
        z_next = curz - di*tan_term
        z_next.resize(num_ints, num_frac,alert='ignore', overflow='wrap')
        curx = x_next
        cury = y_next
        curz = z_next
        x_vals.append(curx)
        y_vals.append(cury)
        z_vals.append(curz)
        num_iterations.append(iteration_count)
        iteration_count += 1
    cordres=np.array(x_vals).astype(np.float64)
    actual = math.cos(test_angle)
    errors=[]
    for j in range (0, len(cordres)):
        errors.append(abs_error(cordres[j], actual))
    return {'x': cordres, 'num_iterations': num_iterations, 'fractional_bits': num_frac, 'angle': test_angle, 'actual_cos': actual , 'error_vs_iteration': errors}

def abs_error(cordic_value, cosine_value):
    return abs((cordic_value - cosine_value)/cosine_value)*100

def generate_angles(num_angles):
    angles = []
    for i in range(0,num_angles):
        angles.append(np.float64(random.uniform(-1,1)))
    return angles

def double_cosine_values(angles):
    return np.cos(angles)

def mean_error(cosine_values, cordic_values):
    error = 0
    for i in range(0, len(cosine_values)):
        error += abs(cosine_values[i] - cordic_values[i])
    return error/len(cosine_values)

def main(): 
    max_iterations = 50
    fraction_bits = range(1, 31)
    angles=generate_angles(10000)
    cosine_values=double_cosine_values(angles)
    results=[]
    for fraction_bit in fraction_bits:
        for angle in angles:
            #print("Fraction Bits: ", fraction_bit, "Angle: ", angle)
            angle_results=rotation_mode(angle,max_iterations,2,fraction_bit)
            results.append(angle_results)
            #print("Iterations: ", angle_results['num_iterations'],"Fraction Bits: ", fraction_bit, "Angle: ", angle, "Error: ", "Result: ", angle_results['x'], "Cosine: ", cosine_values[k])
    #num_iterations, scale_factors = scale_factor(max_iterations)
    #plot(results['num_iterations'], results['x'], "Number of Iterations", "cos(0)", "cos(0) vs Number of Iterations")

    with open('Resultsrand.csv', 'w+') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=results[0].keys())
        writer.writeheader()
        writer.writerows(results)
    return

if __name__ == "__main__":
    main()





