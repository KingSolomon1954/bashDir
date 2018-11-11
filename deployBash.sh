#!/bin/bash
#
# Need to run this from the git dotfiles/bashdir directory

bashLoad symlinkFile

# Preserve original .bashrc for reference
if [ ! -L "$HOME/.bashrc" ]; then
    if [ -e "$HOME/.bashrc" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc.org"
    fi
fi

thisDir="$(pwd)"
upDir="$(cd .. && pwd)"

# ln -s              TARGET       LINK_NAME
symlinkFile $thisDir/bashrc       $HOME/.bashrc
symlinkFile $upDir/bashdir        $HOME/.bashdir
symlinkFile $thisDir/bash_profile $HOME/.bash_profile
