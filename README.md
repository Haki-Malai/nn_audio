# nn-audio
## Audio Classifier
- Takes a dataset in the form below as input

```
dataset___
          ├── class#1
          │   ├── file11.wav
          │   └── file12.wav
          ├── class#2
          │   ├── file21.wav
          │   ├── file22.wav
          │   └── file23.wav
          ├── class#3
          │   ├── file31.wav
          │   ├── file32.wav
          │   └── file33.wav
                 ...
 ```
 - Returns an keras model and (optional) the data in a json file.

## Instalation
  - Linux:
    - `git clone https://github.com/Haki-Malai/nn-audio`
    - `cd nn-audio`
    - `sudo bash install.sh # Adds 'audio_model' as command. If it does not work try running 'source ~\.profile'`
