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

# Preserve original .bash_profile for reference
if [ ! -L "$HOME/.bash_profile" ]; then
    if [ -e "$HOME/.bash_profile" ]; then
        mv "$HOME/.bash_profile" "$HOME/.bash_profile.org"
    fi
fi

# ln -s              TARGET       LINK_NAME
symlinkFile $(pwd)/bash_profile $HOME/.bash_profile
