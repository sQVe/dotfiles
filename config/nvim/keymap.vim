"  ┏┓ ┏━┓┏━┓┏━╸   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ┗━┛╹ ╹┗━┛┗━╸   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" Use <Space> as Leader key.
let mapleader = " "

" Escape.
inoremap jj <Esc>
inoremap <F1> <Esc>

" Remove search highlight.
nnoremap <silent> <Esc><Esc> <Cmd>nohl<CR>

" Quick command.
noremap ö :
noremap Ö :
noremap qö q:
noremap qÖ q:

" Escape terminal.
tnoremap <C-q> <C-\><C-n>

" Motion with jumplist mutations.
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
noremap <expr> <Down> (v:count > 4 ? "m'" . v:count : "") . 'gj'
noremap <expr> <Up> (v:count > 4 ? "m'" . v:count : "") . 'gk'
noremap <expr> j (v:count > 4 ? "m'" . v:count : "") . 'gj'
noremap <expr> k (v:count > 4 ? "m'" . v:count : "") . 'gk'
noremap gj j
noremap gk k

" Consistent centered search with n and N.
noremap <expr> n 'Nn'[v:searchforward] . 'zzzv'
noremap <expr> N 'nN'[v:searchforward] . 'zzzv'

" Consistent CR movement.
noremap <S-CR> -

" Keep cursor position when joining.
noremap J mzJ`z

" Close buffer.
noremap <silent> <Leader>d <Cmd>Bdelete<CR>
noremap <silent> <Leader>D <Cmd>Bwipeout<CR>

" Next and previous buffer.
noremap <silent> <Tab> <Cmd>bnext<CR>
noremap <silent> <S-Tab> <Cmd>bprev<CR>

" Easy and consistent search.
noremap + /

" Flip f, t, F and T repeat.
noremap , ;
noremap ; ,

" Indent and un-indent without loosing selection.
vnoremap < <gv
vnoremap > >gv

" Term.
noremap <silent> <Leader><CR> <Cmd>Term<CR><CR>
noremap <silent> <Leader><S-CR> <Cmd>BTerm<CR><CR>

" Move between jumps.
nnoremap <C-o> <C-o>
nnoremap <C-p> <C-i>

" Move between open windows.
nnoremap <silent> <C-h> <Cmd>wincmd h<CR>
nnoremap <silent> <C-j> <Cmd>wincmd j<CR>
nnoremap <silent> <C-k> <Cmd>wincmd k<CR>
nnoremap <silent> <C-l> <Cmd>wincmd l<CR>
nnoremap <silent> <C-Left> <Cmd>wincmd h<CR>
nnoremap <silent> <C-Down> <Cmd>wincmd j<CR>
nnoremap <silent> <C-Up> <Cmd>wincmd k<CR>
nnoremap <silent> <C-Right> <Cmd>wincmd l<CR>

" Quick window resize.
nnoremap <silent> <C-S-Left> <Cmd>vertical resize -10<CR>
nnoremap <silent> <C-S-Down> <Cmd>resize -10<CR>
nnoremap <silent> <C-S-Up> <Cmd>resize +10<CR>
nnoremap <silent> <C-S-Right> <Cmd>vertical resize +10<CR>

" Quickfix.
nnoremap <silent> <C-q>w <Cmd>copen<CR>
nnoremap <silent> <C-q><C-w> <Cmd>copen<CR>
nnoremap <silent> <C-q>q <Cmd>cclose<CR>
nnoremap <silent> <C-q><C-q> <Cmd>cclose<CR>
nnoremap <silent> <C-q>n <Cmd>cnext<CR>
nnoremap <silent> <C-q><C-n> <Cmd>cnext<CR>
nnoremap <silent> <C-q>p <Cmd>cprevious<CR>
nnoremap <silent> <C-q><C-p> <Cmd>cprevious<CR>

" Spell completion.
inoremap <C-x><C-s> <C-x>s

" Setting toggles.
nnoremap <silent> yoc :set conceallevel=<C-r>=&conceallevel == 0 ? '2' : '0'<CR><CR>
nnoremap <silent> yol <Cmd>set cursorline!<CR>
nnoremap <silent> yon <Cmd>set number!<CR>
nnoremap <silent> yor <Cmd>set relativenumber!<CR>
nnoremap <silent> yos <Cmd>set spell!<CR>
nnoremap <silent> yow <Cmd>set wrap!<CR>
imap <C-s> <C-o><C-s>
map <C-s> yos

" Star search but stay at same word.
map <C-n> *N

" Set undo breakpoints.
inoremap ! !<c-g>u
inoremap ( (<c-g>u
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap [ [<c-g>u
inoremap { {<c-g>u


"  ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <Leader>z <Cmd>Z<Space>
vnoremap K "oy<Esc><Cmd>Ddg<CR>


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <silent> gx <Cmd>call OpenFileOrUrlWithMimeo()<CR>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
