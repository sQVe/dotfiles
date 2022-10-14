--  ┏┳┓┏━┓╻┏┓╻
--  ┃┃┃┣━┫┃┃┗┫
--  ╹ ╹╹ ╹╹╹ ╹

-- TODO:
-- Convert keymaps into lua.
-- Create init.lua

require('sQVe.options')

vim.schedule(function()
  require('sQVe.disable-features')
  require('sQVe.autocmds')
  require('sQVe.abbreviations')
  require('sQVe.commands')
  require('sQVe.plugins')
end)
