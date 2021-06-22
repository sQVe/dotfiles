--  ╻┏┓╻╻╺┳╸
--  ┃┃┗┫┃ ┃ 
--  ╹╹ ╹╹ ╹ 
return function()
    local on_attach = function() require'lsp_signature'.on_attach() end
    local servers = require('plugins.lsp.servers')(on_attach)

    for server, config in pairs(servers) do
        require("lspconfig")[server].setup(config)
    end

    -- Disable virtual text for diagnostics.
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {virtual_text = false})

    vim.cmd([[
        sign define LspDiagnosticsSignError text=■ texthl=LspDiagnosticsSignError
        sign define LspDiagnosticsSignWarning text=■ texthl=LspDiagnosticsSignWarning
        sign define LspDiagnosticsSignInformation text=■ texthl=LspDiagnosticsSignInformation
        sign define LspDiagnosticsSignHint text=■ texthl=LspDiagnosticsSignHint
    ]])
end
