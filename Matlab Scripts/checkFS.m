%See if any song has a different fs
path=dir("..\\dataset\\wav\\");
max = 0;

for i=3:length(path)
    [y, fs]=audioread (strcat("..\\dataset\\wav\\",path(i).name));
    if fs ~= 44100
        fs
    end
end