-- ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
-- ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
-- ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸
-- Indention guides.

local M = {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufNew', 'BufRead' },
  main = 'ibl',
}

M.opts = {
  exclude = {
    filetypes = { 'alpha', 'help', 'neo-tree', 'lazy' },
    buftypes = { 'nofile', 'terminal' },
  },
  scope = { enabled = false },
}

M.config = function(_, opts)
  local ibl = require('ibl')
  local hooks = require('ibl.hooks')

  ibl.setup(opts)

  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )
  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_tab_indent_level
  )
end

return M
