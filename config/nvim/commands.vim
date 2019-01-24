
"  ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" Enable ALE Fix on save.
command ALEEnableFixOnSave let g:ale_fix_on_save = 1

" Disable ALE Fix on save.
command ALEDisableFixOnSave let g:ale_fix_on_save = 0

" Add explanatory command name for Bdelete (vim-bbye)
command -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

" Delete all open buffers.
command Bda bufdo bd

" Delete all buffers but the open one.
command Bdo %bd|e#|bd#

" Show full path to open buffer.
command Bpwd echo expand('%:p')

" Delete marks.
command DeleteMarks :delm! | delm A-Z0-9

" Set pwd to path of open buffer.
command Cdb cd %:p:h

" Copy.
command Copy norm ggyG

" Shortened plug commands.
command Clean PlugClean
command Install PlugInstall
command Update PlugUpdate

" Edit current file with sudo.
command Esudo e suda://%

" Write current file with sudo.
command Wsudo w suda://%

" Write and close helpers.
command Bc Bclose
command WBc w | Bclose

" Write, close and quit typos.
command W write
command Q quit
command Wq wq
command WQ wq
command Qa qa
command QA qa
command Wa wa
command WA wa
command Wbc Wbc
