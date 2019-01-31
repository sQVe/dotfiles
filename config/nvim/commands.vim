
"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" Add explanatory command! name for Bdelete (vim-bbye)
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

" Clear marks.
command! ClearMarks :delm! | delm A-Z0-9

" Clear registers.
command! ClearRegisters for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Delete all open buffers.
command! Bda bufdo bd

" Delete all buffers but the open one.
command! Bdo %bd|e#|bd#

" Show full path to open buffer.
command! Bpwd echo expand('%:p')

" Set pwd to path of open buffer.
command! Cdb cd %:p:h

" Copy.
command! Copy norm ggyG

" Write and close helpers.
command! Bc Bclose
command! WBc w | Bclose

" Write, close and quit typos.
command! W write
command! Q quit
command! Wq wq
command! WQ wq
command! Qa qa
command! QA qa
command! Wa wa
command! WA wa
command! Wbc Wbc


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" Fasd.
command! -nargs=1 Fasd call Fasd('-a', 'e', <q-args>)
command! -nargs=1 FasdCd call Fasd('-d', 'cd', <q-args>)

" Toggle concealing.
command! -nargs=0 ToggleConceal call ToggleConceal()

" Toggle relative numbering.
command! -nargs=0 ToggleRelativeNumber call ToggleRelativeNumber()

" Toggle spell checking.
command! -nargs=0 ToggleSpellCheck call ToggleSpellCheck()

" Toggle golden ratio.
command! -nargs=0 ToggleGoldenRatio call ToggleGoldenRatio()

" Toggle grammar checking.
command! -nargs=0 ToggleGrammarCheck call ToggleGrammarCheck()


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" Enable ALE Fix on save.
command! ALEEnableFixOnSave let g:ale_fix_on_save = 1

" Disable ALE Fix on save.
command! ALEDisableFixOnSave let g:ale_fix_on_save = 0

" FZF.
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
command! -bang -nargs=* HistoryFiles
  \ call fzf#vim#history(fzf#vim#with_preview('right:50%', '?'))
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--hidden --follow --ignore .git', fzf#vim#with_preview('right:50%', '?'), <bang>0)

" Edit current file with sudo.
command! Esudo e suda://%

" Write current file with sudo.
command! Wsudo w suda://%

" Quick Plug commands.
command! Clean PlugClean
command! Install PlugInstall
command! Update PlugUpdate
