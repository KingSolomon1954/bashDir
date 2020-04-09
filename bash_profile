# .bash_profile
#
# This file is sourced only for a login shell.
# Called after /etc/profile runs.
# Its purpose is to start programs that only
# need to run once such as an xserver or
# ssh_agent. Also good to define initial
# values for environment variables here.

# Setup PATHs

[[ -f ${HOME}/.bashdir/path_setup.bash ]] && source ${HOME}/.bashdir/path_setup.bash

# Now we source .bashrc. The .bashrc contains stuff
# we want for all interactive shells. This login shell
# is most certainly an interactive shell but the
# the bash system leaves it to us for a login shell.
#
[[ -f ${HOME}/.bashrc ]] && source ${HOME}/.bashrc

# Allow developer group to read/write files
# umask -S g+rwx >> /dev/null

# --------------------------------------------------------

sshSetDisplay()
{
    export DISPLAY=${1}:0
    echo "DISPLAY set to $DISPLAY"
}

sshCheckDisplay()
{
    if [ ${HOSTNAME} = "vcaarclight01" ]; then
        if [ -n "${SSH_CLIENT}" ]; then
            if [ -z "${DISPLAY}" ]; then
                sshSetDisplay ${SSH_CLIENT}
            fi
        fi
    fi
    if [ ${HOSTNAME} = "vcabft02" ]; then
        if [ -n "${SSH_CLIENT}" ]; then
            if [ -z "${DISPLAY}" ]; then
                sshSetDisplay ${SSH_CLIENT}
            fi
        fi
    fi
    if [ ${HOSTNAME} = "vcamss01" ]; then
        if [ -n "${SSH_CLIENT}" ]; then
            if [ -z "${DISPLAY}" ]; then
                sshSetDisplay ${SSH_CLIENT}
            fi
        fi
    fi
    if [ ${HOSTNAME} = "vcatpemd02" ]; then
        if [ -n "${SSH_CLIENT}" ]; then
            if [ -z "${DISPLAY}" ]; then
                sshSetDisplay ${SSH_CLIENT}
            fi
        fi
    fi
}

sshCheckDisplay

unset sshSetDisplay
unset sshCheckDisplay
