########################################
# EXPORT
########################################

export GREP_COLORS='mt=30;44'
export HTTPIE_CONFIG_DIR=$HOME/.config/httpie
export LESS='-R'
export LESSOPEN='|pygmentize -g %s'
export NVM_DIR=$HOME/.nvm
export PATH=$PATH:$HOME/.local/bin
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

########################################
# SOURCE
########################################

source ${ZIM_HOME}/init.zsh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/nvm.sh

########################################
# MISC
########################################

fpath=(/usr/share/bash-completion/completions ${fpath})

########################################
# ALIASES
########################################

# -------------------------------------- Safety
alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias cp='cp -ir'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -I --preserve-root'

# -------------------------------------- Goodies & Misc
alias cl=clear
alias df='df -h'
alias du='du -ch'
alias dud='du -chd'
alias free='free -m'
alias ga='cat $ZIM_HOME/modules/git/init.zsh | grep'
alias grep='grep --color=auto -d skip'
alias more=less
alias np='micro -w PKGBUILD'
alias open='mimeo -q'
alias root='sudo -i'
alias sudo='sudo '
alias sx=startx
alias q=exit

# -------------------------------------- Listing
alias cla='clear;la'
alias cll='clear;ll'
alias cls='clear;ls'
alias la='ls -lhA'
alias lag='la | grep'
alias ll='ls -lh'
alias llg='ll | grep'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lsg='ls | grep'

# -------------------------------------- Apps
alias a=code
alias bc='bc -l -q'
alias bluetooth=bluetoothctl
alias c=cat
alias ccat='pygmentize -g'
alias diff='git diff'
alias feh='feh --scale-down'
alias git=hub
alias l=less
alias loc=locate
alias m=micro
alias mixer=ncpamixer
alias n=nano
alias o=open
alias p=pacaur
alias pass=lpass
alias r=ranger
alias ranger='ranger --choosedir=$HOME/.config/ranger/latest-dir; cd "`cat $HOME/.config/ranger/latest-dir`"'
alias sm='sudo micro'
alias sn='sudo nano'
alias so='sudo open'
alias t='urxvt & disown'
alias tiga='tig --all'
alias todo='micro $HOME/TODO'
alias wifi-menu='wifi-menu -o'

# -------------------------------------- Config
alias cfg-hosts='sudo micro /etc/hosts'
alias cfg-i3='micro ~/.dotfiles/config/i3/config'
alias cfg-xinitrc='micro ~/.dotfiles/xinitrc'
alias cfg-xresources='micro ~/.dotfiles/Xresources'
alias cfg-zimrc='micro ~/.dotfiles/zimrc'
alias cfg-zshrc='micro ~/.dotfiles/zshrc'