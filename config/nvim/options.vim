
"  ┏┓ ┏━┓┏━┓┏━╸   ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

set clipboard=unnamedplus         " Use the + (clipboard) register.
set conceallevel=2                " Conceal characters when possible.
set gdefault                      " Use 'g' flag by default with :s/foo/bar/.
set hidden                        " Set buffer as hidden when abandoned.
set mouse=a                       " Enable mouse.
set noshowmode                    " Disable show mode.
set nostartofline                 " Do not jump to first character with page commands.
set ruler                         " Show the cursor position all the time.
set showcmd                       " Display incomplete commands.
set termguicolors                 " Enable 24-bit colors.
set tildeop                       " Enable ~ operator.
set timeoutlen=400                " Timeout Leader after 400 ms.
set updatetime=250                " Set update time to 250 ms.
set virtualedit=block             " Enable virtualedit when in Visual Block mode.

" Searching.
set incsearch                     " Highlight search results as you type.
set showmatch                     " Show matching brackets.

" Spelling and dictionary.
set dictionary+=/usr/share/dict/words
set spellfile=~/.config/nvim/spell/en.utf-8.add

" Complete.
set wildmenu                      " Enable wildmenu.
set wildmode=longest:full,full    " Set wildmenu modes.
set completeopt=longest,menuone   " Set compete options.

" Cursor.
set nocursorline                  " Show no cursorline by default. Autocmd enables
                                  " cursorline for the active window.

" Tabs and spaces.
set expandtab                     " Insert spaces when TAB is pressed.
set nojoinspaces                  " Prevents inserting two spaces after punctuation on a join (J).
set shiftwidth=2                  " Indentation amount for < and > commands.
set tabstop=2                     " Render Tabs using this many spaces.

" Whitespace.
set list                          " Show characters listed in 'listchars'.
set showbreak=↲\                  " Set show break character.
set listchars=extends:›,precedes:‹,tab:→\ ,nbsp:•,trail:•

" Folding.
set foldenable                    " Enable folding.
set foldlevelstart=99             " Folding level.
set foldmethod=indent             " Folding method.

let g:is_sh = 1                   " Enable sh syntax folding.
let g:sh_fold_enabled = 4         " Fold down to if/do/for etc.

" Linenumber.
set number                        " Show the line numbers on the left side.
set relativenumber                " Relative line numbers.

" Disable backup.
set backupdir=/tmp
set directory=/tmp
set nobackup
set noswapfile
set nowritebackup

" More natural splits.
set splitbelow                    " Horizontal split below current.
set splitright                    " Vertical split to right of current.

" Undo.
set undodir=$HOME/.local/share/nvim/.undo,/tmp
set undofile                      " Keep a persistent backup file.


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

" Colorschemes.
colorscheme dracula

" Ale.
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters = {
  \ 'awk': ['gawk'],
  \ 'help': ['alex', 'proselint', 'write-good'],
  \ 'javascript': ['eslint'],
  \ 'mail': ['alex', 'proselint', 'write-good'],
  \ 'markdown': ['alex', 'proselint', 'write-good'],
  \ 'scss': ['sasslint'],
  \ 'sh': ['shellcheck'],
  \ 'text': ['alex', 'proselint', 'write-good'],
  \ 'typescript': ['tslint', 'tsserver'],
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
let g:strip_whitespace_confirm = 0

" EasyMotion.
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_grouping = 2
let g:EasyMotion_keys = 'fjdkslaruvmeic,wox.qpz-ghtybn'
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

" Fugitive Gitlab.
let g:fugitive_gitlab_domains = ['http://AnimechGitLab']

" FZF.
let $FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit',
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
  \ 'text': 0,
  \ }

let g:grammarous#disabled_rules = {
  \ '*' : ['DASH_RULE'],
  \ 'markdown' : ['COMMA_PARENTHESIS_WHITESPACE', 'DASH_RULE', 'EN_QUOTES', 'WHITESPACE_RULE'],
  \ }

let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#show_first_error = 1

" JavaScript.
let g:javascript_plugin_jsdoc = 1

" JsDoc.
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1
let g:jsdoc_param_description_separator = ' - '
let g:jsdoc_return_description = 0

" LanguageClient.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_selectionUI = "fzf"
let g:LanguageClient_serverCommands = {
  \ 'haskell': ['hie', '--lsp'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'scss': ['css-languageserver', '--stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'sh': ['bash-language-server', 'start'],
  \ 'typescript': ['javascript-typescript-stdio'],
  \ }

" Lightline.
let g:lightline = {
  \ 'colorscheme': 'dracula',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'bufferscount', 'filename' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'filetype', 'fileencoding', 'fileformat' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'bufferscount': 'GetBuffersCount',
  \ },
  \ }

" Markdown.
let g:vim_markdown_folding_level = 2
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1

" Mergetool
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

" Pasta.
let g:pasta_disabled_filetypes = ['fugitive', 'markdown', 'yaml']

" Ranger.
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

" Supertab.
let g:SuperTabDefaultCompletionType = '<C-n>'

" Sandwich.
runtime macros/sandwich/keymap/surround.vim

" TComment.
let g:tcomment_mapleader1 = "<C-_>"
let g:tcomment_mapleader2 = "<Leader>_"

" Visual Multi.
let g:VM_maps                    = {}
let g:VM_maps["Add Cursor Down"] = '<M-Down>'
let g:VM_maps["Add Cursor Up"]   = '<M-Up>'
let g:VM_maps["P Paste Regions"] = '<Leader>P'
let g:VM_maps["p Paste Regions"] = '<Leader>p'

let g:VM_mouse_mappings = 1
let g:VM_theme = 'pray'
