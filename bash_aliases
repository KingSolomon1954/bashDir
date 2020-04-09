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
    if type -p xdg-open > /dev/null; then
        alias open=xdg-open
    fi
elif [ "${TESTABLE_OSTYPE}" = "darwin" ]; then
    :
else
    echo "Unhandled TESTABLE_OSTYPE in file: bash_aliases"
fi

# Figure out an alias for info command because we need to use
# -d args to specify info directories. Tried using INFOPATH
# but it seems INFOPATH does not honor order in a predictable way.
#
# Order matters, later dirs override earlier dirs
t_infoDirs+=" /usr/local/opt/findutils/share/info"
t_infoDirs+=" /usr/share/info"
t_infoDirs+=" /Applications/Emacs.app/Contents/Resources/info"
t_infoDirs+=" ${HOME}/pkg/emacs-24.3/info"
t_infoDirs+=" ${HOME}/info"
t_infoDirs+=" /usr/local/opt/gettext/share/info"
t_infoDirs+=" /usr/local/opt/findutils/share/info"
t_infoDirs+=" /usr/local/share/info"

for i in ${t_infoDirs}; do
    if [ -d $i ]; then
        t_infoDirsReal+=" -d $i"
    fi
done

if [ "${t_infoDirsReal}" != ""  ]; then
    alias info="command info ${t_infoDirsReal}"
fi
unset -v t_infoDirs
unset -v t_infoDirsReal
