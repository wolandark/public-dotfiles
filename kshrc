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

# Set the default umask
umask 022
# Set the default language to English
export LANG=en_US.UTF-8

# Enable autocd, so you can change to a directory by typing its name
# set -o autocd

# Set up aliases
alias ls='ls -F'
alias ll='ls -lh'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias X='exit'''

. $HOME/.aliases
function _cd {
  \cd "$@"
  PS1=$(
    print -n "$LOGNAME@$HOSTNAME:"
    if [[ "${PWD#$HOME}" != "$PWD" ]]; then
      print -n "~${PWD#$HOME}"
    else
      print -n "$PWD"
    fi
    print "$ "
  )
}

alias cd=_cd

