import matplotlib
import numpy as np, scipy.stats as st
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
    confidences=[]
    with open(filename) as csvfile:
        reader = csv.DictReader(csvfile)    
        for row in reader:
            #print(type(row['error_vs_iteration']))
            fracbits=int(row['fractional_bits'])
            if fracbits != curfracbits or next(reader, None) is None:
                error_vs_fracbits.append(meanError(errors))
                numpError = np.array(errors)
                for col in numpError.transpose():
                    confidence_interval = st.t.interval(0.95, len(col)-1, loc=meanError(col), scale=st.sem(col))
                #print(confidence_interval)
                    confidences.append(confidence_interval)
                if fracbits != curfracbits:
                    fracbitArray.append(int(fracbits))
                curfracbits = fracbits
                errors.clear()
            #print(np.array(ast.literal_eval(row['error_vs_iteration'])).astype(np.float64))
            errors.append((np.array(ast.literal_eval(row['error_vs_iteration'])).astype(np.float64))
                        )
            #print(row['error_vs_iteration'].split(',')[25],row['fractional_bits'])
    return {'fracbits':fracbitArray, 'iterations':np.array(ast.literal_eval(row['num_iterations'])).astype(np.int32),'mean_error':error_vs_fracbits , 'confidence_interval':confidences}
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

def plot_heatmap(x_values, y_values, z_values, x_label, y_label, z_label, plot_label,log=False,confidences=None):
    # Plot of Value of gain with number of iterations
    fig = plt.figure()
    ax = fig.add_subplot(111)

    # Plot values with z < 0.5e-6 as crosses
    scatter = ax.scatter(x_values, y_values, c=z_values, cmap='viridis')
    if log==False:
        crosses = ax.scatter(x_values[(z_values < 0.5e-6) & (z_values > -0.5e-6)], y_values[(z_values < 0.5e-6) & (z_values > -0.5e-6)], marker='o', facecolors='none', edgecolors='black')
        ax.legend([crosses], ['-0.5e-6 < Target mean error < 0.5e-6'])
        # Plot circles on points within the confidence interval range
        targetConfidences = np.array([(float(item[0]) < 0.5e-6 and float(item[1]) > -0.5e-6 and float(item[1]) < 0.5e-6 and float(item[0]) > -0.5e-6) for item in confidences])
        targetConfidences = np.reshape(targetConfidences, [30,30])
        circle_points = ax.scatter(x_values[targetConfidences], y_values[targetConfidences],marker='x', color='red' )
        ax.legend([crosses, circle_points], ['-0.5e-6 < Sample mean error < 0.5e-6', '-0.5e-6 < Mean error with 95% confidence interval < 0.5e-6'])
    else:
        crosses = ax.scatter(x_values[z_values > 14.5], y_values[z_values > 14.5])
        ax.legend([crosses], ['Negative log mean error > 14.5'])
    ax.set_title(plot_label)
    ax.set_xlabel(x_label)
    ax.set_ylabel(y_label)

    # Add color bar
    cbar = plt.colorbar(scatter)
    cbar.set_label(z_label)
    

    plt.show()

    return
def plot_error_with_confidence(meanErrorvsIter):
    #x = meanErrorvsIter['iterations'][10:30]
    x = meanErrorvsIter['fracbits'][18:30]
    #y = meanErrorvsIter['mean_error'][20][10:30]#iterations vs mean error for fracbits = 20
    y = np.array(meanErrorvsIter['mean_error'][18:30])[:,16]#fracbits vs mean error for iterations = 15
    print(y)
    #yerr = np.array(meanErrorvsIter['confidence_interval'][610:630])[:,1]
    yerr = np.array(meanErrorvsIter['confidence_interval'])[14::15][1::2][:,1][18:30]
    print(yerr)
    #yerr = np.column_stack((yerr[:, 0], yerr[:, 2]))
    #print(yerr)
    yerr = abs(yerr - y)
    fig, ax = plt.subplots()

    ax.axhline(y=0.5e-6, color='r', linestyle='--', label='Target range')  # Horizontal line at y = 0.5e-6
    ax.axhline(y=-0.5e-6, color='r', linestyle='--')
    ax.errorbar(x, y, yerr=(yerr), fmt='o', label='Confidence interval')

    #ax.set_xlabel('Iterations')
    ax.set_xlabel('Fractional Bits')
    ax.set_ylabel('Mean Error')
    ax.set_title('Mean Error vs Fractional bits (15 iterations)')

    # Fix x-axis to show only whole numbers
    ax.xaxis.set_major_locator(plt.MaxNLocator(integer=True))

    # Render line labels
    ax.legend()

    plt.show()
    
def meanError(errorArray ,axis=0):
    errorArray = np.array(errorArray)
    return np.mean(errorArray,axis=axis)

def main(): 
    csv_file = 'C:/Users/james/Desktop/Imperial/year3/DSD/DSD-Binary-Ballet/Resultsrand6.csv'
    meanErrorvsIter=processData(csv_file)
    #
    plot_error_with_confidence(meanErrorvsIter)

    confidences = np.array(meanErrorvsIter['confidence_interval'], dtype="f,f")
    #print (confidences)
    x, y = np.meshgrid(meanErrorvsIter['iterations'], meanErrorvsIter['fracbits'])
    zs = np.array(meanErrorvsIter['mean_error'])
    #zs_log = -np.log(zs)
    #plot_heatmap(x, y, zs_log, "Iterations", "Fractional Bits", "Negative Natural logarithm of absolute Mean Error", "Fractional bits and Iteration number affect on mean error", log=True)
    print(x.shape, y.shape, zs.shape, confidences.shape)
    plot_heatmap(x, y, zs, "Iterations", "Fractional Bits", "Mean Error", "Fractional bits and Iteration number affect on mean error", confidences=confidences)
    
    #plot_scatter(meanErrorvsIter['fracbits'],meanErrorvsIter['mean_error'], "Fractional Bits", "Mean Error", "Mean Error vs Fractional Bits (25 iterations)")
    #plot_heatmap(meanErrorvsIter['fracbits'], meanErrorvsIter['iterations'], meanErrorvsIter['mean_error'], "Fractional Bits", "Iterations", "Mean Error", "Fractional bits and Iterartion number affect on mean error")
    return
if __name__ == "__main__":
    main()