-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local autocmd = require('sQVe.utils.autocmd')
local timer = require('sQVe.utils.timer')

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

M.init = function()
  vim.g.linting = true
end

M.config = function()
  local lsp_utils = require('sQVe.plugins.lspconfig.utils')
  local utils = require('sQVe.plugins.nvim-lint.utils')

  autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = 'Lint',
    callback = timer.debounce(200, utils.try_lint),
  })
end

return M
