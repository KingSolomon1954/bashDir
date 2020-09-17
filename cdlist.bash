# -----------------------------------------------------------------
#
# Functions that implement a handy goto directory capability.
#
# Allows easy CD'ing across a list of directories that you have chosen
# to remember.
#
# Issue "cdl" to show a list of numbered directories. To cd to a listed
# directory, issue "cdg <n>" where n corresponds to an item on the list,
# or if n is not given then cd to the 1st item on the list.
#
#    cdl       - display list of remembered directories
#    cdh       - alias for cdl (cd history)
#    cda [dir] - add <dir> to directory list [default is cur dir]
#    cdd [n]   - delete dir <n> from directory list [default is 1]
#    cdg [n]   - change to directory <n> [default is 1]
#    cdw [<filename>] - save/write directory list to file
#    cdr [<filename>] - init/read directory list from file
#
# If <filename> is not given, then filename defaults to
# $HOME/.cdlist.cdl. If <filename> is a "?", then filenames matching
# $HOME/.*.cdl are presented to you to choose from.
#
# No arbitrary limit on size of list.
# Source this file into the environment.
#
# -----------------------------------------------------------------

declare -a CD_LIST

# -----------------------------------------------------------------
#
# cd list. List out remembered directories
#
cdl()
{
    if _isCdListEmpty; then return; fi

    local -i cnt=${#CD_LIST[@]}
    for (( i = 0 ; i < cnt ; i++ )); do
        local -i j=${i}+1
        echo "$j ${CD_LIST[$i]}"
    done
}

# -----------------------------------------------------------------
#
# cd add. Add specified or current directory to CD list.
#
cda()
{
    local dir="${1:-$(pwd)}"
    [[ "${dir}" = "." ]] && dir="$(pwd)"
    if [ ! -d "${dir}" ] || [ ! -x "${dir}" ]; then
        echo "No such directory: ${dir}"
        return 1
    fi

    local -a tArray=( "${dir}" )
    # Append two arrays to a third. New dir is always first.
    CD_LIST=( ${tArray[@]} ${CD_LIST[@]} )
}

# -----------------------------------------------------------------
#
# cd delete. Removed first or specified directory.
#
cdd()
{
    if _isCdListEmpty; then return; fi
    
    local -i arg1=${1:-1}              # if no arg then use value of 1 
    if ! _isCdListArgValid ${arg1}; then
        return
    fi

    local -a tArray=( ${CD_LIST[@]} )  # work with a copy
    tArray[ (( arg1-1 )) ]=":"         # mark for deletion, zero based

    CD_LIST=()                         # Empty it
    local -i cnt=0
    for i in "${tArray[@]}"; do        # Reconstruct it
        [[ "$i" = ":" ]] && continue
        CD_LIST[$cnt]="$i"
        (( cnt++ ))
    done
}

# -----------------------------------------------------------------
#
# cd goto. Go to first or specified directory.
#
cdg()
{
    if _isCdListEmpty; then return; fi

    local -i arg1=${1:-1}              # use value of 1 if no arg 1
    if ! _isCdListArgValid $arg1; then
        return
    fi
    cd "${CD_LIST[ (( arg1-1 )) ]}"    # zero based
}

# -----------------------------------------------------------------
#
# cd write. Write out remembered directories to a file.
#
cdw()
{
    if _isCdListEmpty; then return; fi

    local f="$(_whichCdListFile $1)"

    rm -f "${f}"
    for entry in "${CD_LIST[@]}"; do 
        echo "${entry}" >> "${f}"
    done
    echo "Wrote file: ${f}"
}

# -----------------------------------------------------------------
#
# cd read. Read in remembered directories from a file.
#
cdr()
{
    local f="$(_whichCdListFile $1)"
    
    if [ ! -f "${f}" ]; then
        echo "No CD list file: ${f}"
        return 1
    fi

    CD_LIST=()
    local -i cnt=0
    local entry
    while read entry; do
        CD_LIST[$cnt]="${entry}"
        (( cnt++ ))
    done < "${f}"
}

# -----------------------------------------------------------------

_isCdListEmpty()
{
    if [[ ${#CD_LIST[@]} = 0 ]]; then
        echo "CD list is empty"
        return 0      # return true
    fi
    return 1          # return false

}

# -----------------------------------------------------------------

_isCdListArgValid()
{
    if (( $1 < 1  )) || (( $1 > ${#CD_LIST[@]} )); then
        echo "No such element: $1"
        return 1      # return false
    fi
    return 0          # return true
}

# -----------------------------------------------------------------

_whichCdListFile()
{
    local defaultListFile="${HOME}/.cdlist.cdl"
    local listFile=${1:-${defaultListFile}}
    if [ "${listFile}" = "?" ]; then
        PS3='Which CD list file? '
        local f
        select f in ${HOME}/.*.cdl; do
           if [ -n "${f}" ]; then
               listFile="${f}"
               break;
           fi
        done
    fi
    echo "${listFile}"
}

# -----------------------------------------------------------------

alias cdh=cdl

# end file
