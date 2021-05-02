path=dir("..\\dataset\\wav\\");

for i=0:length(path)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\",path(i).name));
        save (strcat("..\\dataset\\txt\\", erase(path(i).name, '.wav'),'.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song", erase(path(i).name, '.wav'))
    end    
end