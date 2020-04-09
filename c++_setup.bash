# -----------------------------------------------------------
#
# Setup for C++ programming
#
# -----------------------------------------------------------

alias  m="make TGT=cygwin-x86"
alias md="make TGT=cygwin-x86 CXXDEBUG=\"-ggdb -DGDEBUG\""
alias mo="make TGT=cygwin-x86 CXXDEBUG=\"-O3 -DNDEBUG\""

# -----------------------------------------------------------

# FIGNORE=.o
#       A colon-separated list of suffixes to ignore when  per-
#       forming filename completion. A filename whose suffix
#       matches one of the entries in FIGNORE is excluded from
#       the list of matched filenames.
#       A sample value is ``.o:~''.

# Prefer to see .o's these days. So commented out.

# if ! isInPath .o FIGNORE; then
#     FIGNORE+=":.o"
# fi

# -----------------------------------------------------------
