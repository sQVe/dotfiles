-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

local M = {}

M.init = function(use)
  use({ 'neovim/nvim-lspconfig', config = M.config, event = { 'BufEnter' } })
end

M.config = function()
  local lspconfig = require('lspconfig')
  local lsp_utils = require('utils.lsp')
  local on_attach = function() end

  local base_setup = lsp_utils.create_base_setup({
    on_attach = on_attach,
  })

  local servers = {
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

  for server, config in pairs(servers) do
    if config.flags == nil then
      config.flags = { debounce_text_changes = 100 }
    end

    -- Initiate and setup all LSP servers, except null-ls and rust.
    lspconfig[server].setup(config)
  end

  -- Disable virtual text for diagnostics.
  vim.diagnostic.config({ severity_sort = true, virtual_text = false })

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

return M
