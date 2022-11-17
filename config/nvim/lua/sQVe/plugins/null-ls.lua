-- ┏┓╻╻ ╻╻  ╻     ╻  ┏━┓
-- ┃┗┫┃ ┃┃  ┃  ╺━╸┃  ┗━┓
-- ╹ ╹┗━┛┗━╸┗━╸   ┗━╸┗━┛
-- Code actions, formatting, and linting.

local M = {}

M.init = function(use)
  use({
    'jose-elias-alvarez/null-ls.nvim',
    after = 'nvim-lspconfig',
    config = M.config,
  })
end

M.config = function()
  local null_ls = require('null-ls')
  local lsp_utils = require('sQVe.utils.lsp')

  local format_augroup = vim.api.nvim_create_augroup('Format', {})
  local code_actions = null_ls.builtins.code_actions
  local formatters = null_ls.builtins.formatting
  local linters = null_ls.builtins.diagnostics

  local eslint_runtime_condition = lsp_utils.create_runtime_condition({
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
  })
  local rust_runtime_condition = lsp_utils.create_runtime_condition({
    'rust-project.json',
    'Cargo.toml',
  })
  local stylua_runtime_condition = lsp_utils.create_runtime_condition({
    'stylua.toml',
    '.stylua.toml',
  })
  local vale_runtime_condition = lsp_utils.create_runtime_condition({
    '.vale.ini',
  })

  null_ls.setup({
    cmd = { 'nvim' },
    default_timeout = 5000,
    diagnostics_format = '#{c}: #{m} (#{s})',
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = format_augroup,
          buffer = bufnr,
          callback = function()
            lsp_utils.format(bufnr, false)
          end,
        })
      end
    end,
    root_dir = lsp_utils.create_root_dir_handler({ prioritizeManifest = true }),
    sources = {
      code_actions.eslint_d,
      code_actions.shellcheck,
      require('typescript.extensions.null-ls.code-actions'),

      -- Always run prettierd before eslint_d to prevent occassional race
      -- condition.
      formatters.prettierd,
      formatters.eslint_d.with({
        runtime_condition = eslint_runtime_condition,
        timeout = 20000,
      }),
      formatters.gofmt,
      formatters.rustfmt.with({ runtime_condition = rust_runtime_condition }),
      formatters.shfmt.with({
        extra_args = { '-i', '2', '-bn', '-ci', '-sr' },
      }),
      formatters.stylua.with({ runtime_condition = stylua_runtime_condition }),

      linters.eslint_d.with({
        runtime_condition = eslint_runtime_condition,
        timeout = 20000,
      }),
      linters.shellcheck,
      linters.vale.with({ runtime_condition = vale_runtime_condition }),
    },
  })
end

return M
