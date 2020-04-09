# -----------------------------------------------------------
#
# Setup for ANT
#
# -----------------------------------------------------------

if isCygwin; then
    export ANT_HOME="${HOME}/opt/apache-ant-1.9.4"
    if [ ! -d ${ANT_HOME} ]; then
        unset ANT_HOME
    else
        appendToPath "${ANT_HOME}/bin"
    fi
fi
    
# -----------------------------------------------------------
