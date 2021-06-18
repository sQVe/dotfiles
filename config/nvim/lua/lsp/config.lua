--  ┏━╸┏━┓┏┓╻┏━╸╻┏━╸
--  ┃  ┃ ┃┃┗┫┣╸ ┃┃╺┓
--  ┗━╸┗━┛╹ ╹╹  ╹┗━┛

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
    require'lsp_signature'.on_attach()
end

lspconfig.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
