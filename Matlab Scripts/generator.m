fs = 1e4; % sampling frequency
t = 1:1/fs:5; % time signal
freq = 261.6; % note frequency in Hz (middle C)
y = sin(2*pi*freq*t); % create sine wave
player = audioplayer(y, fs); % create audio player object
play(player); % play the sound