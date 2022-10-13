-- Set .mdx filetype.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('SetMdxFiletype', {}),
  pattern = '*.mdx',
  command = 'set filetype=markdown',
})
