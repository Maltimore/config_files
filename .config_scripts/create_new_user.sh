#!/bin/bash
sudo apt-get update
sudo apt-get -y install git-core

git config --global user.name "maltimore"
git config --global user.email "malte.esders@gmail.com"
# ignore some warning for a change to git 2.x
git config --global push.default simple
git config --global core.editor "nvim"

cd ~
git init
git remote add origin git@github.com/Maltimore/config_files.git
# the following is a hacky workaround to replace all current config
# files with the ones from the repository (normal merge impossible
# due to untracked changes)
git fetch origin master
git checkout origin/master  # leaves us in headless state
git checkout master         # back to local master branch, 
							# strangely now all commits from
							# origin are here too

# download and install miniconda3
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh 
bash Miniconda3-latest-Linux-x86_64.sh

# create py36 environment
conda create -n py36 python=3.6

source ~/.bashrc

# how to change the ipython color profile
# run "ipython profile create"
# edit ~/.ipython/profile_default/ipython_config.py
# search for "color" and change for example to LightBG
