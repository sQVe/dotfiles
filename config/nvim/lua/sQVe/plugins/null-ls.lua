-- ┏┓╻╻ ╻╻  ╻     ╻  ┏━┓
-- ┃┗┫┃ ┃┃  ┃  ╺━╸┃  ┗━┓
-- ╹ ╹┗━┛┗━╸┗━╸   ┗━╸┗━┛
-- Code actions, formatting, and linting.

local M = {
  'jose-elias-alvarez/null-ls.nvim',
  ft = {
    -- shellcheck and shfmt
    'sh',

    -- stylua
    'lua',

    -- eslintd and prettierd
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',

    -- terraform_fmt
    'terraform',
    'terraform-vars',
  },
}

M.opts = function()
  local null_ls = require('null-ls')
  local lsp_utils = require('sQVe.utils.lsp')

  local format_augroup = vim.api.nvim_create_augroup('Format', {})
  local code_actions = null_ls.builtins.code_actions
  local formatters = null_ls.builtins.formatting
  local linters = null_ls.builtins.diagnostics

  local eslint_extra_args = {
    '--rule',
    '@typescript-eslint/no-confusing-void-expression: off',
  }
  local eslint_runtime_condition = lsp_utils.create_runtime_condition({
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
  })
  local stylua_runtime_condition = lsp_utils.create_runtime_condition({
    'stylua.toml',
    '.stylua.toml',
  })

  return {
    default_timeout = 5000,
    diagnostics_format = '#{c}: #{m} (#{s})',
    on_attach = function(client, bufnr)
      lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics' })
    end,
    root_dir = lsp_utils.create_root_dir_handler({ prioritizeManifest = true }),
    sources = {
      code_actions.eslint_d,
      code_actions.shellcheck,

      linters.eslint_d.with({
        extra_args = eslint_extra_args,
        filter = function(diagnostic)
          return not diagnostic.user_data.fixable
        end,
        runtime_condition = eslint_runtime_condition,
        timeout = 20000,
      }),
      linters.shellcheck,
    },
  }
end

return M
