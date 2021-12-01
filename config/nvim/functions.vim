"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Execute macro over visual range.
func! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunc

" Use branch name as commit message.
func! CommitMsgFromBranchName()
  normal gg/On branch2WYggp
  1 substitute /\//: /e
  1 substitute /-/ /e
endfunc

" Open saved previous commit message.
func! CommitMsgPrev()
  let root_path = system("git rev-parse --show-toplevel")
  let newline_safe_root_path = substitute(root_path, '\n', '', 'g')

  silent execute "vsplit " . newline_safe_root_path . "/.git/PREV_COMMIT_EDITMSG"
endfunc

" Search on DuckDuckGo.
func! Ddg(query)
  let ddg_root = 'https://duckduckgo.com/?q='
  let query = empty(a:query) ? @o : a:query
  let safe_query = substitute(substitute(query, '\v\s+', ' ', 'g'), '\n', '', 'g')

  silent execute "! open-qutebrowser " . shellescape(ddg_root . safe_query, 1) . " &"
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
func! AsciiHeader(title)
  PackerLoad Comment.nvim
  execute "read !toilet -f future " . a:title
  norm 0Vkkgc
endfunc

func! OpenFileOrUrlWithMimeo()
  silent execute "!mimeo " . shellescape(expand('<cfile>'))
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
