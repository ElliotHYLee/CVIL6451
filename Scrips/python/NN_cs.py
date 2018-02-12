import matplotlib.pyplot as plt
from keras.models import Sequential
from keras.layers import Dropout, Dense, LSTM, Conv2D, MaxPooling2D, Flatten
from keras.layers.advanced_activations import LeakyReLU, PReLU, ELU
from keras import initializers
from keras import backend as K
from keras.initializers import Ones, Zeros
from keras.optimizers import Adam
import numpy as np
from DataPrep import *


def csModel():
    model = Sequential()
    model.add(Dense(3, kernel_initializer="glorot_normal", activation='relu', input_dim = 3))
    model.add(Dense(3, kernel_initializer="glorot_normal", activation='sigmoid'))
    #model.compile(loss='mse', optimizer='adam')
    model.load_weights('csNN.h5')
    model.summary()
    return model



def main():

    x = np.array([[115, 82, 68]])/255
    y = np.array([[115, 82, 68]])/255
    model = csModel()

    history_callback = model.fit(x, y, epochs=1000, batch_size=1, verbose=1,
                                       shuffle=False, validation_split=0.0)

    model.save_weights('csNN.h5')
    val_loss = history_callback.history["loss"]
    plt.figure()
    plt.plot(val_loss, 'r')
    plt.show()

    g = model.predict(x)
    print g


if __name__ == '__main__':
    main()
