
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
Plug 'hail2u/vim-css3-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Interface.
Plug 'airblade/vim-gitgutter'
Plug 'francoiscabrol/ranger.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '$HOME/.local/share/nvim/apps/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'metakirby5/codi.vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'

" Integration.
Plug 'Galooshi/vim-import-js'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'mg979/vim-visual-multi'
Plug 'ntpeters/vim-better-whitespace'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sickill/vim-pasta'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

" Commands.
Plug 'godlygeek/tabular'
Plug 'lambdalisue/suda.vim'
Plug 'moll/vim-bbye'

" Completion and spelling.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'ervandew/supertab'
Plug 'rhysd/vim-grammarous'
Plug 'sirver/ultisnips'
Plug 'ujihisa/neco-look'

call plug#end()


" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Plugin options  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

" Colorschemes.
colorscheme dracula

" Ale.
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters = {
  \ 'awk': ['gawk'],
  \ 'javascript': ['eslint'],
  \ 'scss': ['sasslint'],
  \ 'sh': ['shellcheck'],
  \ 'typescript': ['tsserver', 'typecheck', 'tslint'],
  \ }
let g:ale_fixers = {
  \ 'css': ['prettier'],
  \ 'html': ['prettier'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'json': ['prettier', 'eslint'],
  \ 'markdown': ['prettier'],
  \ 'scss': ['prettier'],
  \ 'typescript': ['prettier', 'tslint'],
  \ 'yaml': ['prettier'],
  \ }

" Bclose.
let g:no_plugin_maps = 1

" Better Whitespace.
let g:strip_whitespace_on_save = 1

" Codi.
let g:codi#autoclose = 1
let g:codi#rightsplit = 0

" EasyMotion.
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_grouping = 2
let g:EasyMotion_keys = 'fjdkslaöruvmeic,wox.qpz-ghtybn'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_skipfoldedline = 0

" Emmet.
let g:user_emmet_settings = {
  \ 'javascript' : { 'extends' : 'jsx' },
  \ 'javascript.jsx' : { 'extends' : 'jsx' },
  \ 'less' : { 'extends' : 'css' },
  \ 'scss' : { 'extends' : 'css' },
  \ 'typescript' : { 'extends' : 'jsx' },
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
  \ 'typescript': ['look'],
  \ })
call deoplete#custom#source('look', 'min_pattern_length', 2)
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)
call deoplete#custom#source('dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source('dictionary', 'sorters', [])
call deoplete#custom#source('file', 'rank', 8888)
call deoplete#custom#source('ultisnips', 'rank', 9999)
call deoplete#custom#var('file', 'enable_buffer_path', v:true)

" Fugitive.
autocmd BufReadPost *.git/index  set nobuflisted

" Fugitive Gitlab.
let g:fugitive_gitlab_domains = ['http://AnimechGitLab']

" FZF.
let $FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-t': 'tab split',
  \ }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
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

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
command! -bang -nargs=* HistoryFiles
  \ call fzf#vim#history(fzf#vim#with_preview('right:50%', '?'))
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--hidden --follow --ignore .git', fzf#vim#with_preview('right:50%', '?'), <bang>0)

" GitGutter.
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = ' '
let g:gitgutter_sign_modified = ' '
let g:gitgutter_sign_removed = ''

" Grammarous.
let g:grammarous#default_comments_only_filetypes = {
  \ '*': 1,
  \ '': 0,
  \ 'help': 0,
  \ 'markdown': 0,
  \ 'notes': 0,
  \ 'text': 0,
  \ }

let g:grammarous#disabled_rules = {
  \ '*' : ['DASH_RULE'],
  \ 'markdown' : ['COMMA_PARENTHESIS_WHITESPACE', 'DASH_RULE', 'WHITESPACE_RULE'],
  \ 'notes' : ['COMMA_PARENTHESIS_WHITESPACE', 'DASH_RULE', 'WHITESPACE_RULE'],
  \ }

let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#show_first_error = 1

" JavaScript.
let g:javascript_plugin_jsdoc = 1

" JsDoc.
let g:jsdoc_enable_es6 = 1

" LanguageClient.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_selectionUI = "fzf"
let g:LanguageClient_serverCommands = {
  \ 'haskell': ['hie', '--lsp'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'sh': ['bash-language-server', 'start'],
  \ 'typescript': ['javascript-typescript-stdio'],
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

" Markdown.
let g:vim_markdown_folding_level = 2
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1

" Notes.
let g:notes_conceal_url = 0
let g:notes_directories = [$HOME.'/notes']
let g:notes_tab_indents = 0
let g:notes_word_boundaries = 1

hi! link notesDoneMarker DraculaGreenBold
hi! link notesInProgress DraculaCyanBold
hi! link notesListBullet DraculaPurple
hi! link notesListNumber DraculaPurple
hi! link notesTodo DraculaOrangeBold
hi! link notesXXX DraculaOrangeBold

autocmd Filetype notes setlocal shiftwidth=2 tabstop=2 textwidth=80

" TComment.
let g:tcomment_mapleader1 = "<C-_>"
let g:tcomment_mapleader2 = "<Leader>_"

" Ranger.
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

" Supertab.
let g:SuperTabDefaultCompletionType = '<C-n>'

" UltiSnips.
let g:UltiSnipsExpandTrigger = '<C-Space>'
let g:UltiSnipsSnippetsDir = $HOME.'/.config/nvim/ultisnips'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/ultisnips']

" Visual Multi.
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = '<M-Down>'
let g:VM_maps["Add Cursor Up"] = '<M-Up>'

let g:VM_mouse_mappings = 1
let g:VM_theme = 'pray'


" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Plugin mappings  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

" Ale.
noremap <Leader>ej :ALENextWrap<CR>
noremap <Leader>ek :ALEPreviousWrap<CR>

" Easymotion.
map <Leader> <Plug>(easymotion-prefix)
map <Leader>s <Plug>(easymotion-s)
map <Leader>S <Plug>(easymotion-overwin-f)
map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)
map <Leader>t <Plug>(easymotion-t)
map <Leader>T <Plug>(easymotion-T)
map <Leader>b <Plug>(easymotion-linebackward)
map <Leader>w <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Fugitive and Git Gutter.
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gf :Gfetch<CR>
nnoremap <Leader>gfm :Gpull<CR>
nnoremap <Leader>gh :GitGutterPreviewHunk<CR>
nnoremap <Leader>gj :GitGutterNextHunk<CR>
nnoremap <Leader>gk :GitGutterPrevHunk<CR>
nnoremap <Leader>gl :Commits<CR>
nnoremap <Leader>gL :BCommits<CR>
nnoremap <Leader>gm :Gmerge<CR>
nnoremap <Leader>go :Gbrowse<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>

" FZF.
nnoremap <Backspace> :Buffers<CR>
nnoremap <Leader>/ :Ag<Space>
nnoremap Ä :Ag<Space>
nnoremap ä :Files<CR>
autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>

" Ranger.
nnoremap å :Ranger<CR>
nnoremap Å :RangerWorkingDirectory<CR>

" Import JS.
nnoremap <Leader>ii :ImportJSFix<CR>
nnoremap <Leader>iw :ImportJSWord<CR>
nnoremap <Leader>id :ImportJSGoto<CR>

" LanguageClient.
nnoremap <Leader>ed :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>eh :call LanguageClient#textDocument_hover()<CR>
nnoremap <Leader>em :call LanguageClient_contextMenu()<CR>
nnoremap <Leader>en :call LanguageClient#textDocument_rename()<CR>
nnoremap <Leader>er :call LanguageClient#textDocument_references()<CR>
nnoremap <Leader>es :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <Leader>et :call LanguageClient#textDocument_typeDefinition()<CR>

" UltiSnips.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
