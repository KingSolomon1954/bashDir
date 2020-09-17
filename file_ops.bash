# --------------------------------------------------
#
# Setup for file operations
#
# --------------------------------------------------

if type exa > /dev/null 2>&1 > /dev/null; then
    alias  l='exa      -F              --group-directories-first'
    alias  L='exa -la  -F              --group-directories-first'
    alias LL='exa -lag -F              --group-directories-first'
else
    alias  l='ls       -F --color=auto --group-directories-first'
    alias  L='ls -lsa  -F --color=auto --group-directories-first'
    alias LL='ls -lsai -F --color=auto --group-directories-first'
fi

alias  grep=' grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias diff2columns='diff --side-by-side --suppress-common-lines'

# --------------------------------------------------

fileExists()
{
    [[ -f $1 ]]
}

# --------------------------------------------------

li()
{
    local choices="size-largest size-smallest "
    choices="${choices} modified-newest modified-oldest"
    choices="${choices} created-newest created-oldest"
    choices="${choices} accessed-newest accessed-oldest"
    choices="${choices} extension extension-reverse"
    local arg1=""
    local arg2=""
    local arg3=""
    PS3="Sort by (ctrl-d to abort): ";
    local SAVE_IFS=${IFS};
    IFS=' '
    trap 'echo -e "\nPress ctrl-d to abort"' SIGINT;
    select d in ${choices};
    do
        case $d in
            size-largest)
                arg1=size
                arg2=modified
                arg3=--reverse
                ;;
            size-smallest)
                arg1=size
                arg2=modified
                arg3=
                ;;
            modified-newest)
                arg1=modified
                arg2=modified
                arg3=--reverse
                ;;
            modified-oldest)
                arg1=modified
                arg2=modified
                arg3=
                ;;
            created-newest)
                arg1=created
                arg2=created
                arg3=--reverse
                ;;
            created-oldest)
                arg1=created
                arg2=created
                arg3=
                ;;
            accessed-newest)
                arg1=accessed
                arg2=accessed
                arg3=--reverse
                ;;
            accessed-oldest)
                arg1=accessed
                arg2=accessed
                arg3=
                ;;
            extension)
                arg1=extension
                arg2=modified
                arg3=
                ;;
            extension-reverse)
                arg1=extension
                arg2=modified
                arg3=--reverse
                ;;
            *)
                echo "Invalid selection."
                echo
                ;;
        esac
        if [ -n "${REPLY}" ]; then
            echo exa -la --sort ${arg1} -t ${arg2} ${arg3} -F --group-directories-first $@
                 exa -la --sort ${arg1} -t ${arg2} ${arg3} -F --group-directories-first $@
            break
        fi
    done;
    
    IFS=${SAVE_IFS};
    trap SIGINT    
}
