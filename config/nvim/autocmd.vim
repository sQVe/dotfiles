
"  ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
"  ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
"  ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

" Reload buffer on enter or focus.
augroup reloadbuffer
  autocmd!
  autocmd FocusGained,BufEnter * :silent! !
augroup END

" Quick terminal exit.
augroup quickterminalexit
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
augroup END

augroup fasdupdate
  autocmd!
  autocmd BufWinEnter,BufFilePost * call FasdUpdate()
augroup END
