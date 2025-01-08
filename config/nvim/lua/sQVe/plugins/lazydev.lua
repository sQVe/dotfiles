-- ╻  ┏━┓╺━┓╻ ╻╺┳┓┏━╸╻ ╻
-- ┃  ┣━┫┏━┛┗┳┛ ┃┃┣╸ ┃┏┛
-- ┗━╸╹ ╹┗━╸ ╹ ╺┻┛┗━╸┗┛
-- Fast LuaLS setup.

local M = {
  'folke/lazydev.nvim',
  ft = 'lua',
}

M.opts = {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

return M
