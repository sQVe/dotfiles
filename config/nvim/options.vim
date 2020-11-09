"  ┏┓ ┏━┓┏━┓┏━╸   ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

set clipboard=unnamedplus         " Use the + (clipboard) register.
set colorcolumn=80                " Indicate column 80 with a colored column.
set conceallevel=2                " Disable character conceal.
set gdefault                      " Use 'g' flag by default with :s/foo/bar/.
set hidden                        " Set buffer as hidden when abandoned.
set lazyredraw                    " Enable lazy redraw.
set mouse=a                       " Enable mouse.
set noshowmode                    " Disable show mode.
set nostartofline                 " Do not jump to first character with page commands.
set ruler                         " Show the cursor position all the time.
set shortmess+=Ic                 " Disable version intro text.
set showcmd                       " Display incomplete commands.
set signcolumn=yes                " Always show sign column.
set termguicolors                 " Enable 24-bit colors.
set tildeop                       " Enable ~ operator.
set timeoutlen=400                " Timeout Leader after 400 ms.
set updatetime=200                " Set update time to 200 ms.
set virtualedit=block             " Enable virtualedit when in Visual Block mode.

" Searching.
set inccommand=nosplit            " Highlight patterns and ranges for Ex commands.
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

let g:is_sh = 1                   " Enable default sh syntax.
let g:sh_fold_enabled = 4         " Fold down to if/do/for etc.

" Line number.
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

" Add file extension lookup when going to file.
set suffixesadd=.js,.jsx,.ts,.tsx,.sh.css,.scss,.md,.json,.yaml,.yml

" Colorscheme.
let g:gruvbox_italic = 1
let g:gruvbox_sign_column = 'bg0'

colorscheme gruvbox


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

" Ale.
let g:ale_disable_lsp = 1
let g:ale_echo_msg_format = '[%linter%] %s (%code%)'
let g:ale_fix_on_save = 1
let g:ale_sign_error = '■'
let g:ale_sign_info = '■'
let g:ale_sign_warning = '■'
let g:ale_virtualtext_cursor = 1

let g:ale_linter_aliases = {
  \ 'html': ['html', 'css', 'javascript'],
  \ 'mail': ['text'],
  \ 'javascript': ['javascript', 'css'],
  \ 'javascriptreact': ['javascript', 'css'],
  \ 'typescript': ['typescript', 'css'],
  \ 'typescriptreact': ['typescript', 'css'],
  \ }
let g:ale_linters = {
  \ 'css': ['stylelint'],
  \ 'scss': ['stylelint'],
  \ 'javascript': ['eslint'],
  \ 'javascriptreact': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'typescriptreact': ['eslint'],
  \ 'help': ['alex', 'proselint', 'write-good'],
  \ 'mail': ['alex', 'proselint', 'write-good'],
  \ 'markdown': ['alex', 'proselint', 'write-good'],
  \ 'text': ['alex', 'proselint', 'write-good'],
  \ 'sh': ['shellcheck'],
  \ }
let g:ale_fixers = {
  \ 'css': ['prettier', 'stylelint'],
  \ 'scss': ['prettier', 'stylelint'],
  \ 'javascript': ['eslint', 'prettier'],
  \ 'javascriptreact': ['eslint', 'prettier'],
  \ 'json': ['eslint', 'prettier'],
  \ 'typescript': ['eslint', 'prettier'],
  \ 'typescriptreact': ['eslint', 'prettier'],
  \ 'html': ['prettier'],
  \ 'markdown': ['prettier'],
  \ 'yaml': ['prettier'],
  \ 'sh': ['shfmt'],
  \ }

let g:ale_writegood_options = '--no-passive'

" Better Whitespace.
let g:strip_only_modified_lines = 1
let g:strip_whitespace_confirm = 0
let g:strip_whitespace_on_save = 1

" DoGe.
let g:doge_enable_mappings = 0
let g:doge_mapping_comment_jump_forward = '<C-j>'
let g:doge_mapping_comment_jump_backward = '<C-k>'

" Editorconfig.
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

" Emmet.
let g:user_emmet_settings = {
  \ 'javascript' : { 'extends' : 'jsx' },
  \ 'scss' : { 'extends' : 'css' },
  \ 'typescript.tsx' : { 'extends' : 'jsx' },
  \ }

" FZF.
let $FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git'
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit',
  \ }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'GruvboxRed'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'ColorColumn'],
  \ 'hl+':     ['fg', 'GruvboxPurple'],
  \ 'info':    ['fg', 'GruvboxPurple'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'GruvboxRed'],
  \ 'pointer': ['fg', 'GruvboxPurple'],
  \ 'marker':  ['fg', 'GruvboxOrange'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'],
  \ }
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('down:50%'), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('down:50%'),
  \   <bang>0)

" Floaterm.
let g:floaterm_autoclose = 1
let g:floaterm_wintitle = 0

" Fugitive.
let g:fugitive_pty = 0

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

" JavaScript.
let g:javascript_plugin_jsdoc = 1

" Lens.
let g:lens#animate = 0
let g:lens#height_resize_max = 30
let g:lens#height_resize_min = 10
let g:lens#width_resize_max = 100
let g:lens#width_resize_min = 20

" Lightline.
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

let g:lightline = {
  \ 'active': {
  \   'left': [[ 'mode', 'paste' ],
  \            [ 'gitbranch' ],
  \            [ 'filename', 'readonly' ]],
  \   'right': [[ 'lineinfo' ],
  \             [ 'percent' ],
  \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
  \             [ 'filetype' ]]
  \ },
  \ 'colorscheme': 'gruvbox',
  \ 'component_expand': {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_infos': 'lightline#ale#infos',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_errors': 'error',
  \   'linter_infos': 'right',
  \   'linter_ok': 'right',
  \   'linter_warnings': 'warning',
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'gitbranch': 'fugitive#head',
  \ },
  \ 'enable': {
  \   'tabline': 0
  \ },
  \ 'mode_map': {
  \   'R' : 'R',
  \   'V' : 'VL',
  \   'c' : 'C',
  \   'i' : 'I',
  \   'n' : 'N',
  \   'v' : 'V',
  \   "\<C-v>": 'VB',
  \   },
  \ }

" Markdown.
let g:vim_markdown_folding_level = 2
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1

" Markdown Preview.
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0

" Mergetool
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

" Pasta.
let g:pasta_disabled_filetypes = ['fugitive', 'markdown', 'yaml']

" Rooter.
let g:rooter_patterns = ['.git', '.editorconfig']
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1
let g:rooter_targets = '*'

" Sandwich.
runtime macros/sandwich/keymap/surround.vim

" Signify.
let g:signify_vcs_list = ['git']

" Sneak.
let g:sneak#absolute_dir = 1
let g:sneak#label = 1
let g:sneak#label_esc = "\<CR>"
let g:sneak#prompt = '> '
let g:sneak#s_next = 1
let g:sneak#target_labels = ";sftunqåäöSFGHLTUNRMQZÅÄÖ/?0"

" Startify.
let g:startify_change_to_dir = 0
let g:startify_commands = [
  \ { 'C': 'PlugClean' },
  \ { 'I': 'PlugInstall' },
  \ { 'U': 'Update' },
  \ ]
let g:startify_custom_header = startify#pad([
  \ '┏┓╻┏━╸┏━┓╻ ╻╻┏┳┓',
  \ '┃┗┫┣╸ ┃ ┃┃┏┛┃┃┃┃',
  \ '╹ ╹┗━╸┗━┛┗┛ ╹╹ ╹',
  \ '----------------',
  \ ])
let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

" Treesitter.
lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
}
EOF

" Visual Multi.
let g:VM_mouse_mappings = 1
let g:VM_theme = 'purplegray'
