
"  ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
"  ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  General options  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
set clipboard=unnamedplus         " Use the + (clipboard) register.
set formatoptions+=o              " Continue comment marker in new lines.
set gdefault                      " Use 'g' flag by default with :s/foo/bar/.
set hidden                        " Set buffer as hidden when abandoned.
set mouse=a                       " Enable mouse.
set noshowmode                    " Disable show mode.
set nostartofline                 " Do not jump to first character with page commands.
set ruler                         " Show the cursor position all the time.
set showcmd                       " Display incomplete commands.
set tildeop                       " Enable ~ operator.
set timeoutlen=400                " Timeout Leader after 400 ms.
set updatetime=100                " Set update time to 100 ms.
set virtualedit=block             " Enable virtualedit when in Visual Block mode.
set conceallevel=2                " Conceal characters when possible.

" Searching.
set ignorecase                    " Make searching case insensitive.
set incsearch                     " Highlight search results as you type.
set showmatch                     " Show matching brackets.
set smartcase                     " Use case sensitive search when query has mixed case.

" Complete.
set wildmenu                      " Enable wildmenu.
set wildmode=longest,full         " Set wildmenu modes.
set completeopt=longest,menuone   " Set compete options.

" Cursor.
set cursorline                    " Show a cursor line.

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
set foldmethod=syntax             " Folding method.

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


" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  File and event specific options  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

" Reload buffer on enter or focus.
au FocusGained,BufEnter * :silent! !
