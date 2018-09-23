
"  ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" Escape.
inoremap jj <Esc>
inoremap <F1> <Esc>

" Quick command.
noremap ö :
noremap Ö :

" Motion.
noremap <Up> gk
noremap <Down> gj
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
noremap k gk
noremap j gj
noremap gk k
noremap gj j

noremap <Leader>h ^
noremap <Leader>l g_
noremap <Leader>H ^
noremap <Leader>L g_

" Quick save.
noremap <Leader><Leader> :write<CR>

" Quit and close buffer.
noremap <Leader>q :quit<CR>
noremap <Leader>d :Bclose<CR>

" Start a new terminal at current pwd.
noremap <Leader>u :!urxvt & disown<CR><CR>

" Remove highlighted search result.
noremap <Esc><Esc> :nohl<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Set pwd to current open buffer path.
noremap cd :Cdb<CR>:pwd<CR>

" Switch between the last two files.
noremap <Leader><Tab> <C-^>

" Uniform split.
noremap <Ctrl-W>n :split<CR>

" Move between buffers.
nnoremap <S-Tab> :bprev<CR>
nnoremap <Tab> :bnext<CR>
vnoremap <S-Tab> :bprev<CR>
vnoremap <Tab> :bnext<CR>
noremap <M-h> :bprev<CR>
noremap <M-l> :bnext<CR>
noremap <M-Left> :bprev<CR>
noremap <M-Right> :bnext<CR>

" Use vertical split as default split.
noremap <C-S-w><C-S-s> :split<CR>
noremap <C-S-w>s :split<CR>
noremap <C-w><C-S-s> :split<CR>
noremap <C-w><C-s> :vsplit<CR>
noremap <C-w>s :vsplit<CR>

" Move between open windows.
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-Left> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l

" Spell completion.
inoremap <C-x><C-s> <C-x>s
