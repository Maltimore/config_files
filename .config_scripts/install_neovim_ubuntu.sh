#!/bin/bash
# there are problems if the first file I edit with neovim is with "sudo nvim"

# install vundle by just cloning it into the .vim/bundle directory
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install the Ack searching program
# (which is for searching for text in multiple files)
sudo apt install -y ack-grep
# install the xsel program to be able to copy to system clipboard with "+y
sudo apt install -y xsel
# install neovim
sudo apt install -y software-properties-common
sudo apt install -y neovim
sudo apt install -y python-dev python-pip python3-dev python3-pip
# deactivate any active conda env to install nvim related programs
# into the root conda env
source deactivate
# jupyter is needed for some python plugins
conda install jupyter
# install the neovim python package for python plugins
pip install neovim
# install grip for markdown-viewer
pip install grip
# install flake8 for syntastic
pip install flake8
# use Vundle to install all plugins, but first install cmake
sudo apt-get install -y build-essential cmake
# use .vimrc as configuration
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
