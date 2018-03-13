" --------------------------------------------------
" PLUGINS
" --------------------------------------------------

call plug#begin('$HOME/.local/share/nvim/plugged')

" -- Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }

" -- Language
Plug 'hail2u/vim-css3-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-markdown'
Plug 'wavded/vim-stylus'

" TODO: Enable this once it plays nicely with Ale.
" https://github.com/styled-components/vim-styled-components/issues/36
"Plug 'fleischie/vim-styled-components'

" -- Interface
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

" -- Integration
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '$HOME/.local/share/nvim/apps/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'w0rp/ale'

" -- Commands
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" -- Syntax & formatting
Plug 'luochen1990/rainbow'

" -- Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'mhartington/nvim-typescript', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'

" -- Snippets
Plug 'sirver/ultisnips'

call plug#end()

" --------------------------------------------------
" PLUGIN CONFIG
" --------------------------------------------------

" -- Colorschemes
colorscheme dracula

" Lightline
let g:lightline = {
  \ 'colorscheme': 'Dracula',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'filetype', 'fileencoding', 'fileformat' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \ },
  \ }

" BufTabLine
hi default link BufTabLineCurrent Identifier
hi default link BufTabLineActive  Character
hi default link BufTabLineHidden  Comment
hi default link BufTabLineFill    LineNr

" -- Ale
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '››'
let g:ale_sign_warning = '••'
let g:ale_linters = {
  \  'javascript': ['eslint'],
  \  'sh': ['shellcheck'],
  \ }
let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'json': ['prettier', 'eslint'],
  \ }

" Vim Fugitive
autocmd BufReadPost *.git/index  set nobuflisted        " Set Gstatus as a preview window.

" -- FZF
let $FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-n': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Javascript
let g:javascript_plugin_jsdoc = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1

" Nvim Typescript
let g:nvim_typescript#javascript_support = 1

" LanguageClient
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
  \ 'haskell': ['hie', '--lsp'],
  \ }

  " TODO: Use JavaScript LangServer when it is more stable.
  " https://github.com/sourcegraph/javascript-typescript-langserver/issues/432#issuecomment-368337905
  "\ 'javascript': ['javascript-typescript-stdio'],
  "\ 'javascript.jsx': ['javascript-typescript-stdio'],

" Better Whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave

" NERDTree
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMapOpenSplit = 'n'
let g:NERDTreeChDirMode = 2

" NERDComment
let g:NERDCommentEmptyLines = 1

" Easymotion
let g:EasyMotion_keys = 'asdfhjklerui'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_grouping = 2

" UltiSnips
let g:UltiSnipsExpandTrigger = '<C-Space>'
let g:UltiSnipsSnippetsDir = $HOME.'/.config/nvim/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']

" Supertab
let g:SuperTabMappingForward = '<S-Tab>'
let g:SuperTabMappingBackward = '<Tab>'

" Rainbow
let g:rainbow_active = 1

" --------------------------------------------------
" PLUGIN MAPPINGS
" --------------------------------------------------

" Ale
noremap <Leader>al :ALEToggle<Cr>
noremap <Silent> <Leader>an <Plug>(ale_next_wrap)
noremap <Silent> <Leader>ap <Plug>(ale_previous_wrap)
noremap <Silent> <Leader>af <Plug>(ale_fix)

" Easymotion
map <Leader> <Plug>(easymotion-prefix)
map <Leader>s <Plug>(easymotion-s)
map <Leader>S <Plug>(easymotion-overwin-f)
map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)
map <Leader>t <Plug>(easymotion-t)
map <Leader>T <Plug>(easymotion-T)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)

" Git gutter
noremap Ä :GitGutterNextHunk<CR>
noremap Å :GitGutterPrevHunk<CR>

" FZF
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>: :History:<CR>
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>B :Window<CR>
nnoremap <Leader>c :BCommits<CR>
nnoremap <Leader>C :Commits<CR>
nnoremap <Leader>i :BLines<CR>
nnoremap <Leader>I :Lines<CR>
nnoremap <Leader>z :Commands<CR>
nnoremap ö :Files<CR>
nnoremap Ö :History<CR>

" Vim Fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gf :Gfetch<CR>
nnoremap <Leader>gfm :Gpull<CR>
nnoremap <Leader>gm :Gmerge<CR>
nnoremap <Leader>go :Gbrowse<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>

" NERDTree
noremap <Leader>o :NERDTreeToggle<CR>
noremap <Leader>O :NERDTreeFind<CR>

" UltiSnips
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
