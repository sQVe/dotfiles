
#  ╺━┓┏━┓╻ ╻┏━╸┏┓╻╻ ╻
#  ┏━┛┗━┓┣━┫┣╸ ┃┗┫┃┏┛
#  ┗━╸┗━┛╹ ╹┗━╸╹ ╹┗┛

export GPG_TTY="$(tty)"

export KEYTIMEOUT=1
export PROMPT_LEAN_VIMODE=1
export PROMPT_LEAN_VIMODE_FORMAT='%F{green}NORMAL%f '
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

node_versions=$NVM_DIR/versions/node
export PATH=$PATH:$HOME/.local/bin:$node_versions/$(ls -1 $node_versions | sort -V | tail -n 1)/bin

export TLDR_COLOR_COMMAND='magenta'
export TLDR_COLOR_EXAMPLE='cyan'
export TLDR_COLOR_NAME='green'

export EXA_COLORS='da=38;5;244:gr=37:gu=1;37:gw=36:gx=35:tr=37:tw=36:tx=35:ue=35:ur=37:uu=1;37:uw=36:ux=35'
export GREP_COLORS='mt=30;44'
export LESS='-R'
export LESSOPEN='|highlight -O truecolor --force --base16=gruvbox-dark-medium --stdout %s'
