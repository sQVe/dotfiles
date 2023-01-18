-- ╻  ┏━┓┏━┓┏━╸┏━┓┏┓╻┏━╸╻┏━╸
-- ┃  ┗━┓┣━┛┃  ┃ ┃┃┗┫┣╸ ┃┃╺┓
-- ┗━╸┗━┛╹  ┗━╸┗━┛╹ ╹╹  ╹┗━┛
-- Setup Language Server Protocol servers.

local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
  },
  ft = {
    -- bashls
    'sh',

    -- cssls
    'css',
    'scss',

    -- gopls
    'go',
    'gomod',

    -- html
    'html',

    -- jsonls
    'json',
    'jsonc',

    -- sumneko_lua
    'lua',

    -- rust
    'rust',

    -- tsserver
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',

    -- yamlls
    'yaml',

    -- misc (further filetypes to handle with null-ls)
    'graphql',
    'markdown',
  },
  keys = {
    { '<Leader>r', vim.lsp.buf.rename },
    { '<Leader>a', vim.lsp.buf.code_action, mode = { 'n', 'x' } },
    {
      '<Leader>ln',
      function()
        vim.diagnostic.goto_next({ float = false })
      end,
    },
    {
      '<Leader>lp',
      function()
        vim.diagnostic.goto_prev({ float = false })
      end,
    },
  },
}

M.config = function()
  local lspconfig = require('lspconfig')
  local lsp_utils = require('sQVe.utils.lsp')
  local on_attach = function(_, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })
  end

  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    lsp_utils.diagnostic_handler

  local base_setup = lsp_utils.create_base_setup({
    on_attach = on_attach,
  })

  local servers = {
    -- Servers already handled by plugin setup:
    --   JavaScript and TypeScript (typescript)
    --   Neodev (nvim lua API)
    --   Rust (rust-tools)

    bashls = base_setup,
    cssls = base_setup,
    gopls = base_setup,
    html = base_setup,
    jsonls = base_setup,
    sumneko_lua = lsp_utils.create_base_setup({
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          completion = { callSnippet = 'Replace' },
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
  vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
  })
end

return M
