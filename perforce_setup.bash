# -----------------------------------------------------------
#
# Setup for Perforce 
#
# -----------------------------------------------------------

# If p4 in path then Perforce is installed.
#
if have p4; then
    export P4CONFIG=.p4config
fi

# -----------------------------------------------------------

if [ ! -z ${P4CONFIG+x} ]; then
    if isCygwin; then
        p4()
        {
            PWD=$(cygpath -aw .) command p4 "$@"
        }
    fi
fi

# -----------------------------------------------------------

if fileExists /Applications/Perforce/p4merge.app/Contents/MacOS/p4merge; then
    alias p4diff="/Applications/Perforce/p4merge.app/Contents/MacOS/p4merge"
fi

if fileExists /Applications/p4merge.app/Contents/MacOS/p4merge; then
    alias p4diff="/Applications/p4merge.app/Contents/MacOS/p4merge"
    alias p4merge="/Applications/p4merge.app/Contents/MacOS/p4merge"
fi

# -----------------------------------------------------------

