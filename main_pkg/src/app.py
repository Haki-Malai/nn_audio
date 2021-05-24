import os
import math
import librosa
import numpy as np
from sklearn.model_selection import train_test_split
import tensorflow.keras as keras
import click
from tensorflow.python.keras.utils.generic_utils import default

@click.command()
@click.option("--dataset_dir", help="Dataset directory")
@click.option("--sample_rate", default=44100, help="Frequency of files, all must be have the same")
@click.option("--min_track_duration", default=10, help="Shortest duration of all files, needed to cut everything to its length")
@click.option("--min_array_length", default=0, help="Optional: give smallest signal array length. Otherwise, calcuated on its own")
@click.option("--from_json", default=False, type=bool, help="Load data from a json file that was loaded with this script for the purpose of saving time")
@click.option("--json_save", default=False, type=bool, help="Save data generated for the training to a json file in order the get faster to another training")
@click.option("--output_json", default="data.json", help="Where to output the json")
@click.option("--json_path", default="data.json", help="Where to look for the json data if from_json is true")
@click.option("--model_name", default="model", help="Desired name for the model, \'model\' if none given")
@click.option("--test_size", default=0.3, help="Desired test size, 0.3 if none given")
@click.option("--epochs", default=50, help="Amound of epochs to train the model on")
def create_model(dataset_dir, sample_rate, min_track_duration, min_array_length, from_json, json_save, output_json, json_path, model_name, test_size, epochs, num_mfcc=13, n_fft=2048, hop_length=512, num_segments=5):
    """Extracts MFCCs from music dataset and saves them into a json file along witgh genre labels.
        :param dataset_dir (str): Path to dataset
        :param num_mfcc (int): Number of coefficients to extract
        :param n_fft (int): Interval we consider to apply FFT. Measured in # of samples
        :param hop_length (int): Sliding window for FFT. Measured in # of samples
        :param: num_segments (int): Number of segments we want to divide sample tracks into
        :return:
    """

    if not from_json:
        mapping = [] 
        labels = []
        mfcc_data = []

        samples_per_segment = int(sample_rate * min_track_duration / num_segments)
        num_mfcc_vectors_per_segment = math.ceil(samples_per_segment / hop_length)

        # Loop through all genre sub-folder
        for i, (dirpath, dirnames, filenames) in enumerate(os.walk(dataset_dir)):

            # Ensure we're processing a genre sub-folder level
            if dirpath is not dataset_dir:

                # Save genre label (i.e., sub-folder name) in the mapping
                semantic_label = dirpath.split("/")[-1]
                mapping.append(semantic_label)
                print("\nProcessing: {}".format(semantic_label))

                # Process all audio files in genre sub-dir
                for f in filenames:

                    # Load audio file
                    file_path = os.path.join(dirpath, f)
                    signal, sample_rate = librosa.load(file_path, sr=sample_rate)

                    # Process all segments of audio file
                    for d in range(num_segments):

                        # Calculate start and finish sample for current segment
                        start = samples_per_segment * d
                        finish = start + samples_per_segment

                        # Extract mfcc
                        mfcc = librosa.feature.mfcc(signal[start:finish], sample_rate, n_mfcc=num_mfcc, n_fft=n_fft, hop_length=hop_length)
                        mfcc = mfcc.T

                        # Store only mfcc feature with expected number of vectors
                        if len(mfcc) == num_mfcc_vectors_per_segment:
                            mfcc_data.append(mfcc.tolist())
                            labels.append(i-1)
                            print("{}, segment:{}".format(file_path, d+1))
            if json_save:
                import json
                data = {
                    "mapping": mapping,
                    "labels": labels,
                    "mfcc": mfcc_data
                }
                # Save MFCCs to json file
                with open(json_path, "w") as fp:
                    json.dump(data, fp, indent=4)
                
    else:
        import json
        """Loads training dataset from json file.
            :param json_path (str): Path to json file containing data
            :return X (ndarray): Inputs
            :return y (ndarray): Targets
        """
        with open(json_path, "r") as fp:
            data = json.load(fp)
        mfcc_data = data["mfcc"]
        labels = data["labels"]

    # Convert lists to numpy arrays
    x = np.array(mfcc_data)
    y = np.array(labels)

    print("Data succesfully loaded!")

    # Create train/test split
    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=test_size)

    # Build network topology
    model = keras.Sequential([

        # Input layer
        keras.layers.Flatten(input_shape=(x.shape[1], x.shape[2])),

        # 1st dense layer
        keras.layers.Dense(512, activation='relu'),

        # 2nd dense layer
        keras.layers.Dense(256, activation='relu'),

        # 3rd dense layer
        keras.layers.Dense(64, activation='relu'),

        # output layer
        keras.layers.Dense(10, activation='softmax')
    ])

    # Compile model
    optimiser = keras.optimizers.Adam(learning_rate=0.0001)
    model.compile(optimizer=optimiser,
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])

    model.summary()

    # Train model
    history = model.fit(x_train, y_train, validation_data=(x_test, y_test), batch_size=32, epochs=epochs)

        
if __name__ == "__main__":
    
    create_model()
    
    