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

_bd="${HOME}/.bashdir"

# --------------------------------------------------

[[ -f "${_bd}/bash_options" ]] && source "${_bd}/bash_options"

# --------------------------------------------------

[[ -f ~/.bashdir/bash_aliases ]] && source "${_bd}/bash_aliases"

# --------------------------------------------------

[[ -f ${_bd}/bash_functions ]] && source ${_bd}/bash_functions

# --------------------------------------------------

[[ -f ${_bd}/emacs_functions ]] && source ${_bd}/emacs_functions

# --------------------------------------------------

# Include cd history features after cd alias is defined.

[[ -f ${_bd}/cd_history ]] && source ${_bd}/cd_history

# --------------------------------------------------

[[ -f ${_bd}/my_dir_colors ]] && eval "$(dircolors -b ${_bd}/my_dir_colors)"

# --------------------------------------------------

[[ -f ${_bd}/bash_programming ]] && source ${_bd}/bash_programming

# --------------------------------------------------

[[ -f ${_bd}/bash_${TESTABLE_OSTYPE} ]] && source ${_bd}/bash_${TESTABLE_OSTYPE}

unset TESTABLE_OSTYPE

# --------------------------------------------------

unset _bd

# end file
