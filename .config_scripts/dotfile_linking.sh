#!/bin/bash
# all this does is create symlinks from each config file listed below to $HOME/.config/<configfile>
# (though it does add a dot before the filename)
# no config files are being moved or deleted
echo linking config files
echo  
sed -e "/^#\\|^\$/d" <<'EOF' | while read V;do echo linking $V; ln -sfT "$HOME/.config/$V" "$HOME/.$V";done

ackrc
bash_aliases
bash_profile
bashrc
condarc
pythonrc.py
screenrc
tmux.conf
latexmkrc
pdbrc.py
pdbrc
gitconfig
EOF

