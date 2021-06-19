"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹┗━┛

" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Import plugins  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

" Disable language syntax already handled by treesitter.
let s:lang_syntax_disable = [
  \ 'go.plugin',
  \ 'graphql.plugin',
  \ 'html5.plugin',
  \ 'javascript.plugin',
  \ 'json.plugin',
  \ 'jsonc.plugin',
  \ 'jsx.plugin',
  \ 'sh.plugin',
  \ 'typescript.plugin',
  \ ]

let g:polyglot_disabled = s:lang_syntax_disable

call plug#begin('$HOME/.local/share/nvim/plugged')

" Align, surround and repeat.
Plug 'junegunn/vim-easy-align'                     " Alignment.
Plug 'machakann/vim-sandwich'                      " Surround text.
Plug 'tpope/vim-repeat'                            " Repeat for plugins.

" Colorschemes and highlighting.
Plug 'lifepillar/vim-gruvbox8'                     " Speedy gruvbox theme.
Plug 'nvim-treesitter/nvim-treesitter', {
  \ 'do': ':TSUpdate' }                            " Treesitter highlighting.
Plug 'p00f/nvim-ts-rainbow'                        " Treesitter rainbow parentheses.

" Commands.
Plug 'lambdalisue/suda.vim'                        " Read and write with sudo.
Plug 'moll/vim-bbye'                               " Delete buffers without closing window.
Plug 'tpope/vim-eunuch'                            " Unix helpers.

" Comments and documentation.
Plug 'kkoomen/vim-doge', {
  \ 'do': { -> doge#install() } }                  " Generate documentation.
Plug 'tpope/vim-commentary'                        " Comment text.

" Completion, diagnostics and spelling.
Plug 'SirVer/ultisnips'                            " Snippets.
Plug 'hrsh7th/nvim-compe'                          " Completion from LSP.
Plug 'neovim/nvim-lspconfig'                       " LSP configuration.
Plug 'ojroques/nvim-lspfuzzy'                      " Fzf + LSP interface.
Plug 'ray-x/lsp_signature.nvim'                    " LSP signature help.

" Debug.
" Plug 'dstein64/vim-startuptime'                  " Check startup times.

" Integration.
Plug 'airblade/vim-rooter'                         " Set pwd to root directory.
Plug 'axelf4/vim-strip-trailing-whitespace'        " Remove trailing whitespace.
Plug 'editorconfig/editorconfig-vim'               " Editorconfig.
Plug 'shumphrey/fugitive-gitlab.vim'               " Fugitive GitLab support.
Plug 'sickill/vim-pasta'                           " Paste with smart indentation.
Plug 'tpope/vim-fugitive'                          " Git.
Plug 'tpope/vim-rhubarb'                           " Fugitive GitHub support.
Plug 'tpope/vim-speeddating'                       " Increment / decrement dates, times and more.

" Interface.
Plug 'ap/vim-buftabline'                           " Buffer line.
Plug 'camspiers/lens.vim'                          " Resize windows based on content.
Plug 'dyng/ctrlsf.vim'                             " Search and replace over multiple files.
Plug 'itchyny/lightline.vim'                       " Status line.
Plug 'mhinz/vim-startify'                          " Launch screen.
Plug 'tversteeg/registers.nvim'                    " Interactive registers.
Plug 'voldikss/vim-floaterm'                       " Floating terminal.
Plug 'whiteinge/diffconflicts'                     " Git mergetool

" Search, replace and navigation.
Plug 'antoinemadec/coc-fzf'                        " Coc Fzf lists.
Plug 'bronson/vim-visual-star-search'              " Visual star search.
Plug 'junegunn/fzf.vim'                            " Fzf.
Plug 'justinmk/vim-sneak'                          " Quick jump.


" Syntax.
Plug 'sheerun/vim-polyglot'                        " Language pack.

" Text objects and motions.
Plug 'christoomey/vim-sort-motion'                 " Sort by motion text object.
Plug 'michaeljsmith/vim-indent-object'             " Indent text object.
Plug 'wellle/targets.vim'                          " Additional text objects.

call plug#end()
