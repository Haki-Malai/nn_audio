clear all; close all;

path=dir("..\\dataset\\wav\\");

randomTracks = randperm(600, 30);
errors = 0
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        y=imnoise(y, 'gaussian', 0.01, 0.025);
        save (strcat("..\\dataset\\txt\\False\\", 'GaussianNoise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'poisson');
        save (strcat("..\\dataset\\txt\\False\\", 'PoissonNoise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'salt & pepper', 0.025);
        save (strcat("..\\dataset\\txt\\False\\", 'SaltPepperNoise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'salt & pepper', 0.005);
        save (strcat("..\\dataset\\txt\\False\\", 'SaltPepper0005Noise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end

for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'speckle');
        save (strcat("..\\dataset\\txt\\False\\", 'SpeckleNoise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'speckle', 0.25);
        save (strcat("..\\dataset\\txt\\False\\", 'Speckle025Noise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y = awgn(y,11,'measured');
        save (strcat("..\\dataset\\txt\\False\\", 'SNR11Noise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y = awgn(y,9,'measured');
        save (strcat("..\\dataset\\txt\\False\\", 'SNR9Noise', int2str(i), '.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = erros + 1
    end
    i
end