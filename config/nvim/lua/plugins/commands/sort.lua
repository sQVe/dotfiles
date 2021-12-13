-- ┏━┓┏━┓┏━┓╺┳╸
-- ┗━┓┃ ┃┣┳┛ ┃
-- ┗━┛┗━┛╹┗╸ ╹

return function()
  vim.cmd([[
    nnoremap <silent> go <Cmd>Sort<CR>
    vnoremap <silent> go <Esc><Cmd>Sort<CR>
  ]])
end
