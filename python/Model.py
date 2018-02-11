from keras.models import Sequential
from keras.layers import Dropout, Dense, LSTM
from keras.layers.advanced_activations import LeakyReLU, PReLU, ELU
from keras import initializers
from keras import backend as K
from keras.initializers import Ones, Zeros
from keras.optimizers import Adam


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

    sR = getCol(4,y_pred)
    sR = K.ones_like(sR)*K.mean(sR)
    sG = getCol(5,y_pred)
    sG = K.ones_like(sG)*K.mean(sG)
    sB = getCol(6,y_pred)
    sB = K.ones_like(sB)*K.mean(sB)

    predR = md*cdR + sR
    predG = md*cdG + sG
    predB = md*cdB + sB

    pred = K.concatenate([predR, predG, predB], axis=1)

    true = y_true[:,1:4]

    e = K.abs(pred - true) + 1/sR + 1/sG + 1/sB
    e = K.mean(e)
    return e

def myLoss():
    def dichrom(y_true, y_pred):
        return dich(y_true, y_pred)
    return dichrom


def getNewModel(input_dim):
    model = Sequential()
    model.add(Dense(5, input_dim=input_dim, kernel_initializer="uniform", activation='relu'))
    model.add(Dense(5, kernel_initializer="uniform", activation='relu'))
    model.add(Dense(7, kernel_initializer="uniform", activation='linear'))
    model.compile(loss=myLoss(), optimizer='adam')
    return model
