path=dir("..\\dataset\\wav\\");
max = 0;
%Find the max y of all the files
for i=3:length(path)
    try
        [y, fs]=audioread (strcat("..\\dataset\\wav\\",path(i).name));
        save (strcat("..\\dataset\\txt\\", erase(path(i).name, '.wav'),'.txt'), 'y', '-ASCII');
    catch
        strcat("Couldn't write song", erase(path(i).name, '.wav'))
    end    
end