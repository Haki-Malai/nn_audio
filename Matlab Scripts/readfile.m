clear all; close all;
sample = audioread ('test');
[Y,FS,NBITS,OPTS] = audioread ('test')
sound (sample, FS);
bytes(sample)
