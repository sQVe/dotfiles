-- ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
-- ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
-- ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸
-- Indention guides.

local M = {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufNew', 'BufRead' },
}

M.opts = {
  buftype_exclude = { 'nofile', 'terminal' },
  filetype_exclude = { 'alpha', 'help', 'neo-tree', 'lazy' },
  show_current_context = true,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
}

return M
