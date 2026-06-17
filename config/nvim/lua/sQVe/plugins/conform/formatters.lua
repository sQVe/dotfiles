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
  javascript = { 'oxfmt', 'prettier', stop_after_first = true },
  javascriptreact = { 'oxfmt', 'prettier', stop_after_first = true },
  json = { 'oxfmt', 'prettier', stop_after_first = true },
  jsonc = { 'oxfmt', 'prettier', stop_after_first = true },
  lua = { 'stylua' },
  markdown = { 'prettier', 'injected' },
  sh = { 'shfmt' },
  sql = { 'pg_format' },
  toml = { 'taplo' },
  typescript = { 'oxfmt', 'prettier', stop_after_first = true },
  typescriptreact = { 'oxfmt', 'prettier', stop_after_first = true },
  typst = { 'typstyle' },
  yaml = { 'prettier' },
  ['_'] = { 'trim_newlines', 'trim_whitespace' },
}

M.override_formatting_settings = function()
  local util = require('conform.util')

  local oxfmt = require('conform.formatters.oxfmt')
  local prettier = require('conform.formatters.prettier')
  local shfmt = require('conform.formatters.shfmt')
  local stylua = require('conform.formatters.stylua')

  oxfmt.require_cwd = true
  prettier.require_cwd = true
  stylua.require_cwd = true

  oxfmt.cwd = util.root_file({
    '.oxfmtrc.json',
    '.oxfmtrc.jsonc',
    'oxfmt.config.ts',
  })

  shfmt.args = { '-filename', '$FILENAME', '-i', '2', '-bn', '-ci', '-sr' }
end

return M
