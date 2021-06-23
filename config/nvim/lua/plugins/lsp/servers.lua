--  ┏━┓┏━╸┏━┓╻ ╻┏━╸┏━┓┏━┓
--  ┗━┓┣╸ ┣┳┛┃┏┛┣╸ ┣┳┛┗━┓
--  ┗━┛┗━╸╹┗╸┗┛ ┗━╸╹┗╸┗━┛
local util = require("lspconfig").util

local formatters = require('plugins.lsp.efm.formatters')
local linters = require('plugins.lsp.efm.linters')

return function(on_attach)
    return {
        bashls = {},
        cssls = {},
        html = {},
        jsonls = {},
        yamlls = {},

        efm = {
            cmd = {"efm-langserver"},
            on_attach = function(client)
                client.resolved_capabilities.completion = false
                client.resolved_capabilities.document_formatting = true
                client.resolved_capabilities.hover = false
                client.resolved_capabilities.rename = false

                vim.cmd([[
                    augroup Format
                        autocmd! * <buffer>
                        autocmd BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_seq_sync()
                    augroup END
                ]])
            end,
            init_options = {codeAction = true, documentFormatting = true},
            filetypes = {
                "css", "go", "html", "javascript", "javascriptreact", "json",
                "jsonc", "lua", "markdown", "scss", "sh", "typescript",
                "typescriptreact", "yaml"
            },
            root_dir = function(filename)
                if string.match(filename, '%.go$') then
                    return util.root_pattern('go.mod')(filename) or
                               util.find_git_ancestor(filename)
                end

                return util.find_package_json_ancestor(filename) or
                           util.find_git_ancestor(filename)
            end,
            settings = {
                rootMarkers = {vim.loop.cwd()},
                languages = {
                    css = {formatters.prettier},
                    go = {formatters.gofmt},
                    html = {formatters.prettier},
                    javascript = {linters.eslint, formatters.prettier},
                    javascriptreact = {linters.eslint, formatters.prettier},
                    json = {formatters.prettier},
                    jsonc = {formatters.prettier},
                    lua = {formatters.luaformat},
                    markdown = {formatters.prettier},
                    scss = {formatters.prettier},
                    sh = {linters.shellcheck, formatters.shfmt},
                    typescript = {linters.eslint, formatters.prettier},
                    typescriptreact = {linters.eslint, formatters.prettier},
                    yaml = {formatters.prettier}
                }
            }
        },

        gopls = {
            on_attach = on_attach,
            root_dir = function(filename)
                return util.root_pattern("go.mod", ".git")(filename) or
                           util.path.dirname(filename)
            end
        },

        sumneko_lua = {
            cmd = {"lua-language-server"},
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {globals = {'vim'}},
                    runtime = {version = 'LuaJIT'},
                    telemetry = {enable = false}
                }
            }
        },

        tsserver = {
            on_attach = function(client)
                client.resolved_capabilities.document_formatting = false
                on_attach()
            end
        }

    }
end
