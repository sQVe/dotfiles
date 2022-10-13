--  ┏┳┓┏━┓╻┏┓╻
--  ┃┃┃┣━┫┃┃┗┫
--  ╹ ╹╹ ╹╹╹ ╹

require('disable')
require('autocmds')
require('options')
require('commands')

-- Load async due to packer_compiled.
vim.defer_fn(function()
  require('plugins')
end, 0)
