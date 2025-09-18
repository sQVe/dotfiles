-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local autocmd = require('sQVe.utils.autocmd')
local timer = require('sQVe.utils.timer')

local function has_config_files(config_files)
  local filename = vim.api.nvim_buf_get_name(0)

  return vim.fs.dirname(
    vim.fs.find(config_files, { path = filename, upward = true })[1]
  ) ~= nil
end

local function should_lint_filetype(filetype)
  if vim.tbl_contains({ 'gdscript', 'go', 'sh' }, filetype) then
    return true
  end

  if
    vim.tbl_contains(
      { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      filetype
    )
  then
    return has_config_files({
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.json',
      '.eslintrc.yml',
      '.eslintrc.yaml',
      '.eslintrc.cjs',
      '.eslintrc.mjs',
    })
  end

  if filetype == 'lua' then
    return has_config_files({ 'selene.toml' })
  end

  return false
end

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

  -- Set up all linters (they will be conditionally used)
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
      local filetype = vim.bo.filetype

      if should_lint_filetype(filetype) then
        require('lint').try_lint()
      end
    end),
  })
end

return M
