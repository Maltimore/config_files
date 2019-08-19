#!/bin/bash
sudo apt-get update

####################################################################################################
# GIT 
sudo apt-get -y install git
git config --global user.name "Maltimore"
git config --global user.email "malte@esders.info"
# in order to ignore some warning
git config --global push.default simple
git config --global core.editor "vi"

cd ~
git init
git remote add origin git@github.com:Maltimore/config_files.git
# the following is a hacky workaround to replace all current config
# files with the ones from the repository (normal merge impossible
# due to untracked changes)
git fetch origin master
# otherwise the checkout won't work
rm ~/.bashrc
git checkout origin/master  # leaves us in headless state
git checkout master         # back to local master branch, 
							# strangely now all commits from
							# origin are here too

####################################################################################################
# MINICONDA
## for the time being, we have to install bzip2 manually (likely to change in the future)
## I disabled this 2019-06-25 without checking whether it's still needed (but hope not)
#sudo apt-get -y install bzip2
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh 
bash Miniconda3-latest-Linux-x86_64.sh

####################################################################################################
# smaller programs
sudo apt install -y curl
sudo apt install -y tmux
sudo apt install -y silversearcher-ag

source ~/.bashrc

# how to change the ipython color profile
# run "ipython profile create"
# edit ~/.ipython/profile_default/ipython_config.py
# search for "color" and change for example to LightBG
# and to change the editing mode to vi:
#c.TerminalInteractiveShell.editing_mode = 'vi'
