#!/bin/bash

# install vundle by just cloning it into the .vim/bundle directory
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# remember to run :PluginInstall in vim to have vundle install the plugins

# install neovim (only works on Ubuntu; no Debian packages yet)
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip
sudo apt-get install tmux
# use .vimrc as configuration
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
