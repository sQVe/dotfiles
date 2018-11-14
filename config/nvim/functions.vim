
"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Functions  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

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

" Fasd.
command -nargs=1 Fasd call Fasd('-a', 'e', <q-args>)
command -nargs=1 FasdCd call Fasd('-d', 'cd', <q-args>)

function Fasd(type, executeWith, fragment)
  let l:fragment = system('fasd -1 ' . a:type . ' ' . shellescape(a:fragment))

  if !empty(l:fragment)
    execute a:executeWith . ' ' . l:fragment
    redraw
    echo split(l:fragment, '\n')[0]
  endif
endfunction


" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Function bindings  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

nnoremap <C-s> :call SpellToggle()<CR>
nnoremap <Leader>r :call NumberToggle()<CR>
nnoremap <Leader>z :Fasd<Space>
nnoremap <Leader>zo :Fasd<Space>
nnoremap <Leader>zz :FasdCd<Space>
