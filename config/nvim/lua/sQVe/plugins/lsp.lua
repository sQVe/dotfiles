-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

local M = {}

M.init = function(use)
  use({ 'neovim/nvim-lspconfig', config = M.config, event = { 'BufEnter' } })
end

M.config = function()
  local lspconfig = require('lspconfig')
  local lsp_utils = require('sQVe.utils.lsp')
  local map = require('sQVe.utils.keymap').map
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
        ['textDocument/publishDiagnostics'] = require('sQVe.utils.lsp').create_diagnostics_handler({
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

  -- Format code.
  map('n', '<Leader><Leader>', require('sQVe.utils.lsp').format)

  -- Rename reference.
  map('n', '<Leader>r', vim.lsp.buf.rename)

  -- Show documention for current word.
  map('n', 'K', require('sQVe.utils.lsp').show_documentation)

  -- List code actions.
  map('n', '<Leader>a', vim.lsp.buf.code_action)
  map('x', '<Leader>a', vim.lsp.buf.range_code_action)

  -- Show diagnostics for current line.
  map('n', 'gl', function()
    vim.diagnostic.open_float(0, { scope = 'line', header = false })
  end)

  -- Move to next or previous diagnostic item.
  map('n', '<Leader>lj', function()
    vim.diagnostic.goto_next({ float = false })
  end)
  map('n', '<Leader>lk', function()
    vim.diagnostic.goto_prev({ float = false })
  end)
end

return M
