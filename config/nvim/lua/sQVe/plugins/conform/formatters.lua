-- ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏━┓
-- ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃  ┃ ┣╸ ┣┳┛┗━┓
-- ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹  ╹ ┗━╸╹┗╸┗━┛

local M = {}

M.by_ft = {
  css = { 'prettierd' },
  graphql = { 'prettierd' },
  html = { 'prettierd' },
  javascript = { 'prettierd', 'eslint_d' },
  javascriptreact = { 'prettierd', 'eslint_d' },
  json = { 'prettierd' },
  json5 = { 'prettierd' },
  jsonc = { 'prettierd' },
  lua = { 'stylua' },
  markdown = { 'prettierd', 'injected' },
  sh = { 'shfmt' },
  typescript = { 'prettierd', 'eslint_d' },
  typescriptreact = { 'prettierd', 'eslint_d' },
  yaml = { 'prettierd' },
  ['_'] = { 'trim_newlines', 'trim_whitespace' },
}

M.override_formatting_settings = function()
  local util = require('conform.util')

  local eslint_d_formatter = require('conform.formatters.eslint_d')
  local prettierd_formatter = require('conform.formatters.prettierd')
  local shfmt_formatter = require('conform.formatters.shfmt')
  local stylua_formatter = require('conform.formatters.stylua')

  stylua_formatter.require_cwd = true
  prettierd_formatter.require_cwd = true
  eslint_d_formatter.require_cwd = true

  eslint_d_formatter.cwd = util.root_file({
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
  })

  prettierd_formatter.cwd = util.root_file({
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettierrc.toml',
    'prettier.config.js',
    'prettier.config.cjs',
  })

  shfmt_formatter.args =
    { '-filename', '$FILENAME', '-i', '2', '-bn', '-ci', '-sr' }
end

return M
