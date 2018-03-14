" --------------------------------------------------
" COMMANDS
" --------------------------------------------------

" Open cheat sheet
command Cheat view $HOME/docs/vim-cheat

" Copy
command Copy !cat % | xsel -ib

" :Wsudo sudo save.
command Wsudo w !sudo tee % > /dev/null

" :Write and quit typos.
command W write
command Q quit
command Wq wq
command WQ wq
command Qa qa
command QA qa
command Wa wa
command WA wa
