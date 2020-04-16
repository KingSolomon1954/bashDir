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

sourceIt ()
{
    if [ -f $1 ]; then
        source $1
    fi
}

# --------------------------------------------------

_bd="${HOME}/.bashdir"

sourceIt "${_bd}/os_setup.bash"
sourceIt "${_bd}/file_ops.bash"
sourceIt "${_bd}/command_line.bash"
sourceIt "${_bd}/history.bash"
sourceIt "${_bd}/directory_ops.bash"
sourceIt "${_bd}/cdlist.bash"
sourceIt "${_bd}/less_ops.bash"
sourceIt "${_bd}/env_ops.bash"
sourceIt "${_bd}/info_ops.bash"
sourceIt "${_bd}/man_ops.bash"
sourceIt "${_bd}/bash_scripting.bash"
sourceIt "${_bd}/emacs_setup.bash"
sourceIt "${_bd}/perforce_setup.bash"
sourceIt "${_bd}/git_setup.bash"
sourceIt "${_bd}/c++_setup.bash"
sourceIt "${_bd}/java_setup.bash"
sourceIt "${_bd}/ant_setup.bash"
sourceIt "${_bd}/maven_setup.bash"
sourceIt "${_bd}/nodejs_setup.bash"
sourceIt "${_bd}/vsc_setup.bash"
sourceIt "${_bd}/android_setup.bash"
sourceIt "${_bd}/docker_setup.bash"

# --------------------------------------------------

unset _bd
unset sourceIt
