# .bash_profile
#
# This file is sourced only for a login shell.
# Called after /etc/profile runs.
# Its purpose is to start programs that only
# need to run once such as an xserver or
# ssh_agent. Also good to define initial
# values for environment variables here.

# Setup PATHs

if [ -f ~/.bashdir/bash_paths ]; then
    . ~/.bashdir/bash_paths
fi

# Now we source .bashrc. The .bashrc contains stuff
# we want for all interactive shells. This login shell
# is most certainly an interactive shell but the
# the bash system leaves it to us for a login shell.
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

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
}

sshCheckDisplay

unset sshSetDisplay
unset sshCheckDisplay
