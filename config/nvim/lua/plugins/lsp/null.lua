-- ┏┓╻╻ ╻╻  ╻     ╻  ┏━┓
-- ┃┗┫┃ ┃┃  ┃     ┃  ┗━┓
-- ╹ ╹┗━┛┗━╸┗━╸   ┗━╸┗━┛

return function()
  local null = require('null-ls')

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
    sources = {
      formatters.eslint_d,
      formatters.gofmt,
      formatters.prettierd,
      formatters.shfmt.with({
        extra_args = { '-i', '2', '-bn', '-ci', '-sr' },
      }),
      formatters.stylua.with({
        extra_args = {
          '--config-path',
          vim.fn.expand('$XDG_CONFIG_HOME/stylua/stylua.toml'),
        },
      }),
      linters.eslint_d.with({ timeout = 20000 }),
      linters.shellcheck,
    },
  })
end
