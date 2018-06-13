
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
" NOTE: vim-styled-components plugin is not compatible together with
" vim-javascript and rainbow. If we need this in the future then we need to
" disable rainbow.
" Plug 'fleischie/vim-styled-components'
Plug 'hail2u/vim-css3-syntax'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'wavded/vim-stylus'

" Interface.
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'francoiscabrol/ranger.vim'
Plug 'itchyny/lightline.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdcommenter'

" Integration.
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '$HOME/.local/share/nvim/apps/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'w0rp/ale'

" Commands.
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Completion.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'ervandew/supertab'
Plug 'ujihisa/neco-look'

" Snippets.
Plug 'sirver/ultisnips'

call plug#end()


" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Plugin options  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

" Colorschemes.
colorscheme dracula

" Ale.
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '››'
let g:ale_sign_warning = '••'
let g:ale_linters = {
  \ 'awk': ['gawk'],
  \ 'javascript': ['eslint'],
  \ 'sh': ['shellcheck'],
  \ }
let g:ale_fixers = {
  \ 'css': ['prettier'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'json': ['prettier', 'eslint'],
  \ 'less': ['prettier'],
  \ 'markdown': ['prettier'],
  \ 'scss': ['prettier'],
  \ }

" Better Whitespace.
autocmd BufEnter * EnableStripWhitespaceOnSave

" BufTabLine.
highlight default link BufTabLineCurrent Identifier
highlight default link BufTabLineActive  Character
highlight default link BufTabLineHidden  Comment
highlight default link BufTabLineFill    LineNr

" EasyMotion.
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_grouping = 2
let g:EasyMotion_keys = 'asdfhjklerui'
let g:EasyMotion_smartcase = 1

" Emmet.
let g:user_emmet_leader_key = ',,'
let g:user_emmet_settings = {
  \ 'javascript' : { 'extends' : 'jsx' },
  \ 'javascript.jsx' : { 'extends' : 'jsx' },
  \ 'less' : { 'extends' : 'css' },
  \ 'scss' : { 'extends' : 'css' },
  \ 'stylus' : { 'extends' : 'css' },
  \ }

" Deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('ignore_sources', {
  \ 'awk': ['look'],
  \ 'css': ['look'],
  \ 'haskell': ['look'],
  \ 'javascript': ['look'],
  \ 'javascript.jsx': ['look'],
  \ 'less': ['look'],
  \ 'scss': ['look'],
  \ 'sh': ['look'],
  \ 'stylus': ['look'],
  \ })
call deoplete#custom#source('dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source('dictionary', 'sorters', [])
call deoplete#custom#source('file', 'rank', 8888)
call deoplete#custom#source('look', 'min_pattern_length', 2)
call deoplete#custom#source('ultisnips', 'rank', 9999)
call deoplete#custom#var('file', 'enable_buffer_path', v:true)

" Fugitive.
autocmd BufReadPost *.git/index  set nobuflisted

" FZF.
let $FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
let g:fzf_action = {
  \ 'ctrl-S': 'split',
  \ 'ctrl-s': 'vsplit',
  \ 'ctrl-t': 'tab split',
  \ }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Boolean'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'],
  \ }

" JavaScript.
let g:javascript_plugin_jsdoc = 1

" LanguageClient.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_selectionUI = "fzf"
let g:LanguageClient_serverCommands = {
  \ 'haskell': ['hie', '--lsp'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'sh': ['bash-language-server', 'start'],
  \ }

" Lightline.
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

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--hidden --ignore .git --follow',
  \   <bang>0 ? fzf#vim#with_preview('hidden')
  \     : fzf#vim#with_preview('right:60%', '?'),
  \   <bang>0)

" Markdown.
let g:vim_markdown_folding_level = 2
let g:vim_markdown_new_list_item_indent = 2

" NERDComment.
let g:NERDCommentEmptyLines = 1

" Rainbow.
let g:rainbow_active = 1
let g:rainbow_conf = {
  \ 'separately': {
  \   'sh': 0,
  \ }
  \ }

" Ranger.
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

" Supertab.
let g:SuperTabDefaultCompletionType = '<C-n>'

" UltiSnips.
let g:UltiSnipsExpandTrigger = '<C-Space>'
let g:UltiSnipsSnippetsDir = $HOME.'/.config/nvim/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']


" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Plugin mappings  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

" Ale.
noremap <silent><Leader>ej <Plug>(ale_next_wrap)
noremap <silent><Leader>ek <Plug>(ale_previous_wrap)

" Easymotion.
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

" Git Gutter.
noremap å :GitGutterNextHunk<CR>
noremap Å :GitGutterPrevHunk<CR>

" Fugitive.
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

" FZF.
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>: :History:<CR>
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>B :Window<CR>
nnoremap <Leader>c :BCommits<CR>
nnoremap <Leader>C :Commits<CR>
nnoremap <Leader>i :BLines<CR>
nnoremap <Leader>I :Lines<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>z :Commands<CR>
nnoremap ö :Files<CR>
nnoremap Ö :History<CR>

" LanguageClient.
nnoremap <Leader>ed :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>en :call LanguageClient#textDocument_rename()<CR>
nnoremap <Leader>er :call LanguageClient#textDocument_references()<CR>
nnoremap <Leader>es :call LanguageClient#textDocument_documentSymbol()<CR>

" Ranger.
noremap <silent>ä :RangerWorkingDirectory<CR>
noremap <silent>Ä :Ranger<CR>

" UltiSnips.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
