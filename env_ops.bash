# --------------------------------------------------
#
# Environment related setup and operations
#
# --------------------------------------------------
#
unset MAILCHECK

# --------------------------------------------------
#
# Show each component of a path style variable on
# a separate line
#
# Example: envshow MANPATH

envls ()
{
    if [ $# -ne 1 ]; then
        echo "Supply the name of an environment variable"
        return 1
    fi

    # expand the variable's contents
    local varData=$(eval echo "\${$1}")

    # upon output, substitute a new line for each ":"
    echo -e ${varData//:/'\n'}
}

# --------------------------------------------------
#
# Interactively removes a component of a PATH style
# variable. Lists and prompts for the component to
# remove.
#
# Example: envrm PATH
#
# Assumes deleteFromPath() function is in the
# environment.
# 
# Programming note: regarding SIGINT trap.
# Interesting to note that trapping ctrl-c during
# the select command does indeed catch ctrl-c,
# however it does not break out of the select
# loop as I expected. The loop continues, and the
# user must use ctrl-d to exit. So I coded the 
# ctrl-c trap to tell the user to use ctrl-d. 
# Maybe there's a way from within the ctrl-c trap 
# to force the select loop to exit but I couldn't
# figure it out.

envrm ()
{
    if ! type -t deleteFromPath > /dev/null 2>&1; then
        echo "[ERROR] shell function deteFromPath() is undefined"
        return 1
    fi

    if [ $# -ne 1 ]; then
        echo "Please supply the name of an environment variable"
        return 1
    fi

    local entries="$(eval echo \$${1})"

    PS3="Component to remove from \${${1}} (ctrl-d to abort): "
    local SAVE_IFS=${IFS}; IFS=:
    trap 'echo -e "\nPress ctrl-d to abort"' SIGINT
    select d in ${entries} ; do
        if [ $d ]; then
            deleteFromPath $d $1
            break
        else
            echo "Invalid selection."
            echo
        fi
    done

    IFS=${SAVE_IFS}
    trap SIGINT   # undo the trap
}

# --------------------------------------------------

# Set passed in string as the title on the terminal 

title()
{
    if [[ -z "$ORIG_PS1" ]]; then
        ORIG_PS1="$PS1"
    fi
    TITLE="\[\e]2;$*\a\]"
    PS1="${ORIG_PS1}${TITLE}"

#    case "$TERM" in
#    *term* | rxvt)
#        echo -en  "\e]0;$*\a" ;;
#    *)  ;;
#    esac
}

# --------------------------------------------------

start()	# run command in background, redirect std out/error
{
    if [ -d ~/admin/logs ]; then
        local logDir=~/admin/logs
    elif [ -d ~/tmp ]; then
        local logDir=~/tmp
    else
        local logDir=/tmp
    fi
    "$@" > ${logDir}/logfile 2>&1 &
}

# --------------------------------------------------

alias shutdown='/sbin/shutdown -h now'

# --------------------------------------------------

# Verify that a package is installed.
have()
{
    type "$1" > /dev/null 2>&1
}

# --------------------------------------------------

if isCygwin; then
    alias startx='startxwinhowie > ${HOME}/log/startx.log 2>&1'
    export DISPLAY=:0
fi

# --------------------------------------------------

if have xdg-open ; then
    alias open=xdg-open
fi

# --------------------------------------------------

sourceIt /usr/local/etc/bash_completion.d/brew

