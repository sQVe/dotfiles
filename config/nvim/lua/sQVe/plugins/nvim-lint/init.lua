-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local M = {
  'mfussenegger/nvim-lint',
  ft = {
    -- eslint_d.
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',

    -- shellcheck.
    'sh',
  },
}

M.config = function(_, opts)
  local autocmd = require('sQVe.utils.vim').autocmd
  local augroup = require('sQVe.utils.vim').augroup
  local debounce = require('sQVe.utils.vim').debounce
  local lsp_utils = require('sQVe.plugins.lspconfig.utils')
  local utils = require('sQVe.plugins.nvim-lint.utils')

  lsp_utils.map_lsp_buffer_keys(0, { 'diagnostics' })
  autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = augroup('Lint'),
    callback = debounce(200, utils.try_lint),
  })
end

return M
