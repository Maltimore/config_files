#!/bin/bash

sed -e "/^#\\|^\$/d" <<'EOF' | while read V;do ln -sfT "$HOME/.config/$V" "$HOME/.$V";done

ackrc
bash_aliases
bash_profile
bashrc
condarc
pythonrc.py
screenrc
tmux.conf
vimrc
EOF

