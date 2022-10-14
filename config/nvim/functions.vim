"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

" Search on DuckDuckGo.
func! Ddg(query)
  let ddg_root = 'https://duckduckgo.com/?q='
  let query = empty(a:query) ? @o : a:query
  let safe_query = substitute(substitute(query, '\v\s+', ' ', 'g'), '\n', '', 'g')

  silent execute "! open-qutebrowser " . shellescape(ddg_root . safe_query, 1) . " &"
endfunc

func! OpenFileOrUrlWithMimeo()
  silent execute "!mimeo " . shellescape(expand('<cfile>'))
endfunc
