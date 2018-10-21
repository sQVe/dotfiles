
#  ╺━┓┏━┓╻ ╻┏━┓┏━╸
#  ┏━┛┗━┓┣━┫┣┳┛┃
#  ┗━╸┗━┛╹ ╹╹┗╸┗━╸

# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
# ¤¤¤¤  Sourcing  ¤¤¤¤
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
source ${ZIM_HOME}/init.zsh


# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
# ¤¤¤¤  Settings  ¤¤¤¤
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
if [[ "$TERM" = "linux" ]]; then
  # Replicate colors definied in .Xresources for virtual console.
  colors=$(sed -n 's/\*\.color\([0-9]\+\).*#\(\w\{6\}\)/\1 \2/p' "$HOME/.Xresources")
  echo -en $(awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}' <<< "$colors")
  clear
fi

# Enable command edit in $EDITOR.
autoload -z edit-command-line
zle -N edit-command-line

# Disable terminal close on <C-c>.
set -o ignoreeof


# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
# ¤¤¤¤  Functions  ¤¤¤¤
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
function nvm() {
  source /usr/share/nvm/nvm.sh --no-use
  nvm "$@"
}


# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
# ¤¤¤¤  Exports  ¤¤¤¤
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
export FZF_ALT_C_COMMAND='command fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='command fd --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='command fd --hidden --follow --exclude .git'

export FZF_CTRL_T_OPTS="--preview '(highlight -l -O xterm256 -s dracula --stdout {} 2> /dev/null || cat {} || tree -C -L 1 --dirsfirst {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C -L 1 --dirsfirst {}'"
export FZF_DEFAULT_OPTS='
  --color=bg+:#343434,spinner:#BD93F9,hl:#BD93F9
  --color=fg:#F8F8F2,info:#FF79C6,pointer:#50FA7B
  --color=marker:#50FA7B,hl+:#50FA7B
'


# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
# ¤¤¤¤  Keybindings  ¤¤¤¤
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
bindkey -r '^T'

bindkey '^[' vi-cmd-mode
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word
bindkey '^E' edit-command-line
bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget


# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
# ¤¤¤¤  Aliases  ¤¤¤¤
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

# Safety.
alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias cp='cp -ir'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -I --preserve-root'

# Goodies & Misc.
alias cl=clear
alias df='df -h'
alias du='du -ch'
alias dud='du -chd'
alias free='free -m'
alias ga='cat $ZIM_HOME/modules/git/init.zsh | ag "^alias" | sed -e "s/alias //" -e "s/=/%%/" | column -t -s "%%" | ag'
alias grep='grep --color=auto -d skip'
alias mkdir="mkdir -pv"
alias more=less
alias np='nvim -w PKGBUILD'
alias open='mimeo -q'
alias q=exit
alias root='sudo -i'
alias sudo='sudo '
alias sudoedit='sudo edit'

# Listing.
alias cla='clear;la'
alias cll='clear;ll'
alias cls='clear;ls'
alias la='ls -lhA'
alias lag='la | ag'
alias ll='ls -lh'
alias llg='ll | ag'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lsg='ls | ag'

# Apps.
alias R='ramda --js'
alias ag='ag --hidden --ignore .git --follow'
alias bc='bc -l -q'
alias bluetooth=bluetoothctl
alias c=cat
alias camera=gphoto2
alias diff='git diff --no-index'
alias fd='fd --hidden --follow'
alias feh='feh --scale-down --auto-zoom --image-bg "#343434"'
alias git=hub
alias hc="highlight -O xterm256 --force -s dracula --stdout"
alias hcat="highlight -O xterm256 --force -s dracula --stdout"
alias l=less
alias lazy=lazygit
alias leave='i3-msg exit'
alias loc=locate
alias mixer=ncpamixer
alias o=open
alias pass=lpass
alias r=ranger
alias ramda='ramda --js'
alias ranger='ranger --choosedir=$HOME/.config/ranger/latest-dir; cd "`cat $HOME/.config/ranger/latest-dir`"'
alias s=sudo
alias se=sudoedit
alias t=term
alias tiga='tig --all'
alias todo='nvim $HOME/todo.md'
alias v=nvim
alias vi=nvim
alias vim=nvim
alias wifi-menu='wifi-menu -o'
alias xsel='xsel -b'

# Config & docs.
alias cfg-env='sudo nvim /etc/environment'
alias cfg-hosts='sudo nvim /etc/hosts'
alias cfg-i3='nvim ~/.dotfiles/config/i3/config'
alias cfg-keymap='nvim ~/code/qmk_firmware/keyboards/ergodox_ez/keymaps/sqve/keymap.c'
alias cfg-nvim='nvim ~/.dotfiles/config/nvim/'
alias cfg-vim='nvim ~/.dotfiles/config/nvim/'
alias cfg-xinitrc='nvim ~/.dotfiles/xinitrc'
alias cfg-xresources='nvim ~/.dotfiles/Xresources'
alias cfg-zimrc='nvim ~/.dotfiles/zimrc'
alias cfg-zshenv='nvim ~/.dotfiles/zshenv'
alias cfg-zshrc='nvim ~/.dotfiles/zshrc'
alias doc-vim-cheat='nvim ~/docs/vim-cheat.txt'

