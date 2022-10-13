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

require('disable')
require('autocmds')
require('options')
require('commands')

-- Load async due to packer_compiled.
vim.defer_fn(function()
  require('plugins')
end, 0)
