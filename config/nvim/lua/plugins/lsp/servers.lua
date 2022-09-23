--  ┏━┓┏━╸┏━┓╻ ╻┏━╸┏━┓┏━┓
--  ┗━┓┣╸ ┣┳┛┃┏┛┣╸ ┣┳┛┗━┓
--  ┗━┛┗━╸╹┗╸┗┛ ┗━╸╹┗╸┗━┛

return function(on_attach)
  local root_dir = require('utils.lsp').root_dir()

  -- Mirror capabilities set by `update_capabilities` in `cmp-nvim-lsp`, since
  -- we want to decouple LSP from it.
  -- https://github.com/hrsh7th/cmp-nvim-lsp/blob/main/lua/cmp_nvim_lsp/init.lua.
  local update_capabilities = function(capabilities)
    local completionItem = capabilities.textDocument.completion.completionItem

    completionItem.commitCharactersSupport = true
    completionItem.deprecatedSupport = true
    completionItem.insertReplaceSupport = true
    completionItem.labelDetailsSupport = true
    completionItem.preselectSupport = true
    completionItem.resolveSupport = {
      properties = { 'additionalTextEdits', 'detail', 'documentation' },
    }
    completionItem.snippetSupport = true
    completionItem.tagSupport = { valueSet = { 1 } }

    return capabilities
  end

  local common_setup = {
    capabilities = update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    on_attach = on_attach,
    root_dir = root_dir,
  }

  local with_common_setup = function(settings)
    return vim.tbl_extend('force', common_setup, settings or {})
  end

  local tsserver_diagnostics_handler = function(...)
    local params = select(2, ...)

    if params.diagnostics ~= nil then
      for idx, diagnostic in ipairs(params.diagnostics) do
        -- More codes can be found here:
        -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
        local disabled_codes = { 80001 }

        for _, code in ipairs(disabled_codes) do
          if diagnostic.code == code then
            table.remove(params.diagnostics, idx)
          end
        end
      end
    end

    vim.lsp.handlers['textDocument/publishDiagnostics'](...)
  end

  return {
    bashls = common_setup,
    cssls = common_setup,
    gopls = common_setup,
    html = common_setup,
    jsonls = common_setup,
    tsserver = with_common_setup({
      handlers = {
        ['textDocument/publishDiagnostics'] = tsserver_diagnostics_handler,
      },
      init_options = {
        preferences = {
          importModuleSpecifierPreference = 'relative',
          quotePreference = 'single',
        },
      },
    }),
    sumneko_lua = with_common_setup({
      cmd = { 'lua-language-server' },
      root_dir = root_dir,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          runtime = { version = 'LuaJIT' },
          telemetry = { enable = false },
        },
      },
    }),
    yamlls = common_setup,
  }
end
