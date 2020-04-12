# -----------------------------------------------------------
#
# Define environment variable holding path to my shell library
#
export BASH_LIB=$HOME/lib/shellLib

# -----------------------------------------------------------
#
# Function to source shell library functions
#
import ()
{
    if ! source "${BASH_LIB}/$1"; then
        if [ ! -d "${BASH_LIB}" ]; then
            echo "[ERROR] BASH_LIB ${BASH_LIB} does not exist" && exit 1
        fi
    fi
}
export -f import

# -----------------------------------------------------------


