# Define our own OSTYPE along with some simple functions
# that efficiently test for OS type.
#
# Upon exiting this file:
#
#    TESTABLE_OSTYPE is in the environment
#
# --------------------------------------------------

setupOsType()
{
    if echo ${OSTYPE} | grep -q -i "darwin" ; then
        TESTABLE_OSTYPE="darwin"
    elif echo ${OSTYPE} | grep -q -i "linux" ; then
        TESTABLE_OSTYPE="linux"
    elif echo ${OSTYPE} | grep -q -i "cygwin"; then
        TESTABLE_OSTYPE="cygwin"
    else
        TESTABLE_OSTYPE="unknown"
        echo "Unhandled OSTYPE in file: os.bash"
    fi
}

# --------------------------------------------------

isOsType()
{
    [[ "$1" == "$TESTABLE_OSTYPE" ]]
}

# --------------------------------------------------

isMac()
{
    isOsType "darwin"
}

# --------------------------------------------------

isLinux()
{
    isOsType "linux"
}

# --------------------------------------------------

isCygwin()
{
    isOsType "cygwin"
}

# --------------------------------------------------

setupOsType
