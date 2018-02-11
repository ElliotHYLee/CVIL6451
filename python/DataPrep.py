import numpy as np
import pandas as pd

def readData():
    fName = 'MyMatrix.txt'
    data = pd.read_csv(fName, sep="\t", header=None)
    data = data.as_matrix()
    return data

if __name__ == '__main__':
    readData()
