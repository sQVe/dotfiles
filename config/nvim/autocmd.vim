"  ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
"  ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
"  ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

" Disable Netrw.
augroup DisableNetrw
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
augroup END

" Equalize splits on resize.
augroup EqualizeSplitsOnResize
  autocmd!
  autocmd VimResized * wincmd =
augroup END

" Highlight yanked text.
augroup HighlightYank
  autocmd!
  autocmd! TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
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

" Reload buffer on enter or focus.
augroup ReloadBuffer
  autocmd!
  autocmd FocusGained,BufEnter * silent! !
augroup END

" Save commit message for later.
augroup SaveCommitMsg
  autocmd!
  autocmd BufWritePost */.git/COMMIT_EDITMSG
    \ :silent! call writefile(nvim_buf_get_lines(0, 0, -1, 1), ".git/PREV_COMMIT_EDITMSG")
augroup END

" Save notes.
augroup SaveNotes
  autocmd!
  autocmd BufWritePost $HOME/notes/*.md silent exec "!($HOME/scripts/vim/notes-send.sh &)"
augroup END

" Stop EFM Daemons.
augroup StopEfmDaemons
  autocmd!
  autocmd ExitPre * silent exec "!($HOME/scripts/vim/stop-efm-daemons.sh &)"
augroup END

" Quick terminal exit.
augroup QuickTerminalExit
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
augroup END
