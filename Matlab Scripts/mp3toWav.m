mp3Path=dir("..\\dataset\\mp3\\False");
wavPath="..\\dataset\\wav\\False";

for i=0:length(mp3Path)
    try
        signal=audioread (strcat("..\\dataset\\mp3\\False\\",mp3Path(i).name));
        audiowrite(strcat(wavPath, erase(mp3Path(i).name, '.mp3'), '.wav'), signal, 44100);
    catch
        strcat("Couldn't write song", erase(path(i).name, '.wav'))
    end    
end