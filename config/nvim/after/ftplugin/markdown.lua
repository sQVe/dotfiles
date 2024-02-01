-- Markdown specific settings.

local NOTEBOX_PATH = vim.fn.expand('$NOTEBOX')

local autocmd = require('sQVe.utils.vim').autocmd
local augroup = require('sQVe.utils.vim').augroup

-- Enable conceal.
vim.opt_local.conceallevel = 2

-- Indent with two spaces.
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

-- Enable spellchecking for notes.
autocmd({ 'BufEnter' }, {
  group = augroup('SetNoteSpellcheck'),
  pattern = NOTEBOX_PATH .. '**/*.md',
  command = 'setlocal spell',
})
