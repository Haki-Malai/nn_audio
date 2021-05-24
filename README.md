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
 - Uses the class names (i.e. class#1) as label
 - Returns an keras model and (optional) the data in a json file.

### Requirements
   - Python 3(recomended >=3.6)
   - Pip (For installing other dependencies

### Instalation
  - **Linux**:
    - `git clone https://github.com/Haki-Malai/nn-audio`
    - `cd nn-audio`
    - `sudo bash install.sh` (Adds 'audio_model' as command. If it does not work try running 'source ~\.profile')
  - **Windows**:
    - Rename audio_model to audio_model.py

### Usage
  - `audio_model --dataset_dir=dataset ` (For example. dataset_dir is pwd for default but i don't think it is able to run this way as the script will read itself in the directory )
  - All options:
     - **--sample_rate** (default=44100)
     - **--min_track_duration** (default=10)
     - **--min_array_length** (default=0)
     - **--from_json** (default=False)
     - **--json_save** (default=False)
     - **--output_json** (default="data.json")
     - **--json_path** (default="data.json")
     - **--model_name** (default="model")
     - **--test_size** (default=0.3)
     - **--epochs** (default=50)
