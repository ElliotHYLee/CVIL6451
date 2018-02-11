import numpy as np
from DataPrep import *
from Model import *
import matplotlib.pyplot as plt
import sys

def train():
    data = readData()
    x = data
    y = data
    y = np.concatenate([np.zeros((data.shape[0],1)), data, np.zeros((data.shape[0],3))], axis=1)

    print x.shape
    print y.shape

    model = getNewModel(3)
    history_callback = model.fit(x, y, epochs=10000, batch_size=10000, verbose=1,
                                       shuffle=False, validation_split=0.2)

    val_loss = history_callback.history["val_loss"]
    plt.figure()
    plt.plot(val_loss, 'r')
    plt.show()

    model.save_weights('dichrom.h5')

def test():
    model = getNewModel(3)
    model.load_weights('dichrom.h5')
    data = readData()
    pred = np.abs(model.predict(data))

    diffused = pred[:,0:4]
    sR = np.mean(pred[:,4])
    sG = np.mean(pred[:,5])
    sB = np.mean(pred[:,6])

    print diffused
    print sR, sG, sB

    np.savetxt('diffused.txt', diffused)

if __name__ == '__main__':
    case = int(sys.argv[1])
    print case
    if case == 0:
        train()
    elif case == 1:
        test()
