
"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Check BackSpace helper for coc.nvim.
function! CheckBackSpace() abort
  let col = col('.') - 1

  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Get count of all active buffers.
function! GetBuffersCount()
  return len(getbufinfo({'buflisted':1}))
endfunc

" Create and print ascii header.
function! PrintAsciiHeader(title)
  execute "read !toilet -f future " . a:title
  norm VkkgcejjA kddjj
endfunc

" Show documentation.
function! ShowDocumention()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Toggle concealing.
function! ToggleConceal()
  if(&conceallevel == 2)
    set conceallevel=0
  else
    set conceallevel=2
  endif
endfunc

" ToggleWindowFocus.
function! ToggleWindowFocus(focused)
  if(a:focused)
    set cursorline
  else
    set nocursorline
  endif
endfunction

" Toggle relative numbering.
function! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" Toggle spell checking.
function! ToggleSpellCheck()
  set spell!
endfunc


"  ┏━┓╻ ╻┏━┓╺┳╸┏━╸┏┳┓   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┗━┓┗┳┛┗━┓ ┃ ┣╸ ┃┃┃   ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛ ╹ ┗━┛ ╹ ┗━╸╹ ╹   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Fasd.
function! Fasd(type, executeWith, fragment)
  let l:fragment = system('fasd -1 ' . a:type . ' ' . shellescape(a:fragment))

  if !empty(l:fragment)
    execute a:executeWith . ' ' . l:fragment
    redraw
    echo split(l:fragment, '\n')[0]
  endif
endfunction

function! FasdUpdate() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    call jobstart(['fasd', '-A', expand('%:p')])
  endif
endfunction


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Start FZF in floating window.
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let width = float2nr(&columns - (&columns * 2 / 10))
  let height = 35

  let col = float2nr((&columns - width) / 2)
  let row = float2nr((&lines - height) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&number', 0)
  call setwinvar(win, '&relativenumber', 0)
endfunction

" Merge filename and modified flag for vim-lightline.
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" Toggle grammar checking.
function! ToggleGrammarCheck()
  if exists('b:grammarous_result')
    :GrammarousReset
  else
    :GrammarousCheck
  endif
endfunc
