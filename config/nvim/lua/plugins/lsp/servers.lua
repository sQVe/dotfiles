--  ┏━┓┏━╸┏━┓╻ ╻┏━╸┏━┓┏━┓
--  ┗━┓┣╸ ┣┳┛┃┏┛┣╸ ┣┳┛┗━┓
--  ┗━┛┗━╸╹┗╸┗┛ ┗━╸╹┗╸┗━┛
return function(on_attach_callback)
    local root_dir = require('util').root_dir

    local on_attach = function(client)
        -- Disable LSP based formatting. Formatting is handled by null-ls.
        client.resolved_capabilities.document_formatting = false
        on_attach_callback()
    end

    -- Enable LSP snippet support.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    local commonConfig = {
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = root_dir
    }

    return {
        bashls = commonConfig,
        cssls = commonConfig,
        gopls = commonConfig,
        html = commonConfig,
        jsonls = commonConfig,
        tsserver = commonConfig,
        sumneko_lua = {
            capabilities = commonConfig.capabilities,
            cmd = {"lua-language-server"},
            on_attach = commonConfig.on_attach,
            root_dir = commonConfig.root_dir,
            settings = {
                Lua = {
                    diagnostics = {globals = {'vim'}},
                    runtime = {version = 'LuaJIT'},
                    telemetry = {enable = false}
                }
            }
        },
        yamlls = commonConfig
    }
end
