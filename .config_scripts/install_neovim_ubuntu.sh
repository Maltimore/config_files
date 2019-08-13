#!/bin/bash
# there are problems if the first file I edit with neovim is with "sudo nvim"

# install the xclip program to be able to copy to system clipboard with "+y
sudo apt install -y xclip

# install neovim
sudo apt install -y neovim

# install the neovim python package for python plugins
conda install pynvim
# markdown-viewer
pip install grip
# mouse compatibility
sudo apt-get install -y xdotool
# LSP
conda install python-language-server
