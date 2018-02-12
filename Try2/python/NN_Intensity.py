import matplotlib.pyplot as plt
from keras.models import Sequential
from keras.layers import Dropout, Dense, LSTM
from keras.layers.advanced_activations import LeakyReLU, PReLU, ELU
from keras import initializers
from keras import backend as K
from keras.initializers import Ones, Zeros
from keras.optimizers import Adam
import numpy as np
from DataPrep import *


def IntensityModel():
    model = Sequential()
    model.add(Dense(10, input_dim=3, kernel_initializer='glorot_normal', activation='relu'))
    model.add(Dense(5, kernel_initializer="glorot_normal", activation='relu'))
    model.add(Dense(1, kernel_initializer="glorot_normal", activation='linear'))
    #model.compile(loss='mse', optimizer='adam')
    model.load_weights('intensityNN.h5')
    return model

def main():
    model = IntensityModel()
    x = readColorData()
    y = readGrayData()

    # history_callback = model.fit(x, y, epochs=1000, batch_size=10**6, verbose=1,
    #                                    shuffle=False, validation_split=0.2)
    #
    # model.save_weights('intensityNN.h5')
    # val_loss = history_callback.history["loss"]
    # plt.figure()
    # plt.plot(val_loss, 'r')
    # plt.show()

    g = model.predict(x)
    np.savetxt('../data/M_fc/predGray.txt', g)

if __name__ == '__main__':
    main()
