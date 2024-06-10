-- ╻  ┏━┓╺━┓╻ ╻╺┳┓┏━╸╻ ╻
-- ┃  ┣━┫┏━┛┗┳┛ ┃┃┣╸ ┃┏┛
-- ┗━╸╹ ╹┗━╸ ╹ ╺┻┛┗━╸┗┛
-- Fast LuaLS setup.

local M = {
  'folke/lazydev.nvim',
  ft = 'lua',
  dependencies = {
    { 'Bilal2453/luvit-meta', lazy = true },
  },
}

M.opts = {
  library = {
    { path = 'LazyVim', words = { 'LazyVim' } },
    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
  },
}

return M
