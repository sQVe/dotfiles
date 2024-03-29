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

    -- cucumber_language_server
    'cucumber',

    -- html
    'html',

    -- jsonls
    'json',
    'jsonc',

    -- lua_ls
    'lua',

    -- markdown,
    'markdown',

    -- yamlls
    'yaml',

    -- javascript and typescript (handled by typescript-tools)
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
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
        vim.diagnostic.goto_next({
          float = false,
          severity = { min = vim.diagnostic.severity.WARN },
        })
      end,
      desc = 'Next diagnostic entry',
    },
    {
      '<Leader>dp',
      function()
        vim.diagnostic.goto_prev({
          float = false,
          severity = { min = vim.diagnostic.severity.WARN },
        })
      end,
      desc = 'Previous diagnostic entry',
    },
  },
}

M.config = function()
  local lspconfig = require('lspconfig')
  local lspconfig_util = require('lspconfig.util')
  local utils = require('sQVe.plugins.lspconfig.utils')

  local on_attach = function(_, bufnr)
    utils.enable_code_lens(bufnr, { 'markdown' })
    utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })
  end

  local server_setup = utils.create_server_setup({
    on_attach = on_attach,
  })

  vim.lsp.set_log_level('OFF')
  vim.lsp.handlers['textDocument/publishDiagnostics'] = utils.diagnostic_handler

  local servers = {
    -- Servers already handled by plugin setup:
    --   JavaScript/TypeScript (typescript-tools)
    --   Neovim plugin development (neodev)

    bashls = server_setup,
    cssls = server_setup,
    cucumber_language_server = utils.create_server_setup({
      cmd = {
        -- Use a specific Node.js version that is compatible with
        -- cucumber-language-server.
        vim.fn.expand('$NVM_DIR')
          .. '/versions/node/v18.19.1/bin'
          .. '/node',
        vim.fn.expand('$NVM_DIR')
          .. '/versions/node/v18.19.1/bin'
          .. '/cucumber-language-server',
        '--stdio',
      },
      on_attach = on_attach,
      root_dir = lspconfig_util.root_pattern('package.json'),
      settings = {
        cucumber = {
          features = { 'e2e/features/**/*.feature' },
          glue = { 'e2e/steps/**/*.ts' },
        },
      },
    }),
    html = server_setup,
    jsonls = server_setup,
    lua_ls = utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        },
      },
    }),
    markdown_oxide = server_setup,
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
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_text = false,
  })
end

return M
