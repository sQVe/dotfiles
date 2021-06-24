"  ┏┓ ┏━┓┏━┓┏━╸   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ┗━┛╹ ╹┗━┛┗━╸   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" Use <Space> as Leader key.
let mapleader = " "

" Escape.
inoremap jj <Esc>
inoremap <F1> <Esc>

" Remove search highlight.
nnoremap <silent> <Esc><Esc> :nohl<CR>

" Quick command.
noremap ö :
noremap Ö :
noremap qö q:
noremap qÖ q:

" Escape terminal.
tnoremap <C-q> <C-\><C-n>

" Motion.
noremap <Up> gk
noremap <Down> gj
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
noremap k gk
noremap j gj
noremap gk k
noremap gj j

" Consistent Y.
noremap Y y$

" Consistent search with n and N.
noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

" Consistent find with ; and ,.
noremap <expr> , getcharsearch().forward ? ';' : ','
noremap <expr> ; getcharsearch().forward ? ',' : ';'

" Quick save.
noremap <silent> <Leader><Leader> :update<CR>

" Quit and close buffer.
noremap <silent> <Leader>q :quit<CR>
noremap <silent> <Leader>Q :quit!<CR>
noremap <silent> <Leader>d :Bdelete<CR>
noremap <silent> <Leader>D :Bwipeout<CR>

" Easy and consistent search.
noremap + /

" Indent and un-indent without loosing selection.
vnoremap < <gv
vnoremap > >gv

" Term.
noremap <silent> <Leader><CR> :Term<CR><CR>
noremap <silent> <Leader><Backspace> :BTerm<CR><CR>

" Move between buffers.
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprev<CR>

" Move between jumps.
nnoremap <C-o> <C-o>
nnoremap <C-p> <C-i>

" Move between open windows.
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-Left> :wincmd h<CR>
nnoremap <silent> <C-Down> :wincmd j<CR>
nnoremap <silent> <C-Up> :wincmd k<CR>
nnoremap <silent> <C-Right> :wincmd l<CR>

" Quick window resize.
nnoremap <silent> <C-S-Left> :vertical resize -10<CR>
nnoremap <silent> <C-S-Down> :resize -10<CR>
nnoremap <silent> <C-S-Up> :resize +10<CR>
nnoremap <silent> <C-S-Right> :vertical resize +10<CR>

" Spell completion.
inoremap <C-x><C-s> <C-x>s

" Setting toggles.
nnoremap <silent> yoc :setlocal cursorline!<CR>
nnoremap <silent> yoe :setlocal conceallevel=<C-r>=&conceallevel == 0 ? '2' : '0'<CR><CR>
nnoremap <silent> yon :setlocal number!<CR>
nnoremap <silent> yor :setlocal relativenumber!<CR>
nnoremap <silent> yos :setlocal spell!<CR>
nnoremap <silent> you :setlocal cursorcolumn!<CR>
nnoremap <silent> yow :setlocal wrap!<CR>

imap <C-s> <C-o><C-s>
map <C-s> yos

" Star search but stay at same word.
map <C-n> *N


"  ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <Leader>z :Z<Space>
vnoremap K "oy<Esc>:Ddg<CR>


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <silent> gx :call OpenFileOrUrlWithMimeo()<CR>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
