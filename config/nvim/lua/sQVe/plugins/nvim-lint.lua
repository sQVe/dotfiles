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

local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.json',
  '.eslintrc.yml',
  '.eslintrc.yaml',
  '.eslintrc.cjs',
  '.eslintrc.mjs',
}

local oxlint_config_files = {
  '.oxlintrc.json',
  'oxlint.config.ts',
}

local function get_js_linters()
  local linters = {}

  if has_config_files(oxlint_config_files) then
    table.insert(linters, 'oxlint')
  end

  if has_config_files(eslint_config_files) then
    table.insert(linters, 'eslint')
  end

  return linters
end

local function get_linters(filetype)
  if vim.tbl_contains({ 'gdscript', 'go', 'sh', 'yaml.github' }, filetype) then
    return nil
  end

  if
    vim.tbl_contains(
      { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      filetype
    )
  then
    return get_js_linters()
  end

  if filetype == 'lua' then
    if has_config_files({ 'selene.toml' }) then
      return nil
    end
    return {}
  end

  return {}
end

local M = {
  'mfussenegger/nvim-lint',
  ft = {
    -- oxlint and eslint.
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

    -- actionlint.
    'yaml.github',
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
    javascript = { 'oxlint', 'eslint' },
    javascriptreact = { 'oxlint', 'eslint' },
    lua = { 'selene' },
    sh = { 'shellcheck' },
    ['yaml.github'] = { 'actionlint' },
    typescript = { 'oxlint', 'eslint' },
    typescriptreact = { 'oxlint', 'eslint' },
  }

  autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = 'Lint',
    callback = timer.debounce(200, function()
      local linters = get_linters(vim.bo.filetype)

      if linters == nil then
        require('lint').try_lint()
      elseif #linters > 0 then
        require('lint').try_lint(linters)
      end
    end),
  })
end

return M
