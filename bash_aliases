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

alias shutdown='/sbin/shutdown -h now'

alias m=' make TGT=linux-x86'
alias md='make TGT=linux-x86 CXXDEBUG="-ggdb -DGDEBUG"'

if [ ${OSTYPE} = "cygwin" ]; then
    alias startx='startxwinhowie > ${HOME}/log/startx.log 2>&1'
    export DISPLAY=:0
elif [ ${OSTYPE} = "linux-gnu" -o ${OSTYPE} = "linux"  ]; then
    :
else
    echo "Unhandled OSTYPE in file: bash_aliases"
    # alias startx='command startx > ${HOME}/log/startx.log 2>&1'
fi
