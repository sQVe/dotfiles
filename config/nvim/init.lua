-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

-- Improve startup time.
require('impatient')

require('sQVe.config.disable-features')
require('sQVe.config.options')

vim.schedule(function()
  require('sQVe.config.autocmds')
  require('sQVe.config.abbreviations')
  require('sQVe.config.commands')
  require('sQVe.config.keymap')
  require('sQVe.plugins')
end)
