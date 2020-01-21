#--location is in order to follow redirect
rm -f $HOME/programs/vim
curl -o $HOME/programs/vim --location https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x $HOME/programs/vim
