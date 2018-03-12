" --------------------------------------------------
" COMMANDS
" --------------------------------------------------

" Copy
command Copy !cat % | xsel -ib

" :Wsudo sudo save.
command Wsudo w !sudo tee % > /dev/null

" :Write and quit typos.
command W w
command Q q
command Wq wq
command WQ wq
command Qa qa
command QA qa
command Wa wa
command WA wa
