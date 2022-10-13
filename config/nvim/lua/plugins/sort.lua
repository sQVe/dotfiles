-- ┏━┓┏━┓┏━┓╺┳╸
-- ┗━┓┃ ┃┣┳┛ ┃
-- ┗━┛┗━┛╹┗╸ ╹

return function()
  -- TODO: Make this lua.
  vim.cmd([[
    nnoremap <silent> go <Cmd>Sort<CR>
    nnoremap <silent> go" vi"<Esc><Cmd>Sort<CR>
    nnoremap <silent> go' vi'<Esc><Cmd>Sort<CR>
    nnoremap <silent> go( vi(<Esc><Cmd>Sort<CR>
    nnoremap <silent> go[ vi[<Esc><Cmd>Sort<CR>
    nnoremap <silent> gop vip<Esc><Cmd>Sort<CR>
    nnoremap <silent> go{ vi{<Esc><Cmd>Sort<CR>
    vnoremap <silent> go <Esc><Cmd>Sort<CR>
  ]])
end
