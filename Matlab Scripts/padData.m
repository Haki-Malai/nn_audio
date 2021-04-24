%path=dir("..\\dataset\\wav\\");
%max = 0;
%Find the max y of all the files
%for i=3:length(path)
%    [y, fs]=audioread (strcat("..\\dataset\\wav\\",path(i).name));
%    if length(y) > max
%        max = length(y);
%    end
%end
clear all; close all;
max = 191170944;
%[y, Fs]=audioread(strcat("..\\dataset\\wav\\",path(3).name));
[y, Fs] = audioread ("..\\dataset\\wav\\Yes Baby! (Jus Deelax Remix).wav");
padarray(y,[max-length(y),0],0,'post');
%for i=3:length(path)
    
%end
        