# -----------------------------------------------------------
#
# Setup for Java prgorammig
#
# -----------------------------------------------------------

if isCygwin; then
    export JAVA_HOME="/cygdrive/c/Program Files/Java/jdk1.7.0_60"
    # Needs to precede windows/system/java.exe
    envp.prepend PATH "${JAVA_HOME}/bin"
    if [ ! -d "${JAVA_HOME}" ]; then
        unset JAVA_HOME
    fi

    # export CLASSPATH="c:/howie/proj/craps/src/java/classes;c:/howie/pkg/junit3.8.1/junit.jar"
fi

# -----------------------------------------------------------

if isMac; then
    if [ -d /Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home ]; then
        export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home
    fi
fi

# -----------------------------------------------------------

envp.append PATH "${HOME}/pkg/java/jdk-9.0.4/bin"

# -----------------------------------------------------------

# FIGNORE=.class
#       A colon-separated list of suffixes to ignore when  per-
#       forming filename completion. A filename whose suffix
#       matches one of the entries in FIGNORE is excluded from
#       the list of matched filenames.
#       A sample value is ``.o:~''.

envp.setDirMustExist "false"
envp.append FIGNORE ".class"
envp.setDirMustExist "true"

# -----------------------------------------------------------
