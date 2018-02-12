import numpy as np
import pandas as pd
import scipy.misc as spym

def readColorData():
    fName = '../data/M_fc/color.txt'
    data = pd.read_csv(fName, sep=" ", header=None)
    data = data.as_matrix()
    return data

def readGrayData():
    fName = '../data/M_fc/gray.txt'
    data = pd.read_csv(fName, sep=" ", header=None)
    data = data.as_matrix()
    return data

def readSequenceData():
    seqData = None
    info = pd.read_csv('../data/CD_lstm/cd_info.txt', sep=" ", header=None).as_matrix()
    min = info[0,0]
    N = info[0,1]

    for i in range(0, N):
        fName = '../data/CD_lstm/cd_input' + str(i) + '.txt'
        data = pd.read_csv(fName, sep=" ", header=None)
        data = data.as_matrix()
        if data.shape[0] >=min:
            data = data[0:min,:]
        data = np.reshape(data, (1, data.shape[0], data.shape[1]))
        seqData = data if seqData is None else np.concatenate((seqData,data), axis=0)

    return seqData

def readCdData():
    fName = '../data/CD_lstm/cd_init.txt'
    data = pd.read_csv(fName, sep=" ", header=None)
    data = data.as_matrix()
    return data


def readTotalInputSeq():
    info = pd.read_csv('../data/CD_lstm/cd_info.txt', sep=" ", header=None).as_matrix()
    min = info[0,0]
    N = info[0,1]
    seqData = None

    for i in range(0,N):
        fName = '../data/CD_lstm/cd_input' + str(i) + '.txt'
        data = pd.read_csv(fName, sep=" ", header=None)
        data = data.as_matrix()
        elementN = data.shape[0]
        data = data[0:min,:] if data.shape[0] >=min else data
        data = np.reshape(data, (1, data.shape[0], data.shape[1]))
        data = np.repeat(data, elementN, axis=0)
        seqData = data if seqData is None else np.concatenate((seqData,data), axis=0)
    return seqData

def readTotalInput():
    pixData = None
    seqData = None
    info = pd.read_csv('../data/CD_lstm/cd_info.txt', sep=" ", header=None).as_matrix()
    min = info[0,0]
    N = info[0,1]

    for i in range(0, N):
        fName = '../data/CD_lstm/cd_input' + str(i) + '.txt'
        data = pd.read_csv(fName, sep=" ", header=None)
        data = data.as_matrix()
        pixData = data if pixData is None else np.concatenate((pixData,data), axis=0)

    return pixData

def getTotalInput():
    x2 = readTotalInputSeq()
    x1 = readTotalInput()
    return x1, x2

if __name__ == '__main__':
    # x1, x2 = getTotalInput()
    # print x2.shape
    # print x1.shape
    getInputImg()
