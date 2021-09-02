--  ╻┏┓╻╻╺┳╸
--  ┃┃┗┫┃ ┃
--  ╹╹ ╹╹ ╹
return function()
    local on_attach = function() require'lsp_signature'.on_attach() end
    local servers = require('plugins.lsp.servers')(on_attach)

    for server, config in pairs(servers) do
        if config.flags == nil then
            config.flags = {debounce_text_changes = 150}
        end

        require("lspconfig")[server].setup(config)
    end

    -- Disable virtual text for diagnostics.
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {virtual_text = false})

    -- General keymap.
    vim.cmd([[
      nnoremap <silent> <Leader>a :lua vim.lsp.buf.code_action()<CR>
      xnoremap <silent> <Leader>a :lua vim.lsp.buf.range_code_action()<CR>
      nnoremap <silent> <Leader>f :lua vim.lsp.buf.formatting()<CR>
      nnoremap <silent> <Leader>r :lua vim.lsp.buf.rename()<CR>
      nnoremap <silent> <Leader>s :lua vim.lsp.buf.document_symbol()<CR>
      nnoremap <silent> <Leader>S :lua vim.lsp.buf.workspace_symbol()<CR>
      nnoremap <silent> K :ShowDocumentation<CR>
      nnoremap <silent> gd :lua vim.lsp.buf.implementation()<CR>
      nnoremap <silent> gD :lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
      nnoremap <silent> gy :lua vim.lsp.buf.type_definition()<CR>
   ]])

    -- Diagnostics keymap.
    vim.cmd([[
      nnoremap <silent> gl :lua vim.lsp.diagnostic.show_line_diagnostics({show_header = false})<CR>
      nnoremap <silent> <Leader>lj :lua vim.lsp.diagnostic.goto_next({popup_opts = {show_header = false}})<CR>
      nnoremap <silent> <Leader>lk :lua vim.lsp.diagnostic.goto_prev({popup_opts = {show_header = false}})<CR>
      nnoremap <silent> <Leader>l :LspDiagnostics 0<CR>
      nnoremap <silent> <Leader>L :LspDiagnosticsAll<CR>
    ]])

    -- Signs.
    vim.cmd([[
        sign define LspDiagnosticsSignError text=■ texthl=LspDiagnosticsSignError
        sign define LspDiagnosticsSignWarning text=■ texthl=LspDiagnosticsSignWarning
        sign define LspDiagnosticsSignInformation text=■ texthl=LspDiagnosticsSignInformation
        sign define LspDiagnosticsSignHint text=■ texthl=LspDiagnosticsSignHint
    ]])
end
