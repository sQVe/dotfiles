-- ┏┳┓┏━┓┏━┓╻┏ ╺┳┓┏━┓╻ ╻┏┓╻
-- ┃┃┃┣━┫┣┳┛┣┻┓ ┃┃┃ ┃┃╻┃┃┗┫
-- ╹ ╹╹ ╹╹┗╸╹ ╹╺┻┛┗━┛┗┻┛╹ ╹
-- Markdown specific settings.

local autocmd = require('sQVe.utils.autocmd')

local NOTEBOX_PATH = vim.fn.expand('$NOTEBOX')

-- Enable conceal.
vim.opt_local.conceallevel = 2

-- Enable line wrapping.
vim.opt_local.wrap = true

-- Indent with two spaces.
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

-- Enable spellchecking for notes.
autocmd({ 'BufEnter' }, {
  group = 'EnableSpellCheckingForNotes',
  pattern = NOTEBOX_PATH .. '**/*.md',
  command = 'setlocal spell',
})
