--  ╻┏┓╻╻╺┳╸
--  ┃┃┗┫┃ ┃
--  ╹╹ ╹╹ ╹
return function()
    local on_attach = function() end
    local servers = require('plugins.lsp.servers')(on_attach)

    local lsp = vim.lsp

    -- Disable virtual text for diagnostics.
    lsp.handlers['textDocument/publishDiagnostics'] =
        lsp.with(lsp.diagnostic.on_publish_diagnostics, {virtual_text = false})

    for server, config in pairs(servers) do
        if config.flags == nil then
            config.flags = {debounce_text_changes = 100}
        end

        -- Initiate and setup all LSP servers (excluding null-ls).
        require('lspconfig')[server].setup(config)
    end

    vim.cmd([[
        " General.
        nnoremap <silent> <Leader>f :lua vim.lsp.buf.formatting()<CR>
        nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
        nnoremap <silent> K :ShowDocumentation<CR>

        " Diagnostics.
        nnoremap <silent> gl :lua vim.lsp.diagnostic.show_line_diagnostics({show_header = false})<CR>
        nnoremap <silent> <Leader>lj :lua vim.lsp.diagnostic.goto_next({popup_opts = {show_header = false}})<CR>
        nnoremap <silent> <Leader>lk :lua vim.lsp.diagnostic.goto_prev({popup_opts = {show_header = false}})<CR>

        " Insert.
        inoremap <silent> <C-k> <cmd>:lua vim.lsp.buf.signature_help()<CR>
    ]])
end
