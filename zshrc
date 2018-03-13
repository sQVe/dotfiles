########################################
# SOURCE
########################################

source ${ZIM_HOME}/init.zsh

########################################
# FUNCTIONS
########################################

function nvm() {
  source /usr/share/nvm/nvm.sh --no-use
  nvm "$*"
}

########################################
# KEYBINDINGS
########################################

bindkey "^[^?" backward-kill-word
bindkey "^[^H" backward-kill-word
bindkey '^G' fzf-cd-widget
bindkey jj vi-cmd-mode

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
alias ga='cat $ZIM_HOME/modules/git/init.zsh | ag'
alias grep='grep --color=auto -d skip'
alias more=less
alias np='nvim -w PKGBUILD'
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
alias lag='la | ag'
alias ll='ls -lh'
alias llg='ll | ag'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lsg='ls | ag'

# -------------------------------------- Apps

alias :Q=exit
alias :q=exit
alias ag='ag --hidden'
alias bc='bc -l -q'
alias bluetooth=bluetoothctl
alias c=cat
alias diff='git diff --no-index'
alias fd='fd --hidden'
alias feh='feh --scale-down'
alias git=hub
alias hc="highlight -O xterm256 --force -s dracula --stdout"
alias hcat="highlight -O xterm256 --force -s dracula --stdout"
alias l=less
alias loc=locate
alias mixer=ncpamixer
alias n=nano
alias o=open
alias p=pacaur
alias pass=lpass
alias r=ranger
alias ranger='ranger --choosedir=$HOME/.config/ranger/latest-dir; cd "`cat $HOME/.config/ranger/latest-dir`"'
alias so='sudo open'
alias sv='sudo nvim'
alias tiga='tig --all'
alias todo='nvim $HOME/todo'
alias v=nvim
alias vim=nvim
alias wifi-menu='wifi-menu -o'

# -------------------------------------- Config
alias cfg-env='sudo nvim /etc/environment'
alias cfg-hosts='sudo nvim /etc/hosts'
alias cfg-i3='nvim ~/.dotfiles/config/i3/config'
alias cfg-vim='nvim ~/.dotfiles/config/nvim/'
alias cfg-xinitrc='nvim ~/.dotfiles/xinitrc'
alias cfg-xresources='nvim ~/.dotfiles/Xresources'
alias cfg-zimrc='nvim ~/.dotfiles/zimrc'
alias cfg-zshenv='nvim ~/.dotfiles/zshenv'
alias cfg-zshrc='nvim ~/.dotfiles/zshrc'
