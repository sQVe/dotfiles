-- ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏━┓
-- ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃  ┃ ┣╸ ┣┳┛┗━┓
-- ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹  ╹ ┗━╸╹┗╸┗━┛

local M = {}

M.by_ft = {
  css = { 'prettierd' },
  graphql = { 'prettierd' },
  html = { 'prettierd' },
  javascript = { 'biome-check', 'prettierd', stop_after_first = true },
  javascriptreact = { 'biome-check', 'prettierd', stop_after_first = true },
  json = { 'biome', 'prettierd' },
  jsonc = { 'biome', 'prettierd' },
  lua = { 'stylua' },
  markdown = { 'prettierd', 'injected' },
  sh = { 'shfmt' },
  sql = { 'pg_format' },
  typescript = { 'biome-check', 'prettierd', stop_after_first = true },
  typescriptreact = { 'biome-check', 'prettierd', stop_after_first = true },
  yaml = { 'prettierd' },
  ['_'] = { 'trim_newlines', 'trim_whitespace' },
}

M.override_formatting_settings = function()
  local util = require('conform.util')

  local biome = require('conform.formatters.biome')
  local biome_check = require('conform.formatters.biome-check')
  local prettierd = require('conform.formatters.prettierd')
  local shfmt = require('conform.formatters.shfmt')
  local stylua = require('conform.formatters.stylua')

  biome.require_cwd = true
  biome_check.require_cwd = true
  prettierd.require_cwd = true
  stylua.require_cwd = true

  prettierd.cwd = util.root_file({
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

  shfmt.args = { '-filename', '$FILENAME', '-i', '2', '-bn', '-ci', '-sr' }
end

return M
