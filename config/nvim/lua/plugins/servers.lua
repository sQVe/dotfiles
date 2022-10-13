-- ┏━┓┏━╸┏━┓╻ ╻┏━╸┏━┓┏━┓
-- ┗━┓┣╸ ┣┳┛┃┏┛┣╸ ┣┳┛┗━┓
-- ┗━┛┗━╸╹┗╸┗┛ ┗━╸╹┗╸┗━┛

return function(on_attach)
  local lsp_utils = require('utils.lsp')

  local base_setup = lsp_utils.create_base_setup({
    on_attach = on_attach,
  })

  return {
    bashls = base_setup,
    cssls = base_setup,
    gopls = base_setup,
    html = base_setup,
    jsonls = base_setup,
    tsserver = lsp_utils.create_base_setup({
      handlers = {
        -- More codes can be found here:
        -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
        ['textDocument/publishDiagnostics'] = require('utils.lsp').create_diagnostics_handler({
          80001,
        }),
      },
      init_options = {
        preferences = {
          importModuleSpecifierPreference = 'relative',
          quotePreference = 'single',
        },
      },
      on_attach = on_attach,
    }),
    sumneko_lua = lsp_utils.create_base_setup({
      cmd = { 'lua-language-server' },
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          runtime = { version = 'LuaJIT' },
          telemetry = { enable = false },
        },
      },
      on_attach = on_attach,
    }),
    yamlls = base_setup,
  }
end
