########################################
# EXPORT
########################################
export EDITOR=leafpad
export NVM_DIR="$HOME/.nvm"

########################################
# ALIASES
########################################

# -------------------------------------- Safety
alias rm="rm -I --preserve-root"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"

# -------------------------------------- Goodies & Misc
alias sx="startx"
alias grep="grep --color=tty -d skip"
alias cp="cp -ir"
alias df="df -h"
alias du="du -ch"
alias free="free -m"
alias np="nano -w PKGBUILD"
alias more=less
alias c=clear
alias root="sudo -i"
alias xclip="xclip -selection clipboard"
alias clipin="xclip -in"
alias clipout="xclip -out"

# -------------------------------------- Listing
alias ls="ls --group-directories-first --time-style=+'%d.%m.%Y %H:%M' --color=auto -F"
alias ll="ls -lh"
alias la="ls -lhA"
alias lsg="ls | grep"
alias llg="ll | grep"
alias lag="la | grep"
alias cls="clear;ls"
alias cll="clear;ll"
alias cla="clear;la"

# -------------------------------------- Pacaur
alias p=pacaur
alias pu="pacaur -Syu"
alias ps="pacaur -Ss"
alias pi="pacaur -S"
alias pr="pacaur -Rns"
alias pqs="pacaur -Qs"
alias pqi="pacaur -Qi"

# -------------------------------------- Block / Unblock
alias ubb="sudo rfkill unblock bluetooth"
alias bb="sudo rfkill block bluetooth"
alias ubw="sudo rfkill unblock wifi"
alias bw="sudo rfkill block wifi"

# -------------------------------------- Apps
alias tiga="tig --all"
alias lp=leafpad
alias slp="sudo leafpad"
alias mixer=pavucontrol
alias clock="tty-clock -s -c -C 6 -D"
alias bluetooth=bluetoothctl
alias bc="bc -l -q"
alias feh="feh --scale-down"
alias wifi-menu="wifi-menu -o"
alias ccat="pygmentize -g"
alias pass="lpass"

# -------------------------------------- Config
alias cfg-xinitrc="$EDITOR ~/.dotfiles/xinitrc & disown"
alias cfg-zshrc="$EDITOR ~/.dotfiles/zshrc & disown"
alias cfg-zprofile="$EDITOR ~/.dotfiles/zprofile & disown"
alias cfg-i3="$EDITOR ~/.dotfiles/config/i3/config & disown"
alias cfg-i3blocks="$EDITOR ~/.dotfiles/config/i3blocks/config & disown"
alias cfg-xresources="$EDITOR ~/.dotfiles/Xresources & disown"
alias cfg-weechat="$EDITOR ~/.dotfiles/weechat/weechat.conf & disown"
alias cfg-weechat-irc="$EDITOR ~/.dotfiles/weechat/irc.conf & disown"
alias cfg-hosts="sudo $EDITOR /etc/hosts"

########################################
# MISC & SOURCE
########################################

source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion