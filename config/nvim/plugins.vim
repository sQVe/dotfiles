"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹┗━┛

" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Import plugins  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

call plug#begin('$HOME/.local/share/nvim/plugged')

" Colorschemes.
Plug 'dracula/vim', { 'as': 'dracula' }

" Language, syntax and formatting.
Plug 'sheerun/vim-polyglot'

" Interface.
Plug 'ap/vim-buftabline'
Plug 'brooth/far.vim'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '$HOME/.local/share/nvim/apps/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'markonm/traces.vim'
Plug 'mhinz/vim-signify'
Plug 'samoshkin/vim-mergetool'
Plug 'tpope/vim-fugitive'
Plug 'vifm/vifm.vim'

" Integration.
Plug 'dahu/vim-fanfingtastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'kamykn/spelunker.vim'
Plug 'kkoomen/vim-doge'
Plug 'machakann/vim-sandwich'
Plug 'mg979/vim-visual-multi'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'wellle/targets.vim'

" Commands.
Plug 'lambdalisue/suda.vim'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-abolish'

" Completion and spelling.
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'rhysd/vim-grammarous'

call plug#end()
