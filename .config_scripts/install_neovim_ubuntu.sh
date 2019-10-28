#!/bin/bash
# there are problems if the first file I edit with neovim is with "sudo nvim"

# get the AppImage
mkdir $HOME/programs
#--location is in order to follow redirect
curl -o $HOME/programs/vim --location https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x $HOME/programs/vim

# install the xclip program to be able to copy to system clipboard with "+y
sudo apt install -y xclip
# mouse compatibility
sudo apt-get install -y xdotool

# Python packages
# install the neovim python package for python plugins
conda install pynvim
# markdown-viewer
pip install grip
# LSP
conda install python-language-server

# for vim-plug
# just to be sure we install curl first
sudo apt install -y curl
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
