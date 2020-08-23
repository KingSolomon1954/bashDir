# -----------------------------------------------------------
#
# Setup for Node.js programming
#
# -----------------------------------------------------------

export NODEJS_HOME="/opt/nodejs/node-v10.15.1/bin"
if [ ! -d ${NODEJS_HOME} ]; then
    unset NODEJS_HOME
else
    envp.append PATH $NODEJS_HOME
fi
