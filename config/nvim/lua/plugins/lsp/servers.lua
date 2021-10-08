--  ┏━┓┏━╸┏━┓╻ ╻┏━╸┏━┓┏━┓
--  ┗━┓┣╸ ┣┳┛┃┏┛┣╸ ┣┳┛┗━┓
--  ┗━┛┗━╸╹┗╸┗┛ ┗━╸╹┗╸┗━┛
return function(on_attach_callback)
    local root_dir = require('util').root_dir

    local disable_formatting = function(client)
        -- Disable LSP based formatting. Formatting is handled by null-ls.
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

    -- Enable LSP snippet support.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    local commonConfig = {
        capabilities = capabilities,
        on_attach = function(client)
            disable_formatting(client)
            on_attach_callback()
        end,
        root_dir = root_dir,
    }

    return {
        bashls = commonConfig,
        cssls = commonConfig,
        gopls = commonConfig,
        html = commonConfig,
        jsonls = commonConfig,
        tsserver = {
            capabilities = commonConfig.capabilities,
            on_attach = function(client)
                local ts_utils = require('nvim-lsp-ts-utils')

                ts_utils.setup({
                    enable_import_on_completion = true,
                    eslint_bin = 'eslint_d',
                    filter_out_diagnostics_by_code = {
                        80001, -- Require modules.
                    },
                })
                ts_utils.setup_client(client)

                disable_formatting(client)
                on_attach_callback()
            end,
            root_dir = commonConfig.root_dir,
        },
        sumneko_lua = {
            capabilities = commonConfig.capabilities,
            cmd = {'lua-language-server'},
            on_attach = commonConfig.on_attach,
            root_dir = commonConfig.root_dir,
            settings = {
                Lua = {
                    diagnostics = {globals = {'vim'}},
                    runtime = {version = 'LuaJIT'},
                    telemetry = {enable = false},
                },
            },
        },
        yamlls = commonConfig,
    }
end
