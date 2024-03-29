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
  local conform = require('conform')
  local util = require('conform.util')

  conform.formatters.eslint_d =
    vim.tbl_deep_extend('force', require('conform.formatters.eslint_d'), {
      cwd = util.root_file({
        '.eslintrc.cjs',
        '.eslintrc.js',
        '.eslintrc.json',
        '.eslintrc.yaml',
        '.eslintrc.yml',
      }),
      require_cwd = true,
    })

  conform.formatters.prettierd =
    vim.tbl_deep_extend('force', require('conform.formatters.prettierd'), {
      cwd = util.root_file({
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.yml',
        '.prettierrc.yaml',
        '.prettierrc.js',
        '.prettierrc.cjs',
        '.prettierrc.toml',
        'prettier.config.js',
        'prettier.config.cjs',
      }),
      require_cwd = true,
    })

  conform.formatters.shfmt =
    vim.tbl_deep_extend('force', require('conform.formatters.shfmt'), {
      args = { '-filename', '$FILENAME', '-i', '2', '-bn', '-ci', '-sr' },
    })

  conform.formatters.stylua =
    vim.tbl_deep_extend('force', require('conform.formatters.stylua'), {
      require_cwd = true,
    })
end

return M
