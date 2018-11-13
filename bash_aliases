bind '"\C-l": kill-word'
bind '"\C-j": backward-char'
bind '"\C-g": forward-word'
bind '"\C-h": backward-word'
bind '"\C-i": complete'

alias u='cd ..'
alias b='cd -'

alias  l='ls       -F --color=auto --group-directories-first'
alias  L='ls -lsa  -F --color=auto --group-directories-first'
alias LL='ls -lsai -F --color=auto --group-directories-first'

alias  grep=' grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff2columns='diff --side-by-side --suppress-common-lines'

alias shutdown='/sbin/shutdown -h now'

if [ "${TESTABLE_OSTYPE}" = "cygwin" ]; then
    alias startx='startxwinhowie > ${HOME}/log/startx.log 2>&1'
    export DISPLAY=:0
elif [ "${TESTABLE_OSTYPE}" = "linux" ]; then
    :
elif [ "${TESTABLE_OSTYPE}" = "darwin" ]; then
    :
else
    echo "Unhandled TESTABLE_OSTYPE in file: bash_aliases"
fi
