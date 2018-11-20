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

bd="${HOME}/.bashdir"

# --------------------------------------------------

[[ -f "${bd}/bash_options" ]] && source "${bd}/bash_options"

# --------------------------------------------------

[[ -f ~/.bashdir/bash_aliases ]] && source "${bd}/bash_aliases"

# --------------------------------------------------

[[ -f ${bd}/bash_functions ]] && source ${bd}/bash_functions

# --------------------------------------------------

# Include cd history features after cd alias is defined.

[[ -f ${bd}/cd_history ]] && source ${bd}/cd_history

# --------------------------------------------------

[[ -f ${bd}/my_dir_colors ]] && eval "$(dircolors -b ${bd}/my_dir_colors)"

# --------------------------------------------------

[[ -f ${bd}/bash_programming ]] && source ${bd}/bash_programming

# --------------------------------------------------

[[ -f ${bd}/bash_${TESTABLE_OSTYPE} ]] && source ${bd}/bash_${TESTABLE_OSTYPE}

unset TESTABLE_OSTYPE

# --------------------------------------------------

unset bd

# end file
