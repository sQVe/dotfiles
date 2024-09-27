-- ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏━┓
-- ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃  ┃ ┣╸ ┣┳┛┗━┓
-- ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹  ╹ ┗━╸╹┗╸┗━┛

local M = {}

M.by_ft = {
  css = { 'biome', 'prettierd' },
  graphql = { 'biome', 'prettierd' },
  html = { 'prettierd' },
  javascript = { 'biome-check', 'prettierd' },
  javascriptreact = { 'biome-check', 'prettierd' },
  json = { 'biome', 'prettierd' },
  jsonc = { 'biome', 'prettierd' },
  lua = { 'stylua' },
  markdown = { 'prettierd', 'injected' },
  sh = { 'shfmt' },
  typescript = { 'biome-check', 'prettierd' },
  typescriptreact = { 'biome-check', 'prettierd' },
  yaml = { 'prettierd' },
  ['_'] = { 'trim_newlines', 'trim_whitespace' },
}

M.override_formatting_settings = function()
  local util = require('conform.util')

  local prettierd_formatter = require('conform.formatters.prettierd')
  local shfmt_formatter = require('conform.formatters.shfmt')
  local stylua_formatter = require('conform.formatters.stylua')

  prettierd_formatter.require_cwd = true
  stylua_formatter.require_cwd = true

  prettierd_formatter.cwd = util.root_file({
    '.prettierrc',
    '.prettierrc.cjs',
    '.prettierrc.js',
    '.prettierrc.json',
    '.prettierrc.toml',
    '.prettierrc.yaml',
    '.prettierrc.yml',
    'prettier.config.cjs',
    'prettier.config.js',
  })

  shfmt_formatter.args =
    { '-filename', '$FILENAME', '-i', '2', '-bn', '-ci', '-sr' }
end

return M
