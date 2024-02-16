# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $(pgrep startx) = '' ]] && [[ "$(tty)" = "/dev/tty1" ]] && startx

export EDITOR=vim

