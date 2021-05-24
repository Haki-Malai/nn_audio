#!/usr/bash
pip install -r requirements.txt
chmod +x audio_model
cp audio_model ~/bin
echo 'export PATH=$PATH":$HOME/bin"' >> .profile
