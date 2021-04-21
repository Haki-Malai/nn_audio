import os
import re


for filename in os.listdir():
    try:
        os.rename(filename, re.sub(r'([0-9][0-9]. )', '', filename))
    except:
        print("skipped")
#os.rename(r'file path\OLD file name.file type',r'file path\NEW file name.file type')