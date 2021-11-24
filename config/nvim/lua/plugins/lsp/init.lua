--  ╻┏┓╻╻╺┳╸
--  ┃┃┗┫┃ ┃
--  ╹╹ ╹╹ ╹
return function()
  local on_attach = function() end
  local servers = require('plugins.lsp.servers')(on_attach)

  -- Disable virtual text for diagnostics.
  vim.diagnostic.config({ severity_sort = true, virtual_text = false })

  for server, config in pairs(servers) do
    if config.flags == nil then
      config.flags = { debounce_text_changes = 100 }
    end

    -- Initiate and setup all LSP servers (excluding null-ls).
    require('lspconfig')[server].setup(config)
  end

  vim.cmd([[
    " General.
    nnoremap <silent> <Leader>f :lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> K :ShowDocumentation<CR>

    " Diagnostics.
    nnoremap <silent> gl :lua vim.diagnostic.open_float(0, {scope = 'line', header = false})<CR>
    nnoremap <silent> <Leader>lj :lua vim.diagnostic.goto_next({float = false})<CR>
    nnoremap <silent> <Leader>lk :lua vim.diagnostic.goto_prev({float = false})<CR>
  ]])
end
