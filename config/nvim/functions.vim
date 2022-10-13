"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Use branch name as commit message.
func! CommitMsgFromBranchName()
  normal gg/On branch2WYggp
  1 substitute /\//: /e
  1 substitute /-/ /e
endfunc

" Open saved previous commit message.
func! CommitMsgPrev()
  silent execute "vsplit /tmp/PREV_COMMIT_EDITMSG"
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
