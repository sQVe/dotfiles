-- ╻╻  ╻  ╻ ╻┏┳┓╻┏┓╻┏━┓╺┳╸┏━╸
-- ┃┃  ┃  ┃ ┃┃┃┃┃┃┗┫┣━┫ ┃ ┣╸
-- ╹┗━╸┗━╸┗━┛╹ ╹╹╹ ╹╹ ╹ ╹ ┗━╸
-- Highlight word under cursor.

local M = {}

M.init = function(use)
  use({
    'RRethy/vim-illuminate',
    event = 'CursorMoved',
    config = M.config,
  })
end

M.config = function()
  require('illuminate').configure({
    delay = 250,
    modes_allowlist = { 'n' },
    providers = { 'treesitter' },
  })
end

return M
