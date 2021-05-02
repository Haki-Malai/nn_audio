clear all; close all;

path=dir("..\\dataset\\wav\\");
randomTracks = randperm(600, 40);
for i=1:1%length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        %y = y + randn(size(y))*0.075;
        y = awgn(y,11,'measured');
        sound(y,fs)
        %save (strcat("..\\dataset\\txt\\False\\", 'RandomNoise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
    end
    i
end