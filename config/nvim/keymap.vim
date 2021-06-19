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


"  ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <Leader>z :Z<Space>
vnoremap K "oy<Esc>:Ddg<CR>


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

nnoremap <silent> gx :call OpenFileOrUrlWithMimeo()<CR>


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

" EasyAlign.
xmap <silent> ga <Plug>(EasyAlign)
nmap <silent> ga <Plug>(EasyAlign)

" FZF.
nnoremap <Leader>+ :Rg<Space>
nnoremap <Leader>/ :Rg<Space>
nnoremap <Leader>? :Rg<Space>
nnoremap <silent> <Backspace> :Buffers<CR>
nnoremap <silent> <Leader>gL :Commits<CR>
nnoremap <silent> <Leader>gl :BCommits<CR>
nnoremap <silent> mm :Marks<CR>
nnoremap <silent> ä :Files<CR>
nnoremap <silent> å :BFiles<CR>
nnoremap gR :Rg <c-r><c-w>

" Floaterm.
nnoremap <silent> Ä :FloatermNew vifm .<CR>
nnoremap <silent> Å :FloatermNew vifm<CR>

" Fugitive.
nnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
nnoremap <silent> <Leader>gf :Git fetch<CR>
nnoremap <silent> <Leader>gi :GChunkInfo<CR>
nnoremap <silent> <Leader>gmt :MergetoolToggle<CR>
nnoremap <silent> <Leader>gp :Git push<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gs :vertical Git<CR>
nnoremap <silent> <Leader>gu :GChunkUndo<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>

" LSP.
nnoremap <silent> <Leader>a :lua vim.lsp.buf.code_action()<CR>
xnoremap <silent> <Leader>a :lua vim.lsp.buf.range_code_action()<CR>
nnoremap <silent> <Leader>s :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <Leader>S :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> K :ShowDocumentation<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> gy :lua vim.lsp.buf.type_definition()<CR>

" LSP compe.
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')

" LSP diagnostics.
nnoremap <silent> gl :lua vim.lsp.diagnostic.show_line_diagnostics({show_header = false})<CR>
nnoremap <silent> <Leader>lj :lua vim.lsp.diagnostic.goto_next({popup_opts = {show_header = false}})<CR>
nnoremap <silent> <Leader>lk :lua vim.lsp.diagnostic.goto_prev({popup_opts = {show_header = false}})<CR>
nnoremap <silent> <Leader>l :LspDiagnostics 0<CR>
nnoremap <silent> <Leader>L :LspDiagnosticsAll<CR>

" Slash.
noremap <plug>(slash-after) zz

" Sneak.
map F <Plug>Sneak_F
map T <Plug>Sneak_T
map f <Plug>Sneak_f
map t <Plug>Sneak_t
nmap <expr> , sneak#is_sneaking() ? '<Plug>Sneak_;' : ','
nmap <expr> ; sneak#is_sneaking() ? '<Plug>Sneak_,' : ','

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
