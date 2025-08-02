-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local autocmd = require('sQVe.utils.autocmd')
local timer = require('sQVe.utils.timer')

local M = {
  'mfussenegger/nvim-lint',
  ft = {
    -- eslint.
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',

    -- gdlint.
    'gdscript',

    -- golangci-lint.
    'go',

    -- selene,
    'lua',

    -- shellcheck.
    'sh',
  },
}

M.init = function()
  vim.g.linting = true
end

M.config = function()
  local lint = require('lint')

  lint.linters_by_ft = {
    gdscript = { 'gdlint' },
    go = { 'golangcilint' },
    javascript = { 'eslint' },
    javascriptreact = { 'eslint' },
    lua = { 'selene' },
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
