-- ┏┓╻┏━┓╺┳╸┏━╸┏┓ ┏━┓╻ ╻
-- ┃┗┫┃ ┃ ┃ ┣╸ ┣┻┓┃ ┃┏╋┛
-- ╹ ╹┗━┛ ╹ ┗━╸┗━┛┗━┛╹ ╹
-- Manage Markdown-based notes.

local M = {
  'sQVe/notebox.nvim',
  lazy = true,
}

M.opts = {
  subdirectories = {
    dailies = '5-dailies',
    new_notes = '0-inbox',
    templates = 'templates',
  },
}

return M
