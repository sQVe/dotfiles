-- ╻  ┏━┓┏━┓┏━╸┏━┓┏┓╻┏━╸╻┏━╸
-- ┃  ┗━┓┣━┛┃  ┃ ┃┃┗┫┣╸ ┃┃╺┓
-- ┗━╸┗━┛╹  ┗━╸┗━┛╹ ╹╹  ╹┗━┛
-- Setup Language Server Protocol servers.

local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'folke/neodev.nvim', config = true },
  },
  ft = {
    -- bashls
    'sh',

    -- cssls
    'css',
    'scss',

    -- html
    'html',

    -- jsonls
    'json',
    'jsonc',

    -- lua_ls
    'lua',

    -- terraform
    'terraform',
    'terraform-vars',

    -- yamlls
    'yaml',

    -- misc (further filetypes to handle with null-ls)
    'graphql',
    'markdown',
  },
  keys = {
    { '<Leader>r', vim.lsp.buf.rename, desc = 'Rename symbol' },
    {
      '<Leader>a',
      vim.lsp.buf.code_action,
      mode = { 'n', 'x' },
      desc = 'List code actions',
    },
    {
      '<Leader>dn',
      function()
        vim.diagnostic.goto_next({ float = false })
      end,
      desc = 'Next diagnostic entry',
    },
    {
      '<Leader>dp',
      function()
        vim.diagnostic.goto_prev({ float = false })
      end,
      desc = 'Previous diagnostic entry',
    },
  },
}

M.config = function()
  local lspconfig = require('lspconfig')
  local lsp_utils = require('sQVe.utils.lsp')

  local on_attach = function(_, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })
  end

  local server_setup = lsp_utils.create_server_setup({
    on_attach = on_attach,
  })

  vim.lsp.set_log_level('OFF')
  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    lsp_utils.diagnostic_handler

  local servers = {
    -- Servers already handled by plugin setup:
    --   JavaScript/TypeScript (typescript-tools)
    --   Neovim plugin development (neodev)

    bashls = server_setup,
    cssls = server_setup,
    html = server_setup,
    jsonls = server_setup,
    lua_ls = lsp_utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          completion = { callSnippet = 'Replace' },
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        },
      },
    }),
    terraformls = server_setup,
    yamlls = server_setup,
  }

  for server, config in pairs(servers) do
    if config.flags == nil then
      config.flags = { debounce_text_changes = 100 }
    end

    -- Initiate and setup LSP servers.
    lspconfig[server].setup(config)
  end

  -- Configure diagnostics.
  vim.diagnostic.config({
    severity_sort = true,
    underline = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    virtual_text = false,
  })
end

return M
