mp3Path=dir("..\\dataset\\mp3\\False\\");
wavPath="..\\dataset\\wav\\False\\";

for i=3:length(mp3Path)
    try
        filename = strcat(erase(mp3Path(i).name, '.mp3'), '.wav');
        signal=audioread (strcat("..\\dataset\\mp3\\False\\",mp3Path(i).name));
        audiowrite(filename, signal, 44100);
    catch
        strcat("Couldn't convert song ", erase(mp3Path(i).name, '.mp3'))
    end    
end