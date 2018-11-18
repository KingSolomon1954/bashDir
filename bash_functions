# --------------------------------------------------

f()
{
    find . -name "$*" -print |& grep -iv "Permission Denied"
}

# --------------------------------------------------

lsd()
{
    if [ $# -eq 0 ]; then
        ls -d --color=auto */
    else
        ls -d --color=auto $1/*/
    fi
}

llsd()
{
    if [ $# -eq 0 ]; then
        ls -l -d --color=auto */
    else
        ls -l -d --color=auto $1/*/
    fi
}

# --------------------------------------------------
#
# cd to the path created by substituting $1 for $2 in ${PWD}
# Handy for working with parallel directory trees.
# Example: CurDir is /home/howie/arclight/branches/r3.2/hub/rtnms
# > cdsub r3.2 r3.0
# You are now in     /home/howie/arclight/branches/r3.0/hub/rtnms

cdsub()
{
    cd ${PWD/$1/$2}
}

# --------------------------------------------------

me()
{
    if [ ${OSTYPE} = "cygwin" ]; then
        if [ -f /cygdrive/c/Program\ Files/JASSPA/MicroEmacs/me32.exe ]; then
            /cygdrive/c/Program\ Files/JASSPA/MicroEmacs/me32 $(cygpath -i -w "$*") &
        elif [ -f /cygdrive/c/Program\ Files\ \(x86\)/JASSPA/MicroEmacs/me32.exe ]; then
            /cygdrive/c/Program\ Files\ \(x86\)/JASSPA/MicroEmacs/me32 $(cygpath -i -w "$*" ) &
        else
            echo "Cant find me executable in me() function"
        fi
    elif [ ${OSTYPE} = "linux-gnu" -o ${OSTYPE} = "linux" ]; then
        local xyz="$*"
        if [ "${xyz/-n}" != "${xyz}" -o "${DISPLAY}X" = "X" ]; then
            command me -n "$@"
        else
            command me "$@" &
        fi
    else
        echo "No such OSTYPE in me() function"
    fi
}

# --------------------------------------------------

findEmacs()
{
    if [ "X${emacsExec}" != "X" ]; then
        # emacsExec is already found
        return 0
    fi

    local listOfEmacsLocations="${HOME}/pkg/emacs-24.3/bin/emacs /usr/local/bin/emacs /usr/bin/emacs"

    for e in ${listOfEmacsLocations} ; do
        if [ -x "$e" ]; then
            emacsExec="$e"
            emacsClient="${e}client"
            return 0
        fi
    done

    echo "Unable to locate emacs executable in ${listOfEmacsLocations}" 1>&2
    return 1
}

# --------------------------------------------------

em()
{
    findEmacs
    if [ ${OSTYPE} = "cygwin" ]; then
        # On cygwin, apparently emacs doesn't see INFOPATH so you can't
        # "read the manual" from within emacs itself. If I supply INFOPATH
        # directly on the command line invocation then that works.
        INFOPATH=$(cygpath -w -p $INFOPATH) ${emacsExec} $(cygpath -i -w -- "$@" ) &
    else
        local xyz="$*"
        if [ "${xyz/-nw }" != "${xyz}" ]; then
            ${emacsExec} "$@"
        elif [ "X${DISPLAY}" = "X" ]; then
            ${emacsExec} -nw "$@"
        else
            ${emacsExec} -fh "$@" &
        fi
    fi
}

# --------------------------------------------------

emc()
{
    findEmacs
    local xyz="$*"
    if [ "${xyz/-nw }" != "${xyz}" ]; then
        ${emacsClient} "$@"
    elif [ "X${DISPLAY}" = "X" ]; then
        ${emacsClient} -nw "$@"
    else
        ${emacsClient} -c -fh "$@" &
    fi
}

# --------------------------------------------------

emdaemon()
{
    findEmacs
    rm -f ~/.emacs.desktop.lock ~/.emacs.d/.emacs.desktop.lock
    (cd ~ && ${emacsExec} --daemon)
}

# --------------------------------------------------

tree()
{
    local tmpFile=/tmp/tree$$
    find . -type d -print > ${tmpFile}
    local topDir=$(pwd)
    trap 'rm -f ${tmpFile}; cd ${topDir}' 2 15
    while read dir; do
        local dir="cd ${dir// /\\ }"
        eval "${dir}"
        echo -e "\E[0m\E[36m ${PWD}:\E[0m"
        eval $*
        cd "${topDir}"
    done < ${tmpFile}
    rm ${tmpFile}
}

# tree ()
# {
#     top_dir=$(pwd)
#     for dir in $(find . ! -name CVS -type d -print) ; do
#         cd $dir
#         echo $(pwd):
#         "$@"
#         cd $top_dir
#     done
# }

# --------------------------------------------------

start()	# run command in background, redirect std out/error
{
    if [ -d ~/log ]; then
        local logDir=~/log
    elif [ -d ~/tmp ]; then
        local logDir=~/tmp
    else
        local logDir=/tmp
    fi
    "$@" > ${logDir}/logfile 2>&1 &
}

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
    if [ $# -ne 1 ]; then
        echo "Supply the name of an environment variable"
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
    case "$TERM" in
    *term* | rxvt)
        echo -en  "\e]0;$*\a" ;;
    *)  ;;
    esac
}

# --------------------------------------------------

# Up "n" directory levels
# Defaults to 1 if no arg is supplied.

up ()
{

    local ups=${1:-1}
    while [[ $ups -gt 0 ]] ; do
        local upstring="${upstring}../"
        ups=$(($ups - 1))
    done
    cd $upstring
}

# --------------------------------------------------
