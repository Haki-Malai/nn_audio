clear all; close all;
 
Ft = 440;
Fs = 16000;
Td = 3;
 
a_note = tonegen(Ft, Fs, Td);
white_noise = rand(1, Fs*Td);
a_note_with_noise = a_note .* white_noise;
 
soundsc(a_note, Fs);
soundsc(a_note_with_noise, Fs);
 
[a_sound,a_sound_FS]= audioread ("..\\dataset\\wav\\Yes Baby! (Jus Deelax Remix).wav");
a_sound = a_sound';
a_sound_with_noise = a_sound .* rand(1, length(a_sound));
 
soundsc(a_sound, a_sound_FS);
soundsc(a_sound_with_noise, a_sound_FS);
 
mse_a_note = mean((a_note - a_note_with_noise) .^2)
mse_a_sound = mean((a_sound - a_sound_with_noise) .^2)
