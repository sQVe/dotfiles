########################################
# EXPORTS
########################################
export FZF_ALT_C__COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_R_COMMAND='fd'
export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'

export FZF_ALT_C_OPTS="--preview 'tree -C -L 1 --dirsfirst {}'"
export FZF_CTRL_T_OPTS="--preview '(highlight -l -O xterm256 -s dracula {} 2> /dev/null || cat {} || tree -C -L 1 --dirsfirst {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_OPTS='
  --color=bg+:#343434,spinner:#BD93F9,hl:#BD93F9
  --color=fg:#F8F8F2,info:#FF79C6,pointer:#50FA7B
  --color=marker:#50FA7B,hl+:#50FA7B
'

export GREP_COLORS='mt=30;44'
export LESS='-R'
export LESSOPEN='|highlight -O xterm256 --force -s dracula %s'

########################################
# SOURCE
########################################

source ${ZIM_HOME}/init.zsh
source /usr/share/nvm/nvm.sh

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
alias ga='cat $ZIM_HOME/modules/git/init.zsh | grep'
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
alias lag='la | grep'
alias ll='ls -lh'
alias llg='ll | grep'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lsg='ls | grep'

# -------------------------------------- Apps

alias :Q=exit
alias :q=exit
alias bc='bc -l -q'
alias bluetooth=bluetoothctl
alias c=cat
alias diff='git diff --no-index'
alias feh='feh --scale-down'
alias find=fd
alias git=hub
alias hc="highlight -O xterm256 --force -s dracula"
alias hcat="highlight -O xterm256 --force -s dracula"
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
alias todo='nvim $HOME/TODO'
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
