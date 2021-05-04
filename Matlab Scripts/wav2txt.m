path=dir("..\\dataset\\wav\\False\\");

for i=1:length(path)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\False\\",path(i).name));
        save (strcat("..\\dataset\\txt\\False\\", erase(path(i).name, '.wav'),'.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song", erase(path(i).name, '.wav'))
    end    
end