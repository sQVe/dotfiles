--  ┏┳┓┏━┓╻┏┓╻
--  ┃┃┃┣━┫┃┃┗┫
--  ╹ ╹╹ ╹╹╹ ╹

-- TODO:
-- Move abbrevations into lua module.
-- Convert functions into lua.
--   Where should these be housed? functions.lua, a util or what?
-- Convert keymaps into lua.
-- Move everything under `lua/sQVe` scope.
-- Create init.lua

require('sQVe.options')

vim.schedule(function()
  require('sQVe.disable-features')
  require('sQVe.autocmds')
  require('sQVe.commands')
  require('sQVe.plugins')
end)
