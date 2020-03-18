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

tree()
{
    local tmpFile=/tmp/tree$$
    find . -type d -not -path "*.git*" -print  > ${tmpFile}
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

# Verify that a package is installed.
have()
{
    type "$1" > /dev/null 2>&1
}

# --------------------------------------------------
