# --------------------------------------------------
#
# Deal with command line stuff and prompt
#
# --------------------------------------------------

# Prompt
#
# Dark text with dull blueish background
# See https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
#
PS1="\e[38;5;16;48;5;23m\u@\h:\w>\e[0m\n"

set completion-ignore-case on
#       If set to On, readline performs filename matching and completion
#       in a case-insensitive fashion.

set -o notify
#       If set, bash reports terminated background jobs immedi-
#       ately,  rather  than  waiting until before printing the
#       next primary prompt.

# Remap some keys
#
bind '"\C-l": kill-word'
bind '"\C-j": backward-char'
bind '"\C-g": forward-word'
bind '"\C-h": backward-word'
bind '"\C-i": complete'

# --------------------------------------------------
#
# Directory colors 
#
if [ -f ~/.bashdir/my_dir_colors ]; then
    eval "$(dircolors -b ~/.bashdir/my_dir_colors)"
fi

# --------------------------------------------------

sourceIt /usr/local/etc/bash_completion.d/brew

# --------------------------------------------------
