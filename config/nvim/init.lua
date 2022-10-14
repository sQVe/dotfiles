-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

-- Improve startup time.
require('impatient')

require('sQVe.disable-features')
require('sQVe.options')

vim.schedule(function()
  require('sQVe.autocmds')
  require('sQVe.abbreviations')
  require('sQVe.commands')
  require('sQVe.keymap')
  require('sQVe.plugins')
end)
