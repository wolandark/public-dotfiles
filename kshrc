# Set the size of the history file
HISTFILE="$HOME/.ksh_history"
HISTSIZE=1000
# Save the history after each command
# set -o history

# Use arrow keys to navigate the command history
alias __A=$(print '\0020') && alias __B=$(print '\0016') && alias __C=$(print '\0006') && alias __D=$(print '\0002')

# Set backspace
stty erase ^?

export EDITOR=vim
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin
set -o emacs
keybd_trap () {
  case ${.sh.edchar} in
    $'\f')    .sh.edchar=$'\e\f';;  # clear-screen (THIS QUESTION)
    $'\e[1~') .sh.edchar=$'\001';;  # Home = beginning-of-line
    $'\e[4~') .sh.edchar=$'\005';;  # End = end-of-line
    $'\e[5~') .sh.edchar=$'\e>';;   # PgUp = history-previous
    $'\e[6~') .sh.edchar=$'\e<';;   # PgDn = history-next
    $'\e[3~') .sh.edchar=$'\004';;  # Delete = delete-char
  esac
}
trap keybd_trap KEYBD
# Set the default umask
umask 022
# Set the default language to English
export LANG=en_US.UTF-8

# Enable autocd, so you can change to a directory by typing its name
# set -o autocd

# Set up aliases
#alias ls='ls -F --color=always'
#alias ll='ls -lh --color=always''
#alias grep='grep --color=always'
#alias ..='cd ..'
#alias ...='cd ../..'
#alias X='exit'
alias t='tree'

. $HOME/.aliases

#┌───┐
#│PS1│
#└───┘
function _cd {
  \cd "$@"
	PS1='${COLOR_GREEN}${RELATIVE_PWD} \$: ${COLOR_RESET}'
}

function RELATIVE_PWD.get {
    if [ "${PWD:0:${#HOME}}" = "$HOME" ]
    then
            .sh.value="~${PWD:${#HOME}}"
    else
            .sh.value="$PWD"
    fi
}
alias cd=_cd

# Set up colors
COLOR_GREEN=$(print '\033[32m')    # Green color
COLOR_RESET=$(print '\033[0m')     # Reset color

# Define PS1 with colors
PS1='${COLOR_GREEN}${RELATIVE_PWD} \$: ${COLOR_RESET}'


# PS1='! echo -e "\033[35m ${RELATIVE_PWD} \$ '
# function _cd {
#   \cd "$@"
#   PS1=$(
#     print -n "$LOGNAME@$HOSTNAME:"
#     if [[ "${PWD#$HOME}" != "$PWD" ]]; then
#       print -n "~${PWD#$HOME}"
#     else
#       print -n "$PWD"
#     fi
#     print "$ "
#   )
# }

