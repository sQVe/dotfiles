-- ╻  ┏━┓┏━┓
-- ┃  ┗━┓┣━┛
-- ┗━╸┗━┛╹
-- Setup Language Server Protocol.

local M = {}

M.init = function(use)
  use({ 'neovim/nvim-lspconfig', config = M.config, event = { 'BufEnter' } })
end

M.config = function()
  local lspconfig = require('lspconfig')
  local lsp_utils = require('sQVe.utils.lsp')
  local map = require('sQVe.utils.vim').map
  local on_attach = function(_, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr)
  end

  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    lsp_utils.diagnostic_handler

  local base_setup = lsp_utils.create_base_setup({
    on_attach = on_attach,
  })

  local servers = {
    -- Servers already handled by plugin setup:
    --   Rust (rust-tools)
    --   JavaScript and TypeScript (typescript)

    bashls = base_setup,
    cssls = base_setup,
    gopls = base_setup,
    html = base_setup,
    jsonls = base_setup,
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

  -- Rename reference.
  map('n', '<Leader>r', vim.lsp.buf.rename)

  -- List code actions.
  map({ 'n', 'x' }, '<Leader>a', vim.lsp.buf.code_action)

  -- Move to next or previous diagnostic item.
  map('n', '<Leader>lj', function()
    vim.diagnostic.goto_next({ float = false })
  end)
  map('n', '<Leader>lk', function()
    vim.diagnostic.goto_prev({ float = false })
  end)
end

return M