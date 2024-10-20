# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $(pgrep startx) = '' ]] && [[ "$(tty)" = "/dev/tty1" ]] && startx

# [[ -f ~/.Xmodmap-Swaped ]] && xmodmap ~/.Xmodmap-Swaped
# export EDITOR=vim
