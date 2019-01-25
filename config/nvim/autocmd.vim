
"  ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
"  ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
"  ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

" Add all buffers to Fasd database.
augroup FasdUpdate
  autocmd!
  autocmd BufWinEnter,BufFilePost * call FasdUpdate()
augroup END

" Force formatoptions to exclude 'o'.
augroup ExcludeFormatOptions
  autocmd!
  autocmd FileType * setlocal formatoptions-=o
augroup END

" Reload buffer on enter or focus.
augroup ReloadBuffer
  autocmd!
  autocmd FocusGained,BufEnter * :silent! !
augroup END

" Quick terminal exit.
augroup QuickTerminalExit
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
augroup END

