local map = require('sQVe.utils.map')

-- Allow buffer to be closed without saving.
vim.opt_local.buftype = 'nofile'

map('n', '<CR>', '<Cmd>Mchat<CR>', { desc = 'Send request to assistant' })
map('n', '<C-c>', '<Cmd>Mcancel<CR>', { desc = 'Abort request to assistant' })
