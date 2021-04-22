import os
from pydub import AudioSegment
import re

path  = '../dataset-techno/mp3/'
errors = 0
complete = 0
destination = '../dataset-techno/wav/'                                 
for filename in os.listdir(path):
    try:
        new_name = filename.replace('.mp3', '.wav')
        sound = AudioSegment.from_mp3(path+filename)
        sound.export(destination+new_name, format="wav")
        complete = complete + 1
        print((complete/len(os.listdir(path)))*100, '%')
    except:
        errors = errors + 1
print("Script complete with ", errors, "errors")
