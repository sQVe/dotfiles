" --------------------------------------------------
" COMMANDS
" --------------------------------------------------

" Copy
command Copy !xsel -b < %

" :Wsudo sudo save.
command Wsudo w !sudo tee % > /dev/null

" Delete all buffers but the open one.
command Bdo %bd|e#|bd#

" :Write and quit typos.
command W write
command Q quit
command Wq wq
command WQ wq
command Qa qa
command QA qa
command Wa wa
command WA wa
