"  ╻ ╻╻┏━╸╻ ╻╻  ╻┏━╸╻ ╻╺┳╸
"  ┣━┫┃┃╺┓┣━┫┃  ┃┃╺┓┣━┫ ┃
"  ╹ ╹╹┗━┛╹ ╹┗━╸╹┗━┛╹ ╹ ╹

" Better Whitespace.
hi! ExtraWhitespace ctermfg=255 ctermbg=203 guifg=#282828 guibg=#cc241d

" Buffet.
function! g:BuffetSetCustomColors()
  hi! link BuffetBuffer GruvboxGray
  hi! link BuffetActiveBuffer BuffetBuffer
  hi! link BuffetModActiveBuffer BuffetActiveBuffer
  hi! link BuffetModBuffer GruvboxFg2
  hi! link BuffetTrunc BuffetBuffer
  hi! link BuffetTab GruvboxPurple
  hi! BuffetCurrentBuffer ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=#3c3836
  hi! BuffetModCurrentBuffer ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=#3c3836
endfunction
