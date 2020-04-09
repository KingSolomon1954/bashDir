# Setup shell history
#
# --------------------------------------------------

HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:ignorespace:erasedups
#       A colon-separated list of values controlling  how  commands  are
#       saved  on  the  history  list.   If  the list of values includes
#       ignorespace, lines which begin with a space  character  are  not
#       saved  in  the history list.  A value of ignoredups causes lines
#       matching the previous history entry to not be saved.  A value of
#       ignoreboth is shorthand for ignorespace and ignoredups.  A value
#       of erasedups causes all previous lines matching the current line
#       to  be  removed from the history list before that line is saved.
#       Any value not in the above list is ignored.  If  HISTCONTROL  is
#       unset,  or does not include a valid value, all lines read by the
#       shell parser are saved on the history list, subject to the value
#       of  HISTIGNORE.  The second and subsequent lines of a multi-line
#       compound command are not tested, and are added  to  the  history
#       regardless of the value of HISTCONTROL.

HISTIGNORE="?":"??":pwd:"cd ..":"man bash":groups:cdl:cda:cdd:cdg:cdl:cdr:cdw
#       A  colon-separated list of patterns used to decide which command
#       lines should be saved on the  history  list.   Each  pattern  is
#       anchored  at  the  beginning of the line and must match the com‐
#       plete line (no implicit  `*'  is  appended).   Each  pattern  is
#       tested  against  the line after the checks specified by HISTCON‐
#       TROL are applied.  In  addition  to  the  normal  shell  pattern
#       matching characters, `&' matches the previous history line.  `&'
#       may be escaped using  a  backslash;  the  backslash  is  removed
#       before attempting a match.  The second and subsequent lines of a
#       multi-line compound command are not tested, and are added to the
#       history  regardless  of  the  value  of HISTIGNORE.  The pattern
#       matching honors the setting of the extglob shell option.

# append to the history file, don't overwrite it
shopt -s histappend

shopt -s cmdhist
#       If set, bash attempts to save all lines of  a  multiple-
#       line  command  in  the  same history entry.  This allows
#       easy re-editing of multi-line commands.
