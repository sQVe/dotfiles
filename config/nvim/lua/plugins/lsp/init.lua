--  ╻┏┓╻╻╺┳╸
--  ┃┃┗┫┃ ┃
--  ╹╹ ╹╹ ╹

return function()
  local lspconfig = require('lspconfig')
  local on_attach = function() end
  local servers = require('plugins.lsp.servers')(on_attach)

  -- Disable virtual text for diagnostics.
  vim.diagnostic.config({ severity_sort = true, virtual_text = false })

  for server, config in pairs(servers) do
    if config.flags == nil then
      config.flags = { debounce_text_changes = 100 }
    end

    -- Initiate and setup all LSP servers (excluding null-ls).
    lspconfig[server].setup(config)
  end

  vim.cmd([[
    " Formatting and refactoring.
    nnoremap <silent> <Leader><Leader> <Cmd>lua require("utils.lsp").format()<CR>
    nnoremap <silent> <Leader>r <Cmd>lua vim.lsp.buf.rename()<CR>

    " Documentation.
    nnoremap <silent> K <Cmd>ShowDocumentation<CR>

    " Actions.
    nnoremap <silent> <Leader>a <Cmd>lua vim.lsp.buf.code_action()<CR>
    xnoremap <silent> <Leader>a <Cmd>lua vim.lsp.buf.range_code_action()<CR>

    " Diagnostics.
    nnoremap <silent> gl <Cmd>lua vim.diagnostic.open_float(0, {scope = 'line', header = false})<CR>
    nnoremap <silent> <Leader>lj <Cmd>lua vim.diagnostic.goto_next({float = false})<CR>
    nnoremap <silent> <Leader>lk <Cmd>lua vim.diagnostic.goto_prev({float = false})<CR>
  ]])
end
