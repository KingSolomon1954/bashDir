# --------------------------------------------------
#
# Handle dotfiles using Git
#
# --------------------------------------------------

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# See https://www.atlassian.com/git/tutorials/dotfiles
#
# On new host:
#
# alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# cd ${HOME}; echo ".dotfiles" > .gitignore
# git clone --bare git@github.com:KingSolomon1954/dotfiles.git ${HOME}/.dotfiles
# dotfiles checkout
#
#
# Fresh start
#
# git init --bare $HOME/.dotfiles
# alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# dotfiles config --local status.showUntrackedFiles no
# cd .dotfiles && echo ".dotfiles" > .gitignore
