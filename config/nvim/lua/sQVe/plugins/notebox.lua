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
    dailies = 'daily',
    new_notes = 'active',
    templates = 'templates',
  },
}

return M
