-- ┏━┓┏━┓┏━┓╺┳╸
-- ┗━┓┃ ┃┣┳┛ ┃
-- ┗━┛┗━┛╹┗╸ ╹
-- Sort by line and delimiter.

local M = {}

M.init = function(use)
  use{
    'sQVe/sort.nvim',
    cmd = { 'Sort' },
    config = M.config,
    keys = {
      { 'n', 'go' }, { 'v', 'go' } },
  }
end

M.config = function()
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

return M
