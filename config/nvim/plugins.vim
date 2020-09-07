"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹┗━┛

" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Import plugins  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

call plug#begin('$HOME/.local/share/nvim/plugged')

" Align, surround and repeat.
Plug 'junegunn/vim-easy-align'          " Alignment.
Plug 'machakann/vim-sandwich'           " Surround text.
Plug 'tpope/vim-repeat'                 " Repeat for plugins.

" Colorschemes.
Plug 'gruvbox-community/gruvbox'        " Gruvbox colorscheme.

" Commands.
Plug 'lambdalisue/suda.vim'             " Read and write with sudo.
Plug 'moll/vim-bbye'                    " Delete buffers without closing window.
Plug 'tpope/vim-eunuch'                 " Unix helpers.

" Comments and documentation.
Plug 'kkoomen/vim-doge'                 " Generate documentation.
Plug 'tpope/vim-commentary'             " Comment text.

" Completion, diagnostics and spelling.
Plug 'dense-analysis/ale'               " Lint and fix files.
Plug 'neoclide/coc.nvim', {
  \ 'do': 'yarn install --frozen-lockfile'
  \ }                                   " Intellisense with LSP.
Plug 'rhysd/vim-grammarous'             " Grammary check with languagetool.

" Integration.
Plug 'airblade/vim-rooter'              " Set pwd to root directory.
Plug 'editorconfig/editorconfig-vim'    " Editorconfig.
Plug 'iamcco/markdown-preview.nvim', {
  \ 'do': 'cd app & yarn install'
  \ }                                   " Markdown preview.
Plug 'sickill/vim-pasta'                " Paste with smart indentation.
Plug 'tpope/vim-fugitive'               " Git.
Plug 'tpope/vim-rhubarb'                " Use hub instead of git.
Plug 'tpope/vim-speeddating'            " Increment / decrement dates, times and more.

" Interface.
Plug 'ap/vim-buftabline'                " Buffer tabs.
Plug 'camspiers/lens.vim'               " Resize windows based on content.
Plug 'itchyny/lightline.vim'            " Status line.
Plug 'maximbaz/lightline-ale'           " Lint information in status line.
Plug 'mhinz/vim-startify'               " Launch screen.
Plug 'ntpeters/vim-better-whitespace'   " Highlight trailing whitespace.
Plug 'romainl/vim-cool'                 " Clear highlight search on movement.
Plug 'samoshkin/vim-mergetool'          " Git mergetool
Plug 'voldikss/vim-floaterm'            " Floating terminal.

" Search, replace and navigation.
Plug 'junegunn/fzf.vim'                 " Fzf.
Plug 'justinmk/vim-sneak'               " Quick jump.
Plug 'markonm/traces.vim'               " Range, pattern and substitute preview.
Plug 'mg979/vim-visual-multi'           " Multiple cursors.

" Syntax.
Plug 'sheerun/vim-polyglot'             " Language pack.

" Text objects.
Plug 'christoomey/vim-sort-motion'      " Sort by motion.
Plug 'wellle/targets.vim'               " Additional text objects.

call plug#end()
