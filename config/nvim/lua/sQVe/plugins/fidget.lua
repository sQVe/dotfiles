-- ┏━╸╻╺┳┓┏━╸┏━╸╺┳╸
-- ┣╸ ┃ ┃┃┃╺┓┣╸  ┃
-- ╹  ╹╺┻┛┗━┛┗━╸ ╹
-- LSP progress.

local M = {}

M.init = function(use)
  use({
    'j-hui/fidget.nvim',
    after = 'nvim-lspconfig',
    config = M.config,
  })
end

M.config = function()
  require('fidget').setup({
    text = { spinner = 'dots' },
    timer = { fidget_decay = 1000, task_decay = 500 },
    window = { blend = 50 },
  })

  -- Prevent error when exiting.
  vim.api.nvim_create_autocmd(
    'VimLeavePre',
    { command = [[silent! FidgetClose]] }
  )
end

return M
