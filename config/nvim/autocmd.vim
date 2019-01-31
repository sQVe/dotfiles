
"  ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
"  ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
"  ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛


" Force formatoptions to exclude 'o'.
augroup ExcludeFormatOptions
  autocmd!
  autocmd FileType * setlocal formatoptions-=o
augroup END

" Add all buffers to Fasd database.
augroup FasdUpdate
  autocmd!
  autocmd BufWinEnter,BufFilePost * call FasdUpdate()
augroup END

" Focus active window.
augroup FocusActiveWindow
  autocmd!
  autocmd WinLeave * call ToggleWindowFocus(0)
  autocmd BufWinEnter,VimEnter,WinEnter * call ToggleWindowFocus(1)
augroup END

" Reload buffer on enter or focus.
augroup ReloadBuffer
  autocmd!
  autocmd FocusGained,BufEnter * :silent! !
augroup END

" Override colorscheme.
augroup OverrideColorScheme
  autocmd!
  autocmd ColorScheme * hi! link HighlightedyankRegion DraculaSearch
augroup END

" Save notes.
augroup SaveNotes
  autocmd!
  autocmd BufWritePost $HOME/notes/*.md :silent exec "!($HOME/scripts/notes-send.sh &)"
augroup END

" Quick terminal exit.
augroup QuickTerminalExit
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
augroup END

