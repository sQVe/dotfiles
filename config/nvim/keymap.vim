
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
noremap <Leader>q :bdelete<CR>
noremap <Leader>Q :bdelete!<CR>
noremap <Leader>d :Bclose<CR>
noremap <Leader>D :Bclose!<CR>

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
nnoremap <S-Tab> :bprev<CR>
nnoremap <Tab> :bnext<CR>
vnoremap <S-Tab> :bprev<CR>
vnoremap <Tab> :bnext<CR>
noremap <M-h> :bprev<CR>
noremap <M-l> :bnext<CR>
noremap <M-Left> :bprev<CR>
noremap <M-Right> :bnext<CR>

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


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <C-s> :ToggleSpellCheck<CR>
nnoremap <C-s><C-g> :ToggleGrammarCheck<CR>
nnoremap <C-s><C-s> :ToggleSpellCheck<CR>
nnoremap <C-s>g :ToggleGrammarCheck<CR>
nnoremap <C-s>s :ToggleSpellCheck<CR>

nnoremap <Leader>c :ToggleConceal<CR>
nnoremap <Leader>n :ToggleRelativeNumber<CR>
nnoremap <Leader>r :ToggleGoldenRatio<CR>
nnoremap <Leader>z :Fasd<Space>
nnoremap <Leader>zo :Fasd<Space>
nnoremap <Leader>zz :FasdCd<Space>


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" Ale.
noremap <Leader>ea :ALEToggleBuffer<CR>
noremap <Leader>ej :ALENextWrap<CR>
noremap <Leader>ek :ALEPreviousWrap<CR>

" Coc.
nmap <Leader>ec <Plug>(coc-codeaction)
nmap <Leader>ed <Plug>(coc-definition)
nmap <Leader>ef <Plug>(coc-fix-current)
nmap <Leader>eh :ShowDocumention<CR>
nmap <Leader>ei <Plug>(coc-implementation)
nmap <Leader>en <Plug>(coc-rename)
nmap <Leader>eo :CocList outline<CR>
nmap <Leader>er <Plug>(coc-references)
nmap <Leader>es :CocList -I symbols<CR>
nmap <Leader>et <Plug>(coc-type-definition)
nmap <Leader>eu :CocList snippets<CR>

imap <C-Space> <Plug>(coc-snippets-expand)
imap <C-j> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)

" EasyMotion.
map s <Plug>(easymotion-s)
map S <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s)
vmap S <Plug>(easymotion-s2)

" EasyAlign.
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Fugitive and Signify.
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gf :Gfetch<CR>
nmap <Leader>gj <Plug>(signify-next-hunk)
nmap <Leader>gk <Plug>(signify-prev-hunk)
nnoremap <Leader>gl :Commits<CR>
nnoremap <Leader>glb :BCommits<CR>
nnoremap <Leader>gmt :MergetoolToggle<CR>
nnoremap <Leader>gu :Gbrowse<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gpf :Gpush --force-with-lease<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :vertical Gstatus<CR>
nnoremap <Leader>gss :Gstatus<CR>
nnoremap <Leader>gsv :vertical Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>

" FZF.
nnoremap <Backspace> :Buffers<CR>
nnoremap <Leader>/ :Rg<Space>
nnoremap Ä :Rg<Space>
nnoremap ä :Files<CR>

" Import JS.
nnoremap <Leader>ii :ImportJSFix<CR>
nnoremap <Leader>iw :ImportJSWord<CR>
nnoremap <Leader>id :ImportJSGoto<CR>

" Ranger.
nnoremap å :Ranger<CR>
nnoremap Å :RangerWorkingDirectory<CR>
