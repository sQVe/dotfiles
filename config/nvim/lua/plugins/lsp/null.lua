-- ┏┓╻╻ ╻╻  ╻     ╻  ┏━┓
-- ┃┗┫┃ ┃┃  ┃     ┃  ┗━┓
-- ╹ ╹┗━┛┗━╸┗━╸   ┗━╸┗━┛

return function()
  local null = require('null-ls')
  local root_dir = require('util').root_dir({ prioritizeManifest = true })

  local code_actions = null.builtins.code_actions
  local formatters = null.builtins.formatting
  local linters = null.builtins.diagnostics

  null.setup({
    cmd = { 'nvim' },
    diagnostics_format = '#{c}: #{m} (#{s})',
    on_attach = function()
      vim.cmd([[
        augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end,
    root_dir = root_dir,
    sources = {
      code_actions.eslint_d,
      code_actions.shellcheck,
      formatters.eslint_d,
      formatters.gofmt,
      formatters.prettierd,
      formatters.shfmt.with({
        extra_args = { '-i', '2', '-bn', '-ci', '-sr' },
      }),
      formatters.stylua,
      linters.eslint_d.with({ timeout = 20000 }),
      linters.shellcheck,
    },
  })
end
