#!/bin/bash
# there are problems if the first file I edit with neovim is with "sudo nvim"

# install vundle by just cloning it into the .vim/bundle directory
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install the Ack searching program
# (which is for searching for text in multiple files)
sudo apt-get install -y ack-grep
# install the xsel program to be able to copy to system clipboard with "+y
sudo apt-get install -y xsel
# install neovim (only works on Ubuntu; no Debian packages yet)
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim
sudo apt-get install -y python-dev python-pip python3-dev python3-pip
source deactivate
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
