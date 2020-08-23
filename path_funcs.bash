# --------------------------------------------------
#
# Functions that manipulate PATH and PATH-like variables
#
# --------------------------------------------------
#
# Does $1 appear in $2 (uses PATH if no $2).
# Returns 0 (success) if found otherwise 1 (fail).
# $2 is a path style variable with ":" separating
# individual elements.
#
isInPath()
{
    eval local -r v=\$${2-PATH}
    case ":${v}:" in
        *":$1:"*) return 0;;  # Found
        *)        return 1;;  # Not found
    esac
}

# --------------------------------------------------
#
# Append $1 to $2 (uses PATH if no $2) as long as
# $1 is not already in the path variable and the 
# directory physically exists. $2 is a path style
# variable with ":" separating individual elements.
#
appendToPath ()
{
    if ! isInPath "$@" ; then
        if [ -d "$1" ]; then
            eval ${2:-PATH}="\$${2:-PATH}:\"$1\""
            colonTrimPath ${2:-PATH}
        fi
    fi
}

# --------------------------------------------------
#
# Prepend $1 to $2 (uses PATH if no $2) as long as
# $1 is not already in the path variable and the 
# directory physically exists. $2 is a path style
# variable with ":" separating individual elements.
#
prependToPath ()
{
    if ! isInPath "$@" ; then
        if [ -d "$1" ]; then
            eval ${2:-PATH}="\"$1\":\$${2:-PATH}"
            colonTrimPath ${2:-PATH}
        fi
    fi
}

# --------------------------------------------------
#
# Delete $1 from $2 (uses PATH if no $2).
# $2 is a path style variable with ":" separating
# individual elements.
#
deleteFromPath ()
{
    eval ${2:-PATH}="\${${2:-PATH}//'$1'/}"  # Sub it out
    colonTrimPath ${2:-PATH}
}

# --------------------------------------------------

colonTrimPath ()
{
    local d="${1:-PATH}"
    eval ${d}=\${${d}//::/:}  # Clean up double colons
    eval ${d}=\${${d}#:}      # Clean up first colon
    eval ${d}=\${${d}%:}      # Clean up trailing colon
}

# --------------------------------------------------
