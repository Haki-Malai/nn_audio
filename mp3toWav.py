from os import path
from pydub import AudioSegment
# files                                                                         
src = "2 Sinners - What's Been Going On.mp3"
dst = "test.wav"
# convert wav to mp3                                                            
sound = AudioSegment.from_mp3(src)
sound.export(dst, format="wav")