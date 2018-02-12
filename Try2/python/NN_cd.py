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


def cdModel(input_shape):
    model = Sequential()
    model.add(LSTM(100,
              kernel_initializer='glorot_uniform',
              recurrent_initializer='orthogonal',
              activation=LeakyReLU(),
              return_sequences = False,
              input_shape=input_shape))
    model.add(Dense(20, kernel_initializer="glorot_normal", activation=LeakyReLU()))
    model.add(Dense(3, kernel_initializer="glorot_normal", activation='sigmoid'))
    #model.compile(loss='mse', optimizer='adam')
    model.load_weights('cdNN.h5')
    return model


def main():

    x = readSequenceData()
    y = readCdData()
    model = cdModel(x.shape[1:])

    history_callback = model.fit(x, y, epochs=300, batch_size=600, verbose=1,
                                       shuffle=False, validation_split=0.0)

    model.save_weights('cdNN.h5')
    val_loss = history_callback.history["loss"]
    plt.figure()
    plt.plot(val_loss, 'r')
    plt.show()

    g = model.predict(x)
    np.savetxt('../data/CD_lstm/cd_pred.txt', g)


if __name__ == '__main__':
    main()
