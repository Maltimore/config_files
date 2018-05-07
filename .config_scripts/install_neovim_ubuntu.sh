#!/bin/bash
# there are problems if the first file I edit with neovim is with "sudo nvim"

# install vundle by just cloning it into the .vim/bundle directory
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install the xsel program to be able to copy to system clipboard with "+y
sudo apt install -y xsel

# install neovim
sudo apt install -y neovim

# create a conda environment specially for neovim
conda create -y -n neovim_env python
conda activate neovim_env

# PACKAGES FOR PLUGINS
# install the neovim python package for python plugins
pip install neovim
# markdown-viewer
pip install grip
sudo apt-get install -y xdotool
# syntastic python linting
pip install flake8
# jedi-vim (python comprehension plugin)
pip install jedi

# use Vundle to install all plugins
nvim +PluginInstall +qall

# use ~/.vimrc as configuration
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
