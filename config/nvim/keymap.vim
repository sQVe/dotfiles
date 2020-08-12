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

" Quick save.
noremap <Leader><Leader> :write<CR>

" Quit and close buffer.
noremap <silent> <Leader>q :quit<CR>
noremap <silent> <Leader>Q :quit!<CR>
noremap <silent> <Leader>d :Bwipeout<CR>
noremap <silent> <Leader>D :Bwipeout!<CR>

" Easy and consistent search.
noremap + /

" Term.
noremap <silent> <Leader><CR> :Term<CR><CR>
noremap <silent> <Leader>t :BTerm<CR><CR>

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

" Quicker window resize.
nnoremap <silent> <C-S-Left> :vertical resize -10<CR>
nnoremap <silent> <C-S-Down> :resize -10<CR>
nnoremap <silent> <C-S-Up> :resize +10<CR>
nnoremap <silent> <C-S-Right> :vertical resize +10<CR>

" Spell completion.
inoremap <C-x><C-s> <C-x>s

" Set pwd to current open buffer path.
nnoremap cd :Cdb<CR>:pwd<CR>


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
nnoremap <silent> [c :ALEPreviousWrap<CR>
nnoremap <silent> ]c :ALENextWrap<CR>

" Coc.
nnoremap <silent> <Leader>o :CocList --auto-preview --tab outline<CR>
nnoremap <silent> <Leader>O :CocList --auto-preview --interactive --tab symbols<CR>
nmap <silent> <Leader>f <Plug>(coc-fix-current)
nmap <silent> <Leader>r <Plug>(coc-rename)
nnoremap <silent> K :ShowDocumentation<CR>
nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gR :CocSearch \b<C-R>=expand("<cword>")<CR>\b<CR>
nmap <silent> gb <Plug>(coc-range-select)
xmap <silent> gb <Plug>(coc-range-select)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

imap <silent> <C-l> <Plug>(coc-snippets-expand)
imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)
vmap <silent> <C-j> <Plug>(coc-snippets-select)

" Use <Tab> tigger completion and to navigate the completion list.
inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ CheckBackSpace() ? "\<Tab>" :
  \ coc#refresh()

" Use <S-Tab> to navigate the completion list.
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <C-Space> to open completion menu.
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <CR> to confirm completion.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" EasyAlign.
xmap <silent> ga <Plug>(EasyAlign)
nmap <silent> ga <Plug>(EasyAlign)

" FZF.
nnoremap <Leader>+ :Rg<Space>
nnoremap <Leader>/ :Rg<Space>
nnoremap <silent> <Backspace> :Buffers<CR>
nnoremap <silent> <Leader>gL :Commits<CR>
nnoremap <silent> <Leader>gl :BCommits<CR>
nnoremap <silent> mm :Marks<CR>
nnoremap <silent> ä :Files<CR>
nnoremap <silent> å :BFiles<CR>


" Floaterm.
nnoremap <silent> Ä :FloatermNew vifm .<CR>
nnoremap <silent> Å :FloatermNew vifm<CR>

" Fugitive and coc-git.
nmap <silent> <Leader>gj <Plug>(coc-git-prevchunk)
nmap <silent> <Leader>gk <Plug>(coc-git-nextchunk)
omap <silent> ig <Plug>(coc-git-chunk-inner)
xmap <silent> ig <Plug>(coc-git-chunk-inner)
omap <silent> ag <Plug>(coc-git-chunk-outer)
xmap <silent> ag <Plug>(coc-git-chunk-outer)
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gf :Gfetch<CR>
nnoremap <silent> <Leader>gmt :MergetoolToggle<CR>
nnoremap <silent> <Leader>gp :Gpush<CR>
nnoremap <silent> <Leader>gpf :Gpush --force-with-lease<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gs :vertical Gstatus<CR>
nnoremap <silent> <Leader>gu :GCopyUrl<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>

" Slash.
noremap <plug>(slash-after) zz

" Sneak.
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Visual Multi.
nmap <M-Down> <M-j>
nmap <M-Up> <M-k>

let g:VM_leader = '<Leader>m'
let g:VM_maps = {}
let g:VM_maps["Add Cursor At Pos"] = '<M-Space>'
let g:VM_maps["Add Cursor Down"] = '<M-j>'
let g:VM_maps["Add Cursor Up"] = '<M-k>'
let g:VM_maps["Select All"] = '<M-a>'
let g:VM_maps["p Paste Regions"] = '<M-p>'
