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

" Toggle spelling.
function! SpellToggle()
  if(&spell == 1)
    set nospell
  else
    set spell
  endif
endfunc

" Merge filename and modified flag for vim-lightline.
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" Disable deoplete when entering multiple cursor mode.
function! Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction

" Enable deoplete when leaving multiple cursor mode.
function! Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction

" --------------------------------------------------
" FUNCTION CONFIG
" --------------------------------------------------

" Toggle relative numbering.
nnoremap <Leader>r :call NumberToggle()<CR>

" Toggle spelling.
nnoremap <C-s> :call SpellToggle()<CR>
