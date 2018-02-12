import matplotlib.pyplot as plt
from keras.models import Sequential
from keras.layers import Dropout, Dense, LSTM
from keras.layers.advanced_activations import LeakyReLU, PReLU, ELU
from keras import initializers
from keras import backend as K
from keras.initializers import Ones, Zeros
from keras.optimizers import Adam
import numpy as np


def MultModel():
    model = Sequential()
    model.add(Dense(10, input_dim=4, kernel_initializer='glorot_normal', activation='relu'))
    model.add(Dense(5, kernel_initializer="glorot_normal", activation='relu'))
    model.add(Dense(3, kernel_initializer="glorot_normal", activation='linear'))
    model.compile(loss='mse', optimizer='adam')
    model.load_weights('multNN.h5')
    return model

def main():
    model = MultNN()
    y = np.empty((10**5,3))
    x = np.random.rand(10**5,4)
    const = x[:,0]
    y[:,0] = x[:,1]*const
    y[:,1] = x[:,2]*const
    y[:,2] = x[:,3]*const

    history_callback = model.fit(x, y, epochs=1000, batch_size=10**6, verbose=1,
                                       shuffle=False, validation_split=0.2)

    model.save_weights('multNN.h5')
    val_loss = history_callback.history["loss"]
    plt.figure()
    plt.plot(val_loss, 'r')
    plt.show()


if __name__ == '__main__':
    main()
