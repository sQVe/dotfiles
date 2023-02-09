-- Set .mdx filetype.
vim.api.nvim_create_autocmd({ 'BufNew', 'BufRead' }, {
  group = vim.api.nvim_create_augroup('SetMdxFiletype', {}),
  pattern = '*.mdx',
  command = 'set filetype=markdown',
})
