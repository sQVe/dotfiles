export HTTPIE_CONFIG_DIR=$HOME/.config/httpie
export NVM_DIR=$HOME/.nvm
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

node_versions=$NVM_DIR/versions/node
export PATH=$PATH:$HOME/.local/bin:$node_versions/$(ls -1 $node_versions | sort -V | tail -n 1)/bin

export FZF_ALT_C__COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_R_COMMAND='fd'
export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'

export FZF_ALT_C_OPTS="--preview 'tree -C -L 1 --dirsfirst {}'"
export FZF_CTRL_T_OPTS="--preview '(highlight -l -O xterm256 -s dracula --stdout {} 2> /dev/null || cat {} || tree -C -L 1 --dirsfirst {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_OPTS='
  --color=bg+:#343434,spinner:#BD93F9,hl:#BD93F9
  --color=fg:#F8F8F2,info:#FF79C6,pointer:#50FA7B
  --color=marker:#50FA7B,hl+:#50FA7B
'

export PROMPT_LEAN_VIMODE=1
export PROMPT_LEAN_VIMODE_FORMAT="%F{green}NORMAL%f "
export GREP_COLORS='mt=30;44'
export LESS='-R'
export LESSOPEN='|highlight -O xterm256 --force -s dracula --stdout %s'

