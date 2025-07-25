-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local autocmd = require('sQVe.utils.autocmd')
local timer = require('sQVe.utils.timer')

local M = {
  'mfussenegger/nvim-lint',
  ft = {
    -- golangci-lint.
    'go',

    -- shellcheck.
    'sh',

    -- eslint.
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
}

M.init = function()
  vim.g.linting = true
end

M.config = function()
  local lint = require('lint')

  lint.linters_by_ft = {
    go = { 'golangcilint' },
    javascript = { 'eslint' },
    javascriptreact = { 'eslint' },
    sh = { 'shellcheck' },
    typescript = { 'eslint' },
    typescriptreact = { 'eslint' },
  }

  autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = 'Lint',
    callback = timer.debounce(200, function()
      require('lint').try_lint()
    end),
  })
end

return M
