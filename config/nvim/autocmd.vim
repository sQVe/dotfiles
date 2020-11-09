"  ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
"  ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
"  ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

" Disable ALE for specific file extensions.
augroup DisableALEForFileExt
  autocmd!
  autocmd BufWinEnter,VimEnter,WinEnter *.d.ts :ALEDisableBuffer
augroup END

" Disable Netrw.
augroup DisableNetrw
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
augroup END

" Save commit message for later.
augroup SaveCommitMsg
  autocmd!
  autocmd BufWritePost */.git/COMMIT_EDITMSG
    \ :call writefile(nvim_buf_get_lines(0, 0, -1, 1), ".git/PREV_COMMIT_EDITMSG")
augroup END

" Ignore case for the command line.
augroup IgnoreCaseForCmdLine
  autocmd!
  autocmd CmdLineEnter : set ignorecase
  autocmd CmdLineLeave : set noignorecase
augroup END

" Force formatoptions to exclude 'o'.
augroup ExcludeFormatOptions
  autocmd!
  autocmd FileType * setlocal formatoptions-=o
augroup END

" Add all buffers to Z database.
augroup ZUpdate
  autocmd!
  autocmd BufWinEnter,BufFilePost * call ZUpdate()
augroup END

" Focus active window.
augroup FocusActiveWindow
  autocmd!
  autocmd WinLeave * call ToggleWindowFocus(0)
  autocmd BufWinEnter,VimEnter,WinEnter * call ToggleWindowFocus(1)
augroup END

" Handle textwidth newlines by adding a trailing whitespace, indicating that
" the paragraph continues on the next line. This is used by mutts
" 'text_flowed' option.
augroup HandleMailNewlines
  autocmd!
  autocmd FileType mail setlocal formatoptions+=aw
  autocmd FileType mail setlocal textwidth=72
  autocmd FileType mail DisableStripWhitespaceOnSave
augroup END

" Reload buffer on enter or focus.
augroup ReloadBuffer
  autocmd!
  autocmd FocusGained,BufEnter * silent! !
augroup END

" Save notes.
augroup SaveNotes
  autocmd!
  autocmd BufWritePost $HOME/notes/*.md silent exec "!($HOME/scripts/notes-send.sh &)"
augroup END

" Quick terminal exit.
augroup QuickTerminalExit
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
augroup END
