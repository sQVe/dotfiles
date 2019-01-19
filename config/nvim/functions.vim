
"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
" ¤¤¤¤  Functions  ¤¤¤¤
" ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

" GetBuffersCount
function! GetBuffersCount()
  return len(getbufinfo({'buflisted':1}))
endfunc

" Toggle concealing.
command -nargs=0 ToggleConceal call ToggleConceal()

function! ToggleConceal()
  if(&conceallevel == 2)
    set conceallevel=0
  else
    set conceallevel=2
  endif
endfunc

" Toggle relative numbering.
command -nargs=0 ToggleRelativeNumber call ToggleRelativeNumber()

function! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Toggle spell checking.
command -nargs=0 ToggleSpellCheck call ToggleSpellCheck()

function! ToggleSpellCheck()
  if(&spell == 1)
    set nospell
  else
    set spell
  endif
endfunc

" Toggle grammar checking.
command -nargs=0 ToggleGrammarCheck call ToggleGrammarCheck()

let grammarcheck = 0
function! ToggleGrammarCheck()
  if(g:grammarcheck == 1)
    let g:grammarcheck = 0
    :GrammarousReset
  else
    let g:grammarcheck = 1
    :GrammarousCheck
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

nnoremap <C-s> :ToggleSpellCheck<CR>
nnoremap <C-s>s :ToggleSpellCheck<CR>
nnoremap <C-s><C-s> :ToggleSpellCheck<CR>
nnoremap <C-s>g :ToggleGrammarCheck<CR>
nnoremap <C-s><C-g> :ToggleGrammarCheck<CR>
nnoremap <Leader>c :ToggleConceal<CR>
nnoremap <Leader>r :ToggleRelativeNumber<CR>
nnoremap <Leader>z :Fasd<Space>
nnoremap <Leader>zo :Fasd<Space>
nnoremap <Leader>zz :FasdCd<Space>
