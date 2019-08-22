
"  ┏┓ ┏━┓┏━┓┏━╸   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ┗━┛╹ ╹┗━┛┗━╸   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" Use <Space> as Leader key.
let mapleader = " "

" Escape.
inoremap jj <Esc>
inoremap <F1> <Esc>

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

" Quick save.
noremap <Leader><Leader> :write<CR>

" Quit and close buffer.
noremap <silent> <Leader>q :bdelete<CR>
noremap <silent> <Leader>Q :bdelete!<CR>
noremap <silent> <Leader>d :Bclose<CR>
noremap <silent> <Leader>D :Bclose!<CR>

" Term.
noremap <silent> <Leader><CR> :Term<CR><CR>
noremap <silent> <Leader>t :BTerm<CR><CR>

" Remove highlighted search result.
nnoremap <Esc><Esc> :nohl<CR>

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

" Move between buffers.
nnoremap <silent> <S-Tab> :bprev<CR>
nnoremap <silent> <Tab> :bnext<CR>
vnoremap <silent> <S-Tab> :bprev<CR>
vnoremap <silent> <Tab> :bnext<CR>
noremap <silent> <M-h> :bprev<CR>
noremap <silent> <M-l> :bnext<CR>
noremap <silent> <M-Left> :bprev<CR>
noremap <silent> <M-Right> :bnext<CR>

" Move between open windows.
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-Left> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l

" Quicker window resize.
noremap <C-w>+ 10<C-w>+
noremap <C-w>- 10<C-w>-
noremap <C-w>< 20<C-w><
noremap <C-w>> 20<C-w>>

" Spell completion.
inoremap <C-x><C-s> <C-x>s


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <silent> <C-s> :ToggleSpellCheck<CR>
nnoremap <silent> <C-s><C-g> :ToggleGrammarCheck<CR>
nnoremap <silent> <C-s><C-s> :ToggleSpellCheck<CR>
nnoremap <silent> <C-s>g :ToggleGrammarCheck<CR>
nnoremap <silent> <C-s>s :ToggleSpellCheck<CR>

nnoremap <silent> <Leader>c :ToggleConceal<CR>
nnoremap <silent> <Leader>n :ToggleRelativeNumber<CR>
nnoremap <silent> <Leader>z :Fasd<Space>
nnoremap <silent> <Leader>zo :Fasd<Space>
nnoremap <silent> <Leader>zz :FasdCd<Space>


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" Ale.
noremap <Leader>a :ALEToggleBuffer<CR>
noremap <silent> [c :ALEPreviousWrap<CR>
noremap <silent> ]c :ALENextWrap<CR>

" Coc.
nmap <silent> <Leader>o :CocList outline<CR>
nmap <silent> <Leader>O :CocList -I symbols<CR>
nmap <silent> <Leader>f <Plug>(coc-fix-current)
nmap <silent> <Leader>r <Plug>(coc-rename)
nmap <silent> K :ShowDocumention<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

imap <silent> <C-l> <Plug>(coc-snippets-expand)
imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)
vmap <silent> <C-j> <Plug>(coc-snippets-select)

" Use <Tab> to move to next completion item.
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackSpace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <C-Space> to open completion menu.
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <CR> to confirm completion.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" EasyMotion.
map <silent> s <Plug>(easymotion-s)
map <silent> S <Plug>(easymotion-s2)
vmap <silent> s <Plug>(easymotion-s)
vmap <silent> S <Plug>(easymotion-s2)

" EasyAlign.
xmap <silent> ga <Plug>(EasyAlign)
nmap <silent> ga <Plug>(EasyAlign)

" Fugitive and Signify.
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gf :Gfetch<CR>
nmap <silent> <Leader>gj <Plug>(signify-next-hunk)
nmap <silent> <Leader>gk <Plug>(signify-prev-hunk)
nnoremap <silent> <Leader>gl :Commits<CR>
nnoremap <silent> <Leader>glb :BCommits<CR>
nnoremap <silent> <Leader>gmt :MergetoolToggle<CR>
nnoremap <silent> <Leader>gu :Gbrowse<CR>
nnoremap <silent> <Leader>gp :Gpush<CR>
nnoremap <silent> <Leader>gpf :Gpush --force-with-lease<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gs :vertical Gstatus<CR>
nnoremap <silent> <Leader>gss :Gstatus<CR>
nnoremap <silent> <Leader>gsv :vertical Gstatus<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>

" FZF.
nnoremap <silent> <Backspace> :Buffers<CR>
nnoremap <Leader>/ :Rg<Space>
nnoremap Ä :Rg<Space>
nnoremap <silent> ä :Files<CR>

" Import JS.
nnoremap <silent> <Leader>ii :ImportJSFix<CR>
nnoremap <silent> <Leader>iw :ImportJSWord<CR>
nnoremap <silent> <Leader>id :ImportJSGoto<CR>

" Vifm.
nnoremap <silent> å :Vifm<CR>
nnoremap <silent> Å :Vifm .<CR>
