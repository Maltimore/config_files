#!/bin/bash
# there are problems if the first file I edit with neovim is with "sudo nvim"

# install neovim
sudo apt install -y neovim
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
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
