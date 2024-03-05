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
import ast
from matplotlib import cm
from matplotlib.ticker import LinearLocator

def processData(filename):
    curfracbits = 1
    error_vs_fracbits = []
    fracbitArray =[1]
    errors = []
    with open(filename) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            #print(type(row['error_vs_iteration']))
            fracbits=int(row['fractional_bits'])
            if fracbits != curfracbits or next(reader, None) is None:
                error_vs_fracbits.append(meanError(errors))
                if fracbits != curfracbits:
                    fracbitArray.append(int(fracbits))
                curfracbits = fracbits
                errors.clear()
            #print(np.array(ast.literal_eval(row['error_vs_iteration'])).astype(np.float64))
            errors.append((np.array(ast.literal_eval(row['error_vs_iteration'])).astype(np.float64))
                          )
            #print(row['error_vs_iteration'].split(',')[25],row['fractional_bits'])
    return {'fracbits':fracbitArray, 'iterations':np.array(ast.literal_eval(row['num_iterations'])).astype(np.int32),'mean_error':error_vs_fracbits}
def plot_scatter(x_values, y_values, x_label, y_label, plot_label):
    # Plot of Value of gain with number of iterations
    fig = plt.figure()
    ax = fig.add_subplot(111)

    line = ax.scatter(x_values, y_values)

    ax.set_title(plot_label)
    ax.set_xlabel(x_label)
    ax.set_ylabel(y_label)
    plt.show()

    return

def plot_heatmap(x_values, y_values, z_values, x_label, y_label, z_label, plot_label,log=False):
    # Plot of Value of gain with number of iterations
    fig = plt.figure()
    ax = fig.add_subplot(111)

    # Plot values with z < 0.5e-6 as crosses
    scatter = ax.scatter(x_values, y_values, c=z_values, cmap='viridis')
    if log==False:
        crosses = ax.scatter(x_values[z_values < 0.5e-6], y_values[z_values < 0.5e-6], marker='x', color='red')
        ax.legend([crosses], ['Target mean error < 0.5e-6'])
    else:
        crosses = ax.scatter(x_values[z_values > 14.5], y_values[z_values > 14.5], marker='x', color='red')
        ax.legend([crosses], ['Negative log mean error > 14.5'])
    ax.set_title(plot_label)
    ax.set_xlabel(x_label)
    ax.set_ylabel(y_label)

    # Add color bar
    cbar = plt.colorbar(scatter)
    cbar.set_label(z_label)
    

    plt.show()

    return

def meanError(errorArray ,axis=0):
    errorArray = np.array(errorArray)
    return np.mean(errorArray,axis=axis)
def main(): 
    csv_file = 'C:/Users/james/Desktop/Imperial/year3/DSD/DSD-Binary-Ballet/Resultsrand4.csv'
    meanErrorvsIter=processData(csv_file)
    #print(meanErrorvsIter)
    x, y = np.meshgrid(meanErrorvsIter['iterations'], meanErrorvsIter['fracbits'])
    zs = np.array(meanErrorvsIter['mean_error'])
    zs_log = -np.log(zs)
    plot_heatmap(x, y, zs_log, "Iterations", "Fractional Bits", "Negative Natural logarithm of absolute Mean Error", "Fractional bits and Iteration number affect on mean error", log=True)
    plot_heatmap(x, y, zs, "Iterations", "Fractional Bits", "Absolute Mean Error", "Fractional bits and Iteration number affect on mean error")
    #plot_scatter(meanErrorvsIter['fracbits'],meanErrorvsIter['mean_error'], "Fractional Bits", "Mean Error", "Mean Error vs Fractional Bits (25 iterations)")
    #plot_heatmap(meanErrorvsIter['fracbits'], meanErrorvsIter['iterations'], meanErrorvsIter['mean_error'], "Fractional Bits", "Iterations", "Mean Error", "Fractional bits and Iterartion number affect on mean error")
    return
if __name__ == "__main__":
    main()
