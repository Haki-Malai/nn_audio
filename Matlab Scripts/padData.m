path=dir("..\\dataset\\wav\\");
for i=3:length(path)
    [y, fs]=audioread (strcat("..\\dataset\\wav\\",path(i).name));
    if fs != 44100
        fs
    end
end
        