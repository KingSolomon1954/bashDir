# Setup for directory operations
#
# --------------------------------------------------

# change to dirs without specifying cd
shopt -s autocd

alias   b='cd -'
alias   u='cd ..'
alias  uu='cd ../..'
alias uuu='cd ../../..'

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

# --------------------------------------------------

llsd()
{
    if [ $# -eq 0 ]; then
        ls -l -d --color=auto */
    else
        ls -l -d --color=auto $1/*/
    fi
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
