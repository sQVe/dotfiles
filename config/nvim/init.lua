-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

require('sQVe.config.options')
require('sQVe.config.lazy')

vim.schedule(function()
  require('sQVe.config.abbreviations')
  require('sQVe.config.autocmds')
  require('sQVe.config.commands')
  require('sQVe.config.keymap')
end)
