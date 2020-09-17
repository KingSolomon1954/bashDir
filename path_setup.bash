# -----------------------------------------------------------
#
# Setup the PATH
#
# -----------------------------------------------------------

# Read in our path helper functions
#
if [ -f ~/.bashdir/path_funcs.bash ]; then
    . ~/.bashdir/path_funcs.bash
fi

# Using appendToPath, if the given directory does not exist on 
# the file space, then PATH is left untouched. Also disallows 
# duplicates. Therefore all paths for all OS's and hosts can be
# handled here without special OS tests.

# Standard system path setup here
#
appendToPath   "/bin"
appendToPath   "/usr/bin"
appendToPath   "/usr/local/bin"
appendToPath   "/sbin"
appendToPath   "/usr/sbin"
appendToPath   "/usr/local/sbin"
appendToPath   "${HOME}/bin"
deleteFromPath "/usr/games"
deleteFromPath "/usr/local/games"

# Some platform specific setup

prependToPath  "/usr/local/opt/m4/bin"
prependToPath  "/usr/local/opt/openssl/bin"
prependToPath  "/usr/local/opt/findutils/libexec/gnubin"
prependToPath  "/usr/local/opt/coreutils/libexec/gnubin"
prependToPath  "/usr/local/opt/grep/libexec/gnubin"
prependToPath  "/usr/local/opt/make/libexec/gnubin"

# More path setup later when bashrc runs
