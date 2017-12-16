########################################
# EXPORT
########################################

export NVM_DIR=$HOME/.nvm
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
export LESS='-R'
export LESSOPEN='|pygmentize -g %s'
export GREP_COLORS='mt=30;44'

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
alias np='nano -w PKGBUILD'
alias open='mimeo -q'
alias root='sudo -i'
alias sudo='sudo '
alias sx=startx

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

# -------------------------------------- Pacaur
alias p=pacaur
alias pi='pacaur -S'
alias pqi='pacaur -Qi'
alias pqs='pacaur -Qs'
alias pr='pacaur -Rns'
alias ps='pacaur -Ss'
alias pu='pacaur -Syu'

# -------------------------------------- Apps
alias a=code
alias bc='bc -l -q'
alias bluetooth=bluetoothctl
alias c=cat
alias ccat='pygmentize -g'
alias clock='tty-clock -s -c -C 6 -D'
alias diff='git diff'
alias feh='feh --scale-down'
alias flash-ergodox='teensy_loader_cli --mcu=atmega32u4 -w'
alias git=hub
alias l=less
alias m=micro
alias mixer=ncpamixer
alias n=nano
alias o=open
alias pass=lpass
alias r=ranger
alias ranger='ranger --choosedir=$HOME/.config/ranger/latest-dir; cd "`cat $HOME/.config/ranger/latest-dir`"'
alias t='urxvt & disown'
alias tiga='tig --all'
alias todo='nano $HOME/TODO'
alias wifi-menu='wifi-menu -o'

# -------------------------------------- Config
alias cfg-hosts='sudo nano /etc/hosts'
alias cfg-i3='nano ~/.dotfiles/config/i3/config'
alias cfg-xinitrc='nano ~/.dotfiles/xinitrc'
alias cfg-xresources='nano ~/.dotfiles/Xresources'
alias cfg-zimrc='nano ~/.dotfiles/zimrc'
alias cfg-zshrc='nano ~/.dotfiles/zshrc'