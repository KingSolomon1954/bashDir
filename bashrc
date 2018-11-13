# .bashrc
#
# This file is sourced for interactive shells.
# Called after /etc/bash.bashrc runs.
# And we source it ourselves directly from
# .bash_profile in the case of a login shell.

# If we have our startup files right, then it
# isn't necessary to check for an interactive
# shell, but we'll check anyway since these startup 
# files are confusing and many folks get it wrong.
#
[[ "$-" != *i* ]] && return

# --------------------------------------------------

if [ -f ~/.bashdir/bash_options ]; then
    . ~/.bashdir/bash_options
fi

# --------------------------------------------------

if [ -f ~/.bashdir/bash_aliases ]; then
    . ~/.bashdir/bash_aliases
fi

# --------------------------------------------------

if [ -f ~/.bashdir/bash_functions ]; then
    . ~/.bashdir/bash_functions
fi

# --------------------------------------------------

# Include cd history features after cd alias is defined.
if [ -f ~/.bashdir/cd_history ]; then
    . ~/.bashdir/cd_history
fi

# --------------------------------------------------

# Show dirs as magenta instead of the default blue
if [ -f ~/.bashdir/dir_colors_howie ]; then
    eval "`dircolors -b ~/.bashdir/dir_colors_howie`"
fi

# --------------------------------------------------

if [ -f ~/.bashdir/bash_programming ]; then
    . ~/.bashdir/bash_programming
fi

# --------------------------------------------------

if [ -f ~/.bashdir/bash_${TESTABLE_OSTYPE} ]; then
    . ~/.bashdir/bash_${TESTABLE_OSTYPE}
fi

unset TESTABLE_OSTYPE

# --------------------------------------------------

# end file
