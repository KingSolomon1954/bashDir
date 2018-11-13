#!/bin/bash
#
# Need to run this from the .bashdir directory
#
# Can't import on first setups - chicken and egg
# import won't yet be defined.
#
# ----------------------------------------------

# Local helper function
symlinkFile ()
{
    local target="$1"
    local linkName="$2"

    if [ ! -L "${linkName}" ]; then
        if [ -e "${linkName}" ]; then
            echo "[ERROR] ${linkName} exists but it's not a symlink. Please fix that manually" && exit 1
        else
            echo ln -s "${target}" "${linkName}"
                 ln -s "${target}" "${linkName}"
            echo "[OK] ${linkName} -> ${target}"
        fi
    else
        echo "[INFO] ${linkName} already symlinked"
    fi
}

# ----------------------------------------------

# Preserve original .bashrc for reference
if [ ! -L "$HOME/.bashrc" ]; then
    if [ -e "$HOME/.bashrc" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc.org"
    fi
fi

# link    TARGET    LINK_NAME
symlinkFile $(pwd)/bashrc $HOME/.bashrc

# ----------------------------------------------

# Preserve original .bash_profile for reference
if [ ! -L "$HOME/.bash_profile" ]; then
    if [ -e "$HOME/.bash_profile" ]; then
        mv "$HOME/.bash_profile" "$HOME/.bash_profile.org"
    fi
fi

# link    TARGET          LINK_NAME
symlinkFile $(pwd)/bash_profile $HOME/.bash_profile

# ----------------------------------------------
