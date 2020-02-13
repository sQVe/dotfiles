#  ┏━┓┏━┓╻ ╻┏━┓┏━╸┏━╸
#  ┗━┓┃ ┃┃ ┃┣┳┛┃  ┣╸
#  ┗━┛┗━┛┗━┛╹┗╸┗━╸┗━╸

zstyle ':zim:git' aliases-prefix 'g'
zstyle ':zim:input' double-dot-expand yes

source ${ZIM_HOME}/init.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh


#  ┏━┓┏━╸╺┳╸╺┳╸╻┏┓╻┏━╸┏━┓
#  ┗━┓┣╸  ┃  ┃ ┃┃┗┫┃╺┓┗━┓
#  ┗━┛┗━╸ ╹  ╹ ╹╹ ╹┗━┛┗━┛

if [[ "$TERM" = 'linux' ]]; then
  # Replicate colors definied in .Xresources for virtual console.
  _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
  for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
      echo -en "$i"
  done
  clear
fi

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Enable vi mode.
bindkey -v

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Enable command edit in $EDITOR.
autoload -z edit-command-line
zle -N edit-command-line

# Disable terminal close on <C-c>.
set -o ignoreeof

# Repair kill line, word and char when jumping between modes.
zle -A kill-whole-line vi-kill-line
zle -A backward-kill-word vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char


#  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
#  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
#  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

# Use fd in fzf completion for path listing.
function _fzf_compgen_path() {
  command fd --hidden --follow --exclude ".git" . "$1"
}

# # Use fd in fzf completion for directory listing.
function _fzf_compgen_dir() {
  command fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Disable nvm "use version" check.
function nvm() {
  source /usr/share/nvm/nvm.sh --no-use
  nvm "$@"
}

# Open playground helper.
function playground() {
  cd ~/code/playground && nvim +vsplit +"terminal npm run $1" +'wincmd h' +'norm G$' "boxes/$1"
}

# Open vifm and cd into selected directory on exit.
function vifm-cd() {
  local path="$(uberfm "$@")"

  if [[ -z "$path" ]]; then
    echo 'Cancelling setting path.'
    exit 0
  fi

  cd "$path"
}


#  ┏━╸╻ ╻┏━┓┏━┓┏━┓╺┳╸┏━┓
#  ┣╸ ┏╋┛┣━┛┃ ┃┣┳┛ ┃ ┗━┓
#  ┗━╸╹ ╹╹  ┗━┛╹┗╸ ╹ ┗━┛

export FZF_ALT_C_COMMAND='command fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'exa -T -L 1 --group-directories-first --color=always {}'"
export FZF_CTRL_T_COMMAND='command fd --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always {} 2> /dev/null || exa -T -L 1 --group-directories-first --color=always {}'"
export FZF_DEFAULT_COMMAND='command fd --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --color=bg+:#282828,spinner:#b16286,hl:#b16286
  --color=fg:#ebdbb2,info:#458588,pointer:#98971a
  --color=marker:#98971a,hl+:#98971a
  --reverse
'


#  ╻┏ ┏━╸╻ ╻┏┓ ╻┏┓╻╺┳┓╻┏┓╻┏━╸┏━┓
#  ┣┻┓┣╸ ┗┳┛┣┻┓┃┃┗┫ ┃┃┃┃┗┫┃╺┓┗━┓
#  ╹ ╹┗━╸ ╹ ┗━┛╹╹ ╹╺┻┛╹╹ ╹┗━┛┗━┛

bindkey -r '^T'

bindkey '^ ' autosuggest-accept
bindkey '^E' edit-command-line
bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget
bindkey '^[' vi-cmd-mode
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word


bindkey '^N' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi


#  ┏━┓╻  ╻┏━┓┏━┓┏━╸┏━┓
#  ┣━┫┃  ┃┣━┫┗━┓┣╸ ┗━┓
#  ╹ ╹┗━╸╹╹ ╹┗━┛┗━╸┗━┛

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
alias cmd=command
alias df='df -h'
alias du='du -ch'
alias dud='du -chd'
alias free='free -m'
alias ga='git-alias-lookup'
alias grep='grep --color=auto -d skip'
alias mkdir='mkdir -pv'
alias more=less
alias np='nvim -w PKGBUILD'
alias open='mimeo -q'
alias o=open
alias q=exit
alias root='sudo -i'
alias sudo='sudo '
alias sudoedit='sudo edit'

# Listing.
alias exa='exa --group-directories-first'
alias la='exa -la'
alias ll='exa -l'
alias ls='exa'

# Apps.
alias R='ramda --js'
alias bc='bc -l -q'
alias bluetooth=bluetoothctl
alias c=cat
alias camera=gphoto2
alias diff='diff --color=always --unified'
alias fd='fd --hidden --follow'
alias feh='feh --scale-down --auto-zoom --image-bg "#282828"'
alias fm=vifm-cd
alias format='npx prettier --write'
alias format-opinionated='npx prettier --no-semi --single-quote --trailing-comma es5 --write'
alias git=hub
alias hc='highlight -O truecolor --force --base16=gruvbox-dark-medium --stdout'
alias hcat='highlight -O truecolor --force --base16=gruvbox-dark-medium --stdout'
alias l=less
alias leave='i3-msg exit'
alias loc=locate
alias mixer=ncpamixer
alias mutt=neomutt
alias peekhl='peek --no-headerbar'
alias qutebrowser=scaled-qutebrowser
alias ramda='ramda --js'
alias s=sudo
alias se=sudoedit
alias spotify=scaled-spotify
alias t=term
alias tiga='tig --all'
alias v=nvim
alias vi=nvim
alias vifm=vifm-cd
alias vim=nvim
alias wifi-menu='wifi-menu -o'
alias xsel='xsel -b'

# Config.
alias cfg-alacritty='nvim-dir $HOME/.dotfiles/config/alacritty/alacritty.yml'
alias cfg-env='nvim-dir /etc/environment'
alias cfg-hosts='nvim-dir /etc/hosts'
alias cfg-i3='nvim-dir $HOME/.dotfiles/config/i3/config'
alias cfg-keymap-ergodox='nvim-dir $HOME/code/qmk_firmware/keyboards/ergodox_ez/keymaps/sqve/keymap.c'
alias cfg-keymap-preonic='nvim-dir $HOME/code/qmk_firmware/keyboards/preonic/keymaps/sqve/keymap.c'
alias cfg-mbsyncrc='nvim-dir $HOME/.dotfiles/mbsyncrc'
alias cfg-msmtprc='nvim-dir $HOME/.dotfiles/msmtprc'
alias cfg-mutt='nvim-dir $HOME/.dotfiles/config/mutt'
alias cfg-notmuch='nvim-dir $HOME/.dotfiles/notmuch'
alias cfg-nvim='nvim-dir $HOME/.dotfiles/config/nvim/'
alias cfg-pam='nvim-dir $HOME/.dotfiles/pam_environment'
alias cfg-vifm='nvim-dir $HOME/.dotfiles/config/vifm/vifmrc'
alias cfg-vim='nvim-dir $HOME/.dotfiles/config/nvim/'
alias cfg-weechat='nvim-dir $HOME/.dotfiles/weechat'
alias cfg-xinitrc='nvim-dir $HOME/.dotfiles/xinitrc'
alias cfg-xresources='nvim-dir $HOME/.dotfiles/Xresources'
alias cfg-zimrc='nvim-dir $HOME/.dotfiles/zimrc'
alias cfg-zshenv='nvim-dir $HOME/.dotfiles/zshenv'
alias cfg-zshrc='nvim-dir $HOME/.dotfiles/zshrc'

# Playground.
alias playground-clean.js='playground clean.js'
alias playground-clean.ts='playground clean.ts'
alias playground-fp.js='playground fp.js'
alias playground-fp.ts='playground fp.ts'

# Todo.
alias todo='nvim-dir $HOME/notes/todo.md'
