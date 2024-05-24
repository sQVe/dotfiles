-- ╺┳┓╻┏━╸┏━╸╻ ╻╻┏━╸╻ ╻
--  ┃┃┃┣╸ ┣╸ ┃┏┛┃┣╸ ┃╻┃
-- ╺┻┛╹╹  ╹  ┗┛ ╹┗━╸┗┻┛
-- Unified diff and merge view.

local M = {
  'sindrets/diffview.nvim',
  cmd = {
    'DiffviewFileHistory',
    'DiffviewOpen',
  },
}

M.opts = {
  default_args = {
    DiffviewOpen = { '--imply-local' },
  },
  show_help_hints = false,
}

return M
