# -----------------------------------------------------------
#
# Setup the PATH
#
# -----------------------------------------------------------

# Read in path library helper functions
#
if [ -f ~/.bashdir/libPath.bash ]; then
    . ~/.bashdir/libPath.bash
fi

# Construct our PATH using functions from the environment
# variable path library. When using envp.append(), if the
# given directory does not exist on the file space, then PATH
# is left untouched. The function will alo prevent adding
# duplicates. With this behavior, the path for all OS's and
# hosts can be easily handled here without additional special
# OS tests.

# Standard system path setup here
#
envp.append PATH "/bin"
envp.append PATH "/usr/bin"
envp.append PATH "/usr/local/bin"
envp.append PATH "/sbin"
envp.append PATH "/usr/sbin"
envp.append PATH "/usr/local/sbin"
envp.append PATH "${HOME}/bin"
envp.delete PATH "/usr/games"
envp.delete PATH "/usr/local/games"

# Some platform specific setup

envp.prepend PATH "/usr/local/opt/openssl/bin"
envp.prepend PATH "/usr/local/opt/findutils/libexec/gnubin"
envp.prepend PATH "/usr/local/opt/coreutils/libexec/gnubin"
envp.prepend PATH "/usr/local/opt/grep/libexec/gnubin"

# More path setup later when bashrc runs
