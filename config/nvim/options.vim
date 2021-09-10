"  ┏┓ ┏━┓┏━┓┏━╸   ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

set clipboard=unnamedplus         " Use the + (clipboard) register.
set colorcolumn=80                " Indicate column 80 with a colored column.
set conceallevel=2                " Disable character conceal.
set exrc                          " Source local vimrc at root directory.
set gdefault                      " Use 'g' flag by default with :s/foo/bar/.
set hidden                        " Set buffer as hidden when abandoned.
set lazyredraw                    " Enable lazy redraw.
set mouse=a                       " Enable mouse.
set noshowmode                    " Disable show mode.
set nostartofline                 " Do not jump to first character with page commands.
set ruler                         " Show the cursor position all the time.
set scrolloff=8                   " Set scrol offset to 8 lines.
set shortmess+=Ic                 " Disable version intro text.
set showcmd                       " Display incomplete commands.
set signcolumn=yes                " Always show sign column.
set termguicolors                 " Enable 24-bit colors.
set tildeop                       " Enable ~ operator.
set timeoutlen=400                " Timeout Leader after 400 ms.
set updatetime=100                " Set update time to 100 ms.
set virtualedit=block             " Enable virtualedit when in Visual Block mode.

" Case.
set noignorecase                  " Enforce correct case.
set nosmartcase                   " Disable smart case.

" Searching.
set inccommand=nosplit            " Highlight patterns and ranges for Ex commands.
set incsearch                     " Highlight search results as you type.
set showmatch                     " Show matching brackets.

" Spelling and dictionary.
set dictionary+=/usr/share/dict/words
set spellfile=~/.config/nvim/spell/en.utf-8.add
set spelllang=en_us
set spelloptions="camel"

" Complete.
set completeopt=menuone,noselect  " Set compete options.
set pumheight=20                  " Show max 20 items in completion menu.
set wildignorecase                " Disable case check for wildmenu.
set wildmenu                      " Enable wildmenu.
set wildmode=longest:full,full    " Set wildmenu modes.

" Cursor.
set nocursorline                  " Show no cursorline by default. Autocmd enables
                                  " cursorline for the active window.

" Tabs and spaces.
set expandtab                     " Insert spaces when TAB is pressed.
set nojoinspaces                  " Prevents inserting two spaces after punctuation on a join (J).
set shiftwidth=2                  " Indentation amount for < and > commands.
set tabstop=2                     " Render Tabs using this many spaces.

" Whitespace.
set fillchars+=diff:╱             " Set fill chars.
set list                          " Show characters listed in 'listchars'.
set listchars=extends:›,precedes:‹,tab:→\ ,nbsp:•,trail:•
set showbreak=↲\                  " Set show break character.

" Folding.
set foldenable                    " Enable folding.
set foldlevelstart=99             " Folding level.
set foldnestmax=4                 " Folding max.

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
set suffixesadd=.css,.go,.html,.js,.json,.jsx,.lua,.md,.scss,.sh,.ts,.tsx,.yaml,.yml

" Set programs.
set grepformat=%f:%l:%c:%m,%f:%l:%m
set grepprg=rg\ --vimgrep\ --no-heading
