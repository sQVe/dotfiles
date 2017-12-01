########################################
# EXPORT
########################################
 
export EDITOR=leafpad
export NVM_DIR="$HOME/.nvm"
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
export LESS="-R"
export LESSOPEN="|pygmentize -g %s"

########################################
# ALIASES
########################################

# -------------------------------------- Safety
alias chgrp="chgrp --preserve-root"
alias chmod="chmod --preserve-root"
alias chown="chown --preserve-root"
alias cp="cp -ir"
alias ln="ln -i"
alias mv="mv -i"
alias rm="rm -I --preserve-root"

# -------------------------------------- Goodies & Misc
alias cl=clear
alias clip=xclip
alias df="df -h"
alias du="du -ch"
alias dud="du -chd"
alias free="free -m"
alias ga="cat ${ZIM_HOME}/modules/git/init.zsh | grep"
alias grep="grep --color=tty -d skip"
alias more=less
alias np="nano -w PKGBUILD"
alias open="mimeo -q"
alias root="sudo -i"
alias sudo="sudo "
alias sx=startx
alias xclip="xclip -selection clipboard"

# -------------------------------------- Listing
alias cla="clear;la"
alias cll="clear;ll"
alias cls="clear;ls"
alias la="ls -lhA"
alias lag="la | grep"
alias ll="ls -lh"
alias llg="ll | grep"
alias ls="ls --group-directories-first --time-style=+'%d.%m.%Y %H:%M' --color=auto -F"
alias lsg="ls | grep"

# -------------------------------------- Pacaur
alias p=pacaur
alias pi="pacaur -S"
alias pqi="pacaur -Qi"
alias pqs="pacaur -Qs"
alias pr="pacaur -Rns"
alias ps="pacaur -Ss"
alias pu="pacaur -Syu"

# -------------------------------------- Apps
alias bc="bc -l -q"
alias bluetooth=bluetoothctl
alias ccat="pygmentize -g"
alias clock="tty-clock -s -c -C 6 -D"
alias fa=code
alias fc=cat
alias feh="feh --scale-down"
alias fl=less
alias fo=xdg-open
alias fp=leafpad
alias git=hub
alias mixer=pavucontrol
alias pass=lpass
alias slp="sudo leafpad"
alias t="urxvt & disown"
alias tiga="tig --all"
alias wifi-menu="wifi-menu -o"

# -------------------------------------- Config
alias cfg-hosts="sudo $EDITOR /etc/hosts"
alias cfg-i3="$EDITOR ~/.dotfiles/config/i3/config & disown"
alias cfg-i3blocks="$EDITOR ~/.dotfiles/config/i3blocks/config & disown"
alias cfg-weechat-irc="$EDITOR ~/.dotfiles/weechat/irc.conf & disown"
alias cfg-weechat="$EDITOR ~/.dotfiles/weechat/weechat.conf & disown"
alias cfg-xinitrc="$EDITOR ~/.dotfiles/xinitrc & disown"
alias cfg-xresources="$EDITOR ~/.dotfiles/Xresources & disown"
alias cfg-zimrc="$EDITOR ~/.dotfiles/zimrc & disown"
alias cfg-zshrc="$EDITOR ~/.dotfiles/zshrc & disown"

########################################
# MISC & SOURCE
########################################

fpath=(/usr/share/bash-completion/completions ${fpath})

source ${ZIM_HOME}/init.zsh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/nvm.sh