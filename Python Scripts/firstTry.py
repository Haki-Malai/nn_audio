import numpy as np
import pandas as pd
import pydub
import os

from IPython.display import Audio
import keras 
from keras.layers import Dense, LSTM, LeakyReLU
from keras.models import Sequential, load_model
from scipy.io.wavfile import read, write\

path  = '../dataset-techno/wav/'        
music = []
rate
complete = 0                
for filename in os.listdir(path):
    rate, sample = read('..\\dataset\\wav\\', filename, '.wav')
    music.append([sample])
    complete = complete + 1
    print('Reading is complete by '(complete/len(os.listdir(path)))*100, '%')
    
# taking only some part of the songs and converting to a dataframe
music1 = pd.DataFrame(music1[0:400000, :])
music2 = pd.DataFrame(music2[0:400000, :])
# function to create train data by shifting the music data 
def create_train_dataset(df, look_back):
    dataX1, dataX2 , dataY1 , dataY2 = [],[],[],[]
    for i in range(len(df)-look_back-1):
        dataX1.append(df.iloc[i : i + look_back, 0].values)
        dataX2.append(df.iloc[i : i + look_back, 1].values)
        dataY1.append(df.iloc[i + look_back, 0])
        dataY2.append(df.iloc[i + look_back, 1])
    return np.array(dataX1), np.array(dataX2), np.array(dataY1), np.array(dataY2)
X1 , X2, y1 , y2 = create_train_dataset(pd.concat([music1.iloc[0 : 160000, :],music2.iloc[0 : 160000, :]], axis=0), 3)
# function to create train data by shifting the music data
def create_test_data(df, look_back):
    dataX1, dataX2 = [], []
    for i in range(len(df)-look_back-1):
        dataX1.append(df.iloc[i : i + look_back, 0].values)
        dataX2.append(df.iloc[i : i + look_back, 1].values)
        
    return np.array(dataX1), np.array(dataX2)
test1, test2 = create_test_data(pd.concat([music1.iloc[160001 : 400000, :],music2.iloc[160001 : 400000, :]], axis=0), 3)

X1 = X1.reshape((-1, 1, 3))
X2 = X2.reshape((-1, 1, 3))

# LSTM Model for channel 1 of the music data
rnn1 = Sequential()
rnn1.add(LSTM(units=100, activation='linear', input_shape=(None, 3)))
rnn1.add(LeakyReLU())
rnn1.add(Dense(units=50, activation='linear'))
rnn1.add(LeakyReLU())
rnn1.add(Dense(units=25, activation='linear'))
rnn1.add(LeakyReLU())
rnn1.add(Dense(units=12, activation='linear'))
rnn1.add(LeakyReLU())
rnn1.add(Dense(units=1, activation='linear'))
rnn1.add(LeakyReLU())

rnn1.compile(optimizer='adam', loss='mean_squared_error')
rnn1.fit(X1, y1, epochs=20, batch_size=100)

# LSTM Model for channel 2 of the music data
rnn2 = Sequential()
rnn2.add(LSTM(units=100, activation='linear', input_shape=(None, 3)))
rnn2.add(LeakyReLU())
rnn2.add(Dense(units=50, activation='linear'))
rnn2.add(LeakyReLU())
rnn2.add(Dense(units=25, activation='linear'))
rnn2.add(LeakyReLU())
rnn2.add(Dense(units=12, activation='linear'))
rnn2.add(LeakyReLU())
rnn2.add(Dense(units=1, activation='linear'))
rnn2.add(LeakyReLU())

rnn2.compile(optimizer='adam', loss='mean_squared_error')
rnn2.fit(X2, y2, epochs=20, batch_size=100)

# saving LSTM models
rnn1.save('rnn1.h5')
rnn2.save('rnn2.h5')

# loading the saved models
rnn1 = load_model('rnn1.h5')
rnn2 = load_model('rnn2.h5')

# making predictions for channel 1 and channel 2
pred_rnn1 = rnn1.predict(test1.reshape(-1, 1, 3))
pred_rnn2 = rnn2.predict(test2.reshape(-1, 1, 3))

# reshaping the data for input to ANN
X1 = X1.reshape((-1, 3))
X2 = X2.reshape((-1, 3))

# ANN Model for channel 1 of the music data
ann1 = Sequential()
ann1.add(Dense(units=100, activation='linear', input_dim=3))
ann1.add(LeakyReLU())
ann1.add(Dense(units=50, activation='linear'))
ann1.add(LeakyReLU())
ann1.add(Dense(units=25, activation='linear'))
ann1.add(LeakyReLU())
ann1.add(Dense(units=12, activation='linear'))
ann1.add(LeakyReLU())
ann1.add(Dense(units=1, activation='linear'))
ann1.add(LeakyReLU())

ann1.compile(optimizer='adam', loss='mean_squared_error')
ann1.fit(X1, y1, epochs = 20, batch_size=100)

# ANN Model for channel 2 of the music data
ann2 = Sequential()
ann2.add(Dense(units=100, activation='linear', input_dim=3))
ann2.add(LeakyReLU())
ann2.add(Dense(units=50, activation='linear'))
ann2.add(LeakyReLU())
ann2.add(Dense(units=25, activation='linear'))
ann2.add(LeakyReLU())
ann2.add(Dense(units=12, activation='linear'))
ann2.add(LeakyReLU())
ann2.add(Dense(units=1, activation='linear'))
ann2.add(LeakyReLU())

ann2.compile(optimizer='adam', loss='mean_squared_error')
ann2.fit(X2, y2, epochs=20, batch_size=100)

# saving ANN models
ann1.save('ann1.h5')
ann2.save('ann2.h5')

# loading saved ANN models
ann1 = load_model('ann1.h5')
ann2 = load_model('ann2.h5')

# making predictions for channel 1 and channel 2
pred_ann1 = ann1.predict(test1)
pred_ann2 = ann2.predict(test2)

# saving the ANN predicitons in wav format
write('pred_ann.wav', rate, pd.concat([pd.DataFrame(pred_ann1.astype('int16')), pd.DataFrame(pred_ann2.astype('int16'))], axis=1).values)

# saving the LSTM predicitons in wav format
write('pred_rnn.wav', rate, pd.concat([pd.DataFrame(pred_rnn1.astype('int16')), pd.DataFrame(pred_rnn2.astype('int16'))], axis=1).values)
# saving the original music in wav format
write('original.wav',rate, pd.concat([music1.iloc[160001 : 400000, :], music2.iloc[160001 : 400000, :]], axis=0).values)
Audio("pred_ann.wav")
Audio("pred_rnn.wav")