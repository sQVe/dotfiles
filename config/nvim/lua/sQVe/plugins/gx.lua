-- ┏━╸╻ ╻
-- ┃╺┓┏╋┛
-- ┗━┛╹ ╹
-- gx without netrw.

local M = {
  'chrishrb/gx.nvim',
  cmd = { 'Browse' },
  keys = {
    { 'gx', '<Cmd>Browse<CR>', mode = { 'n', 'v' }, desc = 'Open in browser' },
  },
}

M.opts = {
  open_browser_app = 'mimeo',
  open_browser_args = { '--quiet' },
  handlers = { brewfile = false, search = false },
}

return M
