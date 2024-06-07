#!/bin/bash

alias rm='trash-put'
#========[BETTER DIRECTORY NAVIGATION]========#
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null
# CDPATH
export CDPATH=".:~:~/Work:~/.local:~/.config"

#========[HISTORY]========#
# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

#======[ SOURCE ]======#
source "$HOME"/.aliases
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
source ~/tmp/Programs/extraterm-commands-0.9.4/setup_extraterm_bash.sh
#========[COMPLETION]========#
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#========[Vi  MODE]========#
if [[ $- == *i* ]]; then # in interactive session
    set -o emacs
    # set -o vi
    # bind -m vi-command 'Control-l: clear-screen'
    # bind -m vi-insert 'Control-l: clear-screen'
    # bind '"jj":vi-movement-mode'
    # bind '"\e[1;5C": forward-word'  # Ctrl-Right Arrow: Move forward one word
    # bind '"\e[1;5D": backward-word' # Ctrl-Left Arrow: Move backward one word
    # bind '"\e[1;5H": beginning-of-line'  # Ctrl-Home: Move to the beginning of the line
    # bind '"\e[1;5F": end-of-line'        # Ctrl-End: Move to the end of the line
fi
#========[TTY RESOLUTION]========#
# fbset -a -g 1920 1080 1920 1080 32

#========[XTerm TRANSOARENCY]========#
# [ -n "$XTERM_VERSION" ] && transset-df -m 0.9 --id "$WINDOWID" >/dev/null

#========[ST TRANSOARENCY]========#
# term=$(cat /proc/$PPID/comm)
# if [[ $term == "st" ]]; then
	# transset-df "0.9" --id $WINDOWID >/dev/null
# fi

#========[PS1]========#
parse_git_branch() {
  # branch=$(git branch 2>/dev/null | grep -E '^\*' | awk '{print $2}')
  branch=$(git branch 2>/dev/null | sed -n '/\* /s///p')
  if [ -n "$branch" ]; then
    ansi --green --italic " " "$branch"
  fi
}

PS1='\[\e[38;5;39m\]󰣇 \[\e[0;38;5;39m\]\w$(parse_git_branch)\[\e[0m\]\[\e[0m\]\n \[\e[38;5;86m\]╰─󰁔\[\e[0m\] '
PS2='\[\e[31m\] \[\e[0m\] '
# export PS1="\[\033[32m\]\u@\h \[\033[33;1m\]\w \[\033[36m\]\$(parse_git_branch) \[\033[0m\]\$ "
# PS1='\[\e[38;5;39m\]  \[\e[0;38;5;46m\] \[\e[0;38;5;39m\]\w$(parse_git_branch)\[\e[0m\] \[\e[0m\]'
# PS1='\[\e[38;5;39m\]  \[\e[0;38;5;46m\] \[\e[0;38;5;39m\]\w$(parse_git_branch)\[\e[0m\]\q{my/vim-mode}\[\e[0m\]'

#=======[EXPORT VARIABLES]=========#
export EDITOR=vim
export PATH="$PATH":~/.local/bin/
export PATH="$PATH":~/.local/bin/PhpStorm2024/bin/
export PATH="$PATH":/opt/lampp/bin/
export PATH="$PATH":~/go/bin/
export BROWSER=waterfox-g
export browser=waterfox-g
export TERM=xterm-256color
export MANPAGER='vim -M +MANPAGER -'
export BAT_THEME="1337"
complete -cf sudo
complete -cf doas
# unset QT_STYLE_OVERRIDE
# export QT_QPA_PLATFORMTHEME=kvantum
# export QT_QPA_PLATFORMTHEME=qt5ct
# export DISPLAY=:0.0

#========[FUNCTIONS]========#
ai() {
	proxychains ~/SenGPT/bin/python3.11 ~/SenGPT/bin/sengpt "$1"
}

mkcd() {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

os() {
	cat /etc/os-release
}

cs () {
    cd $* && ls
}

gccd () {
    git clone $1 && cs "$(basename "$_" .git) "
}

redraw() {
	tput reset
	clear
	echo "Width = $(tput cols) Height = $(tput lines)"
}

#====[EXTRACTOR]====#
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7zz x "$1"      ;;
      *.deb)       ar x "$1"      ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.tar.zst)   tar xf "$1"    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#====[COMPRESSOR]====#
komp() {
    if [ -d "$2" ]; then
        case "$1" in
            "tar")
                tar -cvf "$(basename "$2").tar" "$2";;
            "gz")
                tar -czvf "$(basename "$2").tar.gz" "$2";;
            "bz")
                tar -cjvf "$(basename "$2").tar.bz2" "$2";;
            "xz")
                tar -cJvf "$(basename "$2").tar.xz" "$2";;
            *)
                echo "Invalid compression format.";;
        esac
    else
        echo "Invalid directory path."
    fi
}
#========[LF]========#
lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

#========[ViFm]========#
vicd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}
#====[COLORS]====#
ylw() {
  echo -e "\033[32m$@\033[0m"
}
grn() {
  echo -e "\033[33m$@\033[0m"
}
cyn() {
  echo -e "\033[34m$@\033[0m"
}
bylw() {
  echo -e "\033[1;7;32m$@\033[0m"
}
rd() {
  echo -e "\033[31m$@\033[0m"
}
brd() {
  echo -e "\033[1;7;31m$@\033[0m"
}

#========[FZF]========#
[[ $- != *i* ]] && return
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_COMPLETION_TRIGGER='**'

# export FZF_DEFAULT_COMMAND='find . -path "*/\.*" ! -name "." -print 2>/dev/null | sed "s|^\./||"'
export FZF_DEFAULT_COMMAND='fd --type f'

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

  # Print tree structure in the preview window
# export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

_fzf_setup_completion path ag git kubectl
_fzf_setup_completion dir tree

# integration with z 
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
# Install packages using yay (change to pacman/AUR helper of your choice)
function aur() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S --color=always --askyesremovemake
}
# Remove installed packages (change to pacman/AUR helper of your choice)
function raur() {
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}
function ins() {
    pacman -Slq | fzf -q "$1" -m --preview 'pacman -Si {1}'| xargs -ro doas pacman -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
function remove() {
    pacman -Qq | fzf -q "$1" -m --preview 'pacman -Qi {1}' | xargs -ro doas pacman -Rns
}

function pkglist() {
    pacman -Ql $@ | fzf
}
#
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

#cd into the selected directory
# This one differs from the above, by only showing the sub directories and not
#  showing the directories within those.
fcd() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# open hidden files with xdg
ff() {
  local file=$(find . -type f | fzf)
  xdg-open "$file"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

vf() {
    fzf --print0 | xargs -0 -o vim
}

fvi() {
    fzf --multi --bind 'enter:become(vim {+})'
}

hzf(){
echo -e " fcd || fda for directories\n ff => open files with xdg\n cdf => cd into directory of selected file\n vf => open in vim\n fvi => multi open in vim"
}
#
# FZF GIT
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcoc_preview - checkout git commit with previews
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# FZF PASS 
# .local/bin/passfzf

# FZF MAN PAGES FINDER
export MANPATH=/usr/share/man/
man-find() {
    f=$(fd . $MANPATH/man${1:-1} -t f -x echo {/.} | fzf) && man $f
}

# FZF DOCKER
# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(doas docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
# Select a running docker container to stop
function ds() {
  local cid
  cid=$(doas docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
# Remove docker container
function drm() {
  doas docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r doas docker rm
}
# Same as above, but allows multi selection:
function mdrm() {
  doas docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r doas docker rm
}
# Select a docker image or images to remove
function drmi() {
  doas docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r doas docker rmi
}

# FZF NPM 
# run npm script (requires jq)
fzfnpm() {
  local script
  script=$(cat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && npm run $(echo "$script")
}

# ================================= #

wterm() {
    ps -p $(ps -p $$ -o ppid=) o args=
}

live() {
    xdg-open "$1"
}

cheat() {
  if [ -x "$(command -v curl)" ]; then
    curl --silent "cht.sh/$1" | bat;
  fi;
}

md-server() {
   if [[ "$1" = *.md ]]; then
       waterfox-g "$1"
   fi
}

PyEnv(){
    ~/PyVirtEnv "$@"
    source $1/bin/activate
    cd $1
}

brain(){
  cd ~/vimwiki || return
  rg $@
  ~
}

tempo() { 
    ylw "Metronome Started With $1-BPM"
    play -n -c1 synth 0.001 sine 1000 pad $(awk "BEGIN { print 60/$1 -.001 }") repeat 999999
} 

vis_tempo() {
	BPM=120;
	while :;
	do
		printf "\e]11;#D80000\007";
		sleep "$(bc <<< "scale=2; 60 / $BPM")";
		printf "\e]11;#1e1e2e\007";
		sleep "$(bc <<< "scale=2; 60 / $BPM")"; 
	done
}

price(){
  KEY="freeUNamoXxueUHXqoMnEZJCDwTwdQWp"
  price=$(curl -s "http://api.navasan.tech/latest/?api_key=$KEY" | jq 'walk(if type == "object" then del(.date, .change, .timestamp) else . end) .usd_buy' | tr -d '{},",:' | sed 's/value//')
  print=$(figlet $price)
  echo -e "\033[1;33m$print\033[0m"
}

getDefinitions() {
    local word="$1"
    local res=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en_US/$word")
    echo "$res" | jq -r '.[0].meanings[].definitions[]?.definition'
}

# alias fs='fluidsynth -a pulseaudio -m alsa_raw -o midi.alsa.device=hw:3,0,1 -g 1.0 /usr/share/soundfonts/default.sf2'
alias mc='tmux split -h lf; lf'
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'

get_skeleton() {
  wget https://github.com/dhg/Skeleton/releases/download/2.0.4/Skeleton-2.0.4.zip
}

get_miligram() {
  wget https://github.com/milligram/milligram/archive/v1.4.1.zip
}

# fromhex A52A2A
# fromhex "#A52A2A"
# BLUE_VIOLET=$(fromhex "#8A2BE2")
# http://unix.stackexchange.com/a/269085/67282
function fromhex() {
  hex=$1
  if [[ $hex == "#"* ]]; then
    hex=$(echo $1 | awk '{print substr($0,2)}')
  fi
  r=$(printf '0x%0.2s' "$hex")
  g=$(printf '0x%0.2s' ${hex#??})
  b=$(printf '0x%0.2s' ${hex#????})
  echo -e `printf "%03d" "$(((r<75?0:(r-35)/40)*6*6+(g<75?0:(g-35)/40)*6+(b<75?0:(b-35)/40)+16))"`
}

function bgFg() {
	printf "\033]11;#"$1"\007"
	printf "\033]10;#"$2"\007"
}

function lms(){
	 export QT_AUTO_SCREEN_SCALE_FACTOR=1
	 export QT_SCREEN_SCALE_FACTORS=1.2
	 swallow lmms 
 }
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
