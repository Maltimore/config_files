#!/bin/bash
sudo apt-get update
sudo apt-get install git-core

cd ~
git init
git remote add origin https://github.com/Maltimore/config_files.git
rm .bashrc
git pull origin master

git config --global user.name "maltimore"
git config --global user.email "malte.esders@gmail.com"

# download and install miniconda3
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh 
bash Miniconda3-latest-Linux-x86_64.sh

# create py36 environment
source ~/.bashrc
conda create -n py36 python=3.6


# how to change the ipython color profile
# run "ipython profile create"
# cd ~/.ipython/profile_default
# in the file "ipython_config.py", search for color
# and change for example to LightBG
