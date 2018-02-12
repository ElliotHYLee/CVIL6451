import numpy as np
from DataPrep import *
from Model import *
import matplotlib.pyplot as plt
import sys

def train():
    data = readData()
    x = data
    y = data
    y = np.concatenate([np.zeros((data.shape[0],1)), data, np.zeros((data.shape[0],4))], axis=1)

    print x.shape
    print y.shape

    model = getNewModel(3)
    history_callback = model.fit(x, y, epochs=15000, batch_size=10000, verbose=1,
                                       shuffle=False, validation_split=0)
    model.save_weights('dichrom_try1.h5')
    val_loss = history_callback.history["loss"]
    plt.figure()
    plt.plot(val_loss, 'r')
    plt.show()



def test():
    model = getNewModel(3)
    model.load_weights('dichrom_try1.h5')
    data = readData()
    pred = np.abs(model.predict(data))

    diffused = pred[:,0:4]
    spectral = pred[:,4:8]
    ms = spectral[:,0]
    sR = np.mean(spectral[:,1])
    sG = np.mean(spectral[:,2])
    sB = np.mean(spectral[:,3])

    print diffused
    print ms
    print sR, sG, sB

    np.savetxt('../data/diffused.txt', diffused)
    np.savetxt('../data/spectral.txt', spectral)

if __name__ == '__main__':
    case = int(sys.argv[1])
    print case
    if case == 0:
        train()
    elif case == 1:
        test()
