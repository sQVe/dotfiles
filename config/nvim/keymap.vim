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

" Move selected code up and down.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Quick save.
noremap <Leader><Leader> :write<CR>

" Quit and close buffer.
noremap <silent> <Leader>q :quit<CR>
noremap <silent> <Leader>Q :quit!<CR>
noremap <silent> <Leader>d :Bdelete<CR>
noremap <silent> <Leader>D :Bdelete!<CR>

" Term.
noremap <silent> <Leader><CR> :Term<CR><CR>
noremap <silent> <Leader>t :BTerm<CR><CR>

" Remove highlighted search result.
nnoremap <Esc><Esc> :nohl<CR>

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
noremap <silent> <C-S-Up> :resize +10<CR>
noremap <silent> <C-S-Down> :resize -10<CR>
noremap <silent> <C-S-Left> :vertical resize -10<CR>
noremap <silent> <C-S-Right> :vertical resize +10<CR>

" Spell completion.
inoremap <C-x><C-s> <C-x>s


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <C-s> :ToggleSpellCheck<CR>
nnoremap <Leader>c :ToggleConceal<CR>
nnoremap <Leader>n :ToggleRelativeNumber<CR>
nnoremap <Leader>z :Z<Space>


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" Ale.
noremap <silent> [c :ALEPreviousWrap<CR>
noremap <silent> ]c :ALENextWrap<CR>

" Coc.
nmap <Leader>/ :CocSearch<Space>
nmap <silent> <Leader>o :CocList --auto-preview --tab outline<CR>
nmap <silent> <Leader>O :CocList --auto-preview --interactive --tab symbols<CR>
nmap <silent> <Leader>f <Plug>(coc-fix-current)
nmap <silent> <Leader>r <Plug>(coc-rename)
nmap <silent> K :ShowDocumentation<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gb <Plug>(coc-range-select)
xmap <silent> gb <Plug>(coc-range-select)
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
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" EasyAlign.
xmap <silent> ga <Plug>(EasyAlign)
nmap <silent> ga <Plug>(EasyAlign)

" Fugitive and coc-git.
nmap <silent> <Leader>gj <Plug>(coc-git-prevchunk)
nmap <silent> <Leader>gk <Plug>(coc-git-nextchunk)
omap <silent> ig <Plug>(coc-git-chunk-inner)
xmap <silent> ig <Plug>(coc-git-chunk-inner)
omap <silent> ag <Plug>(coc-git-chunk-outer)
xmap <silent> ag <Plug>(coc-git-chunk-outer)
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gf :Gfetch<CR>
nnoremap <silent> <Leader>gl :Commits<CR>
nnoremap <silent> <Leader>glb :BCommits<CR>
nnoremap <silent> <Leader>gmt :MergetoolToggle<CR>
nnoremap <silent> <Leader>gp :Gpush<CR>
nnoremap <silent> <Leader>gpf :Gpush --force-with-lease<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gs :vertical Gstatus<CR>
nnoremap <silent> <Leader>gss :Gstatus<CR>
nnoremap <silent> <Leader>gsv :vertical Gstatus<CR>
nnoremap <silent> <Leader>gu :GCopyUrl<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>

" FZF.
nnoremap <silent> <Backspace> :Buffers<CR>
nnoremap <silent> mm :Marks<CR>
nnoremap Ä :Rg<Space>
nnoremap <silent> ä :Files<CR>

" Slash.
noremap <plug>(slash-after) zz

" Sneak.
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Vifm.
nnoremap <silent> å :Vifm<CR>
nnoremap <silent> Å :Vifm .<CR>
