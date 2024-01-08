-- Markdown specific settings.

local NOTES_PATH = vim.fn.expand('$NOTES')

local autocmd = require('sQVe.utils.vim').autocmd
local augroup = require('sQVe.utils.vim').augroup

-- Enable conceal.
vim.opt_local.conceallevel = 2

-- Enable spellchecking for notes.
autocmd({ 'BufEnter' }, {
  group = augroup('SetNoteSpellcheck'),
  pattern = NOTES_PATH .. '**/*.md',
  command = 'setlocal spell',
})
