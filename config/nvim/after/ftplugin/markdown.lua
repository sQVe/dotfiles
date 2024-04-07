-- Markdown specific settings.

local NOTEBOX_PATH = vim.fn.expand('$NOTEBOX')

local autocmd = require('sQVe.utils.autocmd')

-- Enable conceal.
vim.opt_local.conceallevel = 2

-- Indent with two spaces.
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

-- Enable spellchecking for notes.
autocmd({ 'BufEnter' }, {
  group = 'EnableSpellCheckingForNotes',
  pattern = NOTEBOX_PATH .. '**/*.md',
  command = 'setlocal spell',
})
