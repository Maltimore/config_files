#!/bin/bash

cd ~
git init
git remote add origin https://github.com/Maltimore/config_files.git
rm .bashrc
git pull origin master


# download and install miniconda3
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh 
bash Miniconda3-latest-Linux-x86-64.sh


# install tmux
sudo apt-get install tmux


# how to change the ipython color profile
# run "ipython profile create"
# cd ~/.ipython/profile_default
# in the file "ipython_config.py", search for color
# and change for example to LightBG
