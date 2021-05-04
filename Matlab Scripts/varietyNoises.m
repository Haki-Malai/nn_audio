clear all; close all;

path=dir("..\\dataset\\wav\\True\\");

randomTracks = randperm(600, 30);
errors = 0
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        y=imnoise(y, 'gaussian', 0.01, 0.025);
        audiowrite(strcat('GaussianNoise', int2str(i), '.wav'), y, 44100);
    catch
       strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
    errors = errors + 1,
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'poisson');
        audiowrite(strcat('PoissonNoise', int2str(i), '.wav'), y, 44100);
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = errors + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'salt & pepper', 0.025);
        audiowrite(strcat('SaltNPepperNoise', int2str(i), '.wav'), y, 44100);
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = errors + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'salt & pepper', 0.005);
        audiowrite(strcat('SaltNPepper0005Noise', int2str(i), '.wav'), y, 44100);
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = errors + 1
    end
    i
end

for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'speckle');
        audiowrite(strcat('SpeckleNoise', int2str(i), '.wav'), y, 44100);
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = errors + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y=imnoise(y,'speckle', 0.25);
        audiowrite(strcat('SpeckleNoise', int2str(i), '.wav'), y, 44100);
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = errors + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y = awgn(y,11,'measured');
        audiowrite(strcat('Measured11Noise', int2str(i), '.wav'), y, 44100);
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = errors + 1
    end
    i
end

randomTracks = randperm(600, 30);
for i=1:length(randomTracks)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\True\\", path(randomTracks(1,i)).name));
        Mean=0.00;
        Var=0.005;
        y = awgn(y,9,'measured');
        audiowrite(strcat('Measured9Noise', int2str(i), '.wav'), y, 44100);
    catch
        strcat("Couldn't write song ", erase(path(randomTracks(1,i)).name, '.wav'))
        errors = errors + 1
    end
    i
end