local autocmd = require('sQVe.utils.vim').autocmd
local augroup = require('sQVe.utils.vim').augroup

-- Set .mdx filetype.
autocmd({ 'BufNew', 'BufRead' }, {
  group = augroup('SetMdxFiletype'),
  pattern = '*.mdx',
  command = 'set filetype=markdown',
})
