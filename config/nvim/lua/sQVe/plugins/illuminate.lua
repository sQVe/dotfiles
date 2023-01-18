-- ╻╻  ╻  ╻ ╻┏┳┓╻┏┓╻┏━┓╺┳╸┏━╸
-- ┃┃  ┃  ┃ ┃┃┃┃┃┃┗┫┣━┫ ┃ ┣╸
-- ╹┗━╸┗━╸┗━┛╹ ╹╹╹ ╹╹ ╹ ╹ ┗━╸
-- Highlight word under cursor.

local M = {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
}

M.opts = {
  delay = 250,
  modes_allowlist = { 'n' },
  providers = { 'treesitter' },
}

M.config = function(_, opts)
  require('illuminate').configure(opts)
end

return M
