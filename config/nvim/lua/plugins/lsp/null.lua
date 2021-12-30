-- ┏┓╻╻ ╻╻  ╻     ╻  ┏━┓
-- ┃┗┫┃ ┃┃  ┃     ┃  ┗━┓
-- ╹ ╹┗━┛┗━╸┗━╸   ┗━╸┗━┛

return function()
  local null = require('null-ls')
  local root_dir = require('util').root_dir({ prioritizeManifest = true })

  local code_actions = null.builtins.code_actions
  local formatters = null.builtins.formatting
  local linters = null.builtins.diagnostics

  local eslint_config_cache = {}
  local eslint_runtime_condition = function(params)
    if eslint_config_cache[params.bufnr] ~= nil then
      return eslint_config_cache[params.bufnr]
    end

    local has_config = require('lspconfig').util.root_pattern({
      '.eslintrc.cjs',
      '.eslintrc.js',
      '.eslintrc.json',
      '.eslintrc.yaml',
      '.eslintrc.yml',
    })(params.bufname) ~= nil
    eslint_config_cache[params.bufnr] = has_config

    return has_config
  end

  local stylua_config_cache = {}
  local stylua_runtime_condition = function(params)
    if stylua_config_cache[params.bufnr] ~= nil then
      return stylua_config_cache[params.bufnr]
    end

    local has_config = require('lspconfig').util.root_pattern({
      'stylua.toml',
      '.stylua.toml',
    })(params.bufname) ~= nil
    stylua_config_cache[params.bufnr] = has_config

    return has_config
  end

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
      formatters.stylua.with({ runtime_condition = stylua_runtime_condition }),
      linters.eslint_d.with({
        runtime_condition = eslint_runtime_condition,
        timeout = 20000,
      }),
      linters.shellcheck,
    },
  })
end
