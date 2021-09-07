"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Execute macro over visual range.
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Search on specific engines.
func! Search(engine, query)
  let engineRoots = {
    \ "duckduckgo": "https://duckduckgo.com/?q=",
    \ "devdocs": "https://devdocs.io/#q=",
    \ }
  let query = empty(a:query) ? @o : a:query
  let safe_query = substitute(substitute(query, '\v\s+', ' ', 'g'), '\n', '', 'g')

  silent! exec ":! open-qutebrowser " . shellescape(engineRoots[a:engine] . safe_query, 1) . " &"
endfunc

" Show documentation.
func! ShowDocumentation()
  if (index(['help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    lua vim.lsp.buf.hover()
  endif
endfunc

" Create and print ascii header.
func! PrintAsciiHeader(title)
  execute "read !toilet -f future " . a:title
  norm 0VkkgcwjjI kddjj
endfunc

" Open file or URL under cursor with mimeo. This is a temporary solution until
" `gx` in netrw is repaired.
func! OpenFileOrUrlWithMimeo()
  silent execute "!mimeo '" . expand('<cfile>') . "'"
endfunc


"  ┏━┓╻ ╻┏━┓╺┳╸┏━╸┏┳┓   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┗━┓┗┳┛┗━┓ ┃ ┣╸ ┃┃┃   ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛ ╹ ┗━┛ ╹ ┗━╸╹ ╹   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Goto via zlua.
func! Z(fragment)
  let l:directory = system('~/scripts/zlua/find.zsh ' . shellescape(a:fragment))

  if !empty(l:directory)
    execute 'cd' . ' ' . l:directory
    pwd
  endif
endfunc

" Update zlua with new directory.
func! ZUpdate() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    silent execute "!~/scripts/zlua/add-directory.zsh" . ' ' . expand('%:p:h')
  endif
endfunc


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛
"

" Ripgrep live search.
func! RgLive(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}

  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunc
