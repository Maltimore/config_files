#!/bin/bash

# install vundle by just cloning it into the .vim/bundle directory
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install neovim (only works on Ubuntu; no Debian packages yet)
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim
sudo apt-get install -y python-dev python-pip python3-dev python3-pip
# install pip and then the neovim python package for python plugins
sudo apt-get install -y python3-pip
pip3 install neovim
# use Vundle to install all plugins, but first install cmake
sudo apt-get install -y build-essential cmake
nvim +PluginInstall +qall
# install compiled content from youcompleteme plugin
cd ~/.vim/bundle/YouCompleteMe
./install.py
# use .vimrc as configuration
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
