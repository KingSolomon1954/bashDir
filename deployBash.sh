#!/bin/bash
#
# Need to run this from the .bashdir directory

bashLoad symlinkFile

# Preserve original .bashrc for reference
if [ ! -L "$HOME/.bashrc" ]; then
    if [ -e "$HOME/.bashrc" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc.org"
    fi
fi

# ln -s              TARGET       LINK_NAME
symlinkFile $(pwd)/bashrc       $HOME/.bashrc
symlinkFile $(pwd)/bash_profile $HOME/.bash_profile
