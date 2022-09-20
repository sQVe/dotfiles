-- ┏┓╻╻ ╻╻  ╻     ╻  ┏━┓
-- ┃┗┫┃ ┃┃  ┃     ┃  ┗━┓
-- ╹ ╹┗━┛┗━╸┗━╸   ┗━╸┗━┛

return function()
  local null = require('null-ls')
  local root_dir = require('utils.lsp').root_dir({ prioritizeManifest = true })

  local format_augroup = vim.api.nvim_create_augroup('Format', {})
  local code_actions = null.builtins.code_actions
  local formatters = null.builtins.formatting
  local linters = null.builtins.diagnostics

  local format = function(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == 'null-ls'
      end,
      bufnr = bufnr,
      timeout_ms = 20000,
    })
  end

  local starts_with = function(str, start)
    return string.sub(str, 1, #start) == start
  end

  local create_runtime_condition = function(config_names)
    local bufnr_cache = {}
    local config_path_cache = {}

    return function(params)
      if bufnr_cache[params.bufnr] ~= nil then
        return bufnr_cache[params.bufnr]
      else
        for _, cached_config_path in ipairs(config_path_cache) do
          if starts_with(params.bufname, cached_config_path) then
            bufnr_cache[params.bufnr] = true
            return true
          end
        end
      end

      local config_path =
        require('lspconfig').util.root_pattern(config_names)(params.bufname)

      local has_config = config_path ~= nil
      if has_config then
        table.insert(config_path_cache, config_path)
      end
      bufnr_cache[params.bufnr] = has_config

      return has_config
    end
  end

  local eslint_runtime_condition = create_runtime_condition({
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
  })
  local stylua_runtime_condition = create_runtime_condition({
    'stylua.toml',
    '.stylua.toml',
  })
  local vale_runtime_condition = create_runtime_condition({
    '.vale.ini',
  })

  null.setup({
    cmd = { 'nvim' },
    default_timeout = 20000,
    diagnostics_format = '#{c}: #{m} (#{s})',
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = format_augroup,
          buffer = bufnr,
          callback = function()
            format(bufnr)
          end,
        })
      end
    end,
    root_dir = root_dir,
    sources = {
      code_actions.eslint_d,
      code_actions.shellcheck,
      formatters.eslint_d.with({
        runtime_condition = eslint_runtime_condition,
      }),
      formatters.gofmt,
      formatters.prettierd,
      formatters.shfmt.with({
        extra_args = { '-i', '2', '-bn', '-ci', '-sr' },
      }),
      formatters.stylua.with({ runtime_condition = stylua_runtime_condition }),
      linters.eslint_d.with({ runtime_condition = eslint_runtime_condition }),
      linters.shellcheck,
      linters.vale.with({ runtime_condition = vale_runtime_condition }),
    },
  })
end
