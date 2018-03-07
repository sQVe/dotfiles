" --------------------------------------------------
" FUNCTIONS
" --------------------------------------------------

" Toggle relative numbering.
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" --------------------------------------------------
" FUNCTION CONFIG
" --------------------------------------------------

" Toggle relative numbering.
nnoremap <Leader>r :call NumberToggle()<CR>
