--  ┏━┓┏━╸┏━┓╻ ╻┏━╸┏━┓┏━┓
--  ┗━┓┣╸ ┣┳┛┃┏┛┣╸ ┣┳┛┗━┓
--  ┗━┛┗━╸╹┗╸┗┛ ┗━╸╹┗╸┗━┛

return function(on_attach_callback)
  local root_dir = require('util').root_dir()

  local set_formatting_capabilities = function(client, value)
    -- Set LSP formatting.
    client.server_capabilities.documentFormattingProvider = value
    client.server_capabilities.documentRangeFormattingProvider = value
  end

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

  local common = {
    capabilities = update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    on_attach = function(client)
      set_formatting_capabilities(client, false)
      on_attach_callback()
    end,
    root_dir = root_dir,
  }

  return {
    bashls = common,
    cssls = common,
    gopls = common,
    html = common,
    jsonls = common,
    tsserver = common,
    sumneko_lua = {
      capabilities = common.capabilities,
      cmd = { 'lua-language-server' },
      on_attach = common.on_attach,
      root_dir = root_dir,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          runtime = { version = 'LuaJIT' },
          telemetry = { enable = false },
        },
      },
    },
    yamlls = common,
  }
end
