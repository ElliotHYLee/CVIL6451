import matplotlib.pyplot as plt
from keras.models import Sequential
from keras.layers import Dropout, Dense, LSTM, Merge
from keras.layers.advanced_activations import LeakyReLU, PReLU, ELU
from keras import initializers
from keras import backend as K
from keras.initializers import Ones, Zeros
from keras.optimizers import Adam
import numpy as np
from DataPrep import *
from NN_cd import cdModel
from NN_Intensity import IntensityModel
from NN_cs import csModel

def getCol(i, tensor):
    col = tensor[:,i]
    col = K.reshape(col, (-1,1))
    return col

def dich(y_true, y_pred):
    y_pred = K.abs(y_pred)

    md = getCol(0,y_pred)
    cdR = getCol(1,y_pred)
    cdG = getCol(2,y_pred)
    cdB = getCol(3,y_pred)

    ldR = md*cdR
    ldG = md*cdG
    ldB = md*cdB
    ld = K.concatenate([ldR, ldG, ldB], axis=1)

    ms = getCol(4, y_pred)
    csR = getCol(5, y_pred)
    csG = getCol(6, y_pred)
    csB = getCol(7, y_pred)

    lsR = ms*csR
    lsG = ms*csG
    lsB = ms*csB
    ls = K.concatenate([lsR, lsG, lsB], axis=1)

    l_est = ls+ld

    e = (l_est - y_true)**2
    e = K.mean(e)
    return e

def myLoss():
    def dichrom(y_true, y_pred):
        return dich(y_true, y_pred)
    return dichrom


def dicho(input_shape):
    md = IntensityModel()
    cd = cdModel(input_shape)

    ms = IntensityModel()
    cs = csModel()

    model = Sequential()
    model.add(Merge([md, cd, ms, cs], mode='concat'))
    model.compile(loss=myLoss(), optimizer='adam')
    model.summary()
    return model


def main():

    x1, x2 = getTotalInput()
    x3 = x1
    x4 = np.array([[115, 82, 68]])
    x4 = np.repeat(x4, x1.shape[0], axis=0)
    y = x1

    model = dicho(x2.shape[1:])
    #model.load_weights('dicho_total_proto.h5')
    history_callback = model.fit([x1, x2, x3, x4], y, epochs=10, batch_size=50000, verbose=1,
                                       shuffle=False, validation_split=0.0)

    model.save_weights('dicho_total0.h5')
    val_loss = history_callback.history["loss"]
    plt.figure()
    plt.plot(val_loss, 'r')
    plt.show()


    output = model.predict([x1, x2])

    pred = np.zeros((output.shape[0], 3))
    const = output[:,0]
    pred[:,0] = output[:,1]*const
    pred[:,1] = output[:,2]*const
    pred[:,2] = output[:,3]*const

    print np.abs(y-pred)
    print output
    print output.shape
    np.savetxt('../mdcd.txt', output)


if __name__ == '__main__':
    main()
