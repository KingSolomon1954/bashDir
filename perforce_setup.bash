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

if [ -f /Applications/Perforce/p4merge.app/Contents/MacOS/p4merge ]; then
    alias gdiff="/Applications/Perforce/p4merge.app/Contents/MacOS/p4merge"
fi

if [ -f /Applications/p4merge.app/Contents/MacOS/p4merge ]; then
    alias gdiff="/Applications/p4merge.app/Contents/MacOS/p4merge"
    alias p4merge="/Applications/p4merge.app/Contents/MacOS/p4merge"
fi

# -----------------------------------------------------------

