-- ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏━┓
-- ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃  ┃ ┣╸ ┣┳┛┗━┓
-- ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹  ╹ ┗━╸╹┗╸┗━┛

local M = {}

M.by_ft = {
  css = { 'prettier' },
  gdscript = { 'gdformat' },
  go = { 'goimports', 'gofumpt' },
  graphql = { 'prettier' },
  html = { 'prettier' },
  javascript = { 'biome-check', 'prettier', stop_after_first = true },
  javascriptreact = { 'biome-check', 'prettier', stop_after_first = true },
  json = { 'biome', 'prettier' },
  jsonc = { 'biome', 'prettier' },
  lua = { 'stylua' },
  markdown = { 'prettier', 'injected' },
  sh = { 'shfmt' },
  sql = { 'pg_format' },
  typescript = { 'biome-check', 'prettier', stop_after_first = true },
  typescriptreact = { 'biome-check', 'prettier', stop_after_first = true },
  yaml = { 'prettier' },
  ['_'] = { 'trim_newlines', 'trim_whitespace' },
}

M.override_formatting_settings = function()
  local util = require('conform.util')

  local biome = require('conform.formatters.biome')
  local biome_check = require('conform.formatters.biome-check')
  local prettier = require('conform.formatters.prettier')
  local shfmt = require('conform.formatters.shfmt')
  local stylua = require('conform.formatters.stylua')

  biome.require_cwd = true
  biome_check.require_cwd = true
  prettier.require_cwd = true
  stylua.require_cwd = true

  prettier.cwd = util.root_file({
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
