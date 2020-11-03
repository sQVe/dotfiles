"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Check BackSpace helper for coc.nvim.
func! CheckBackSpace() abort
  let col = col('.') - 1

  return !col || getline('.')[col - 1]  =~# '\s'
endfunc

" Create and print ascii header.
func! PrintAsciiHeader(title)
  execute "read !toilet -f future " . a:title
  norm 0VkkgcwjjI kddjj
endfunc

" Search on Duck Duck Go.
func! SearchDdg(query)
  silent! exec ":silent ! open-qutebrowser 'https://duckduckgo.com/?q="
    \ . substitute((empty(a:query) ? @o : a:query), '\n', '', 'g') . "' &"
endfunc

" Show documentation.
func! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunc

" Toggle concealing.
func! ToggleConceal()
  if(&conceallevel == 2)
    set conceallevel=0
  else
    set conceallevel=2
  endif
endfunc

" ToggleWindowFocus.
func! ToggleWindowFocus(focused)
  if(a:focused)
    set cursorline
  else
    set nocursorline
  endif
endfunc

" Toggle relative numbering.
func! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" Toggle spell checking.
func! ToggleSpellCheck()
  set spell!
endfunc


"  ┏━┓╻ ╻┏━┓╺┳╸┏━╸┏┳┓   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┗━┓┗┳┛┗━┓ ┃ ┣╸ ┃┃┃   ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛ ╹ ┗━┛ ╹ ┗━╸╹ ╹   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Z.
func! Z(fragment)
  let l:directory = system('~/scripts/zlua/find.zsh ' . shellescape(a:fragment))

  if !empty(l:directory)
    execute 'cd' . ' ' . l:directory
    pwd
  endif
endfunc

func! ZUpdate() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    silent execute "!~/scripts/zlua/add-directory.zsh" . ' ' . expand('%:p:h')
  endif
endfunc


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Merge filename and modified flag for vim-lightline.
func! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunc
