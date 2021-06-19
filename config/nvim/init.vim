"  ╻┏┓╻╻╺┳╸
"  ┃┃┗┫┃ ┃
"  ╹╹ ╹╹ ╹
source $HOME/.config/nvim/plugins.vim

source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/functions.vim

source $HOME/.config/nvim/autocmd.vim
source $HOME/.config/nvim/keymap.vim
source $HOME/.config/nvim/options.vim

source $HOME/.config/nvim/abbreviations.vim
source $HOME/.config/nvim/highlights.vim
source $HOME/.config/nvim/signs.vim

lua require('gitsigns')
lua require('lsp')
lua require('treesitter')
