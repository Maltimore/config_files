#!/bin/bash
# there are problems if the first file I edit with neovim is with "sudo nvim"

# install vundle by just cloning it into the .vim/bundle directory
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install the xsel program to be able to copy to system clipboard with "+y
sudo apt install -y xsel
# no idea what i need this for
sudo apt install -y software-properties-common
# install neovim
sudo apt install -y neovim
# it's not clear to me whether this is needed
sudo apt install -y python3-dev
# create a conda environment specially for neovim
conda create -y -n neovim_env python
source activate neovim_env
# install the neovim python package for python plugins
pip install neovim
# install grip for markdown-viewer
pip install grip
# install flake8 for syntastic
pip install flake8
# install jedi (python comprehension library)
pip install jedi
# use Vundle to install all plugins, but first install cmake
sudo apt-get install -y build-essential cmake
nvim +PluginInstall +qall
# use .vimrc as configuration
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
