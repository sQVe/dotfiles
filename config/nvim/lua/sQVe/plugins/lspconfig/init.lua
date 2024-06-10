-- ╻  ┏━┓┏━┓┏━╸┏━┓┏┓╻┏━╸╻┏━╸
-- ┃  ┗━┓┣━┛┃  ┃ ┃┃┗┫┣╸ ┃┃╺┓
-- ┗━╸┗━┛╹  ┗━╸┗━┛╹ ╹╹  ╹┗━┛
-- Setup Language Server Protocol servers.

local utils = require('sQVe.plugins.lspconfig.utils')

local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    'b0o/schemastore.nvim',
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

    -- javascript and typescript
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
}

M.config = function()
  local lspconfig = require('lspconfig')
  local lspconfig_util = require('lspconfig.util')

  local on_attach = function(_, bufnr)
    utils.enable_code_lens(bufnr, { 'markdown' })
    utils.map_diagnostic_keys(bufnr)
    utils.map_lookup_keys(bufnr)
  end

  local server_setup = utils.create_server_setup({
    on_attach = on_attach,
  })

  vim.lsp.set_log_level('OFF')
  vim.lsp.handlers['textDocument/publishDiagnostics'] = utils.diagnostic_handler

  local servers = {
    -- Servers already handled by plugin setup:
    --   Neovim plugin development (neodev)

    bashls = server_setup,
    cssls = server_setup,
    cucumber_language_server = utils.create_server_setup({
      cmd = {
        -- Use a specific Node.js version that is compatible with
        -- cucumber-language-server.
        vim.fn.expand('$NVM_DIR')
          .. '/versions/node/v18.20.3/bin'
          .. '/node',
        vim.fn.expand('$NVM_DIR')
          .. '/versions/node/v18.20.3/bin'
          .. '/cucumber-language-server',
        '--stdio',
      },
      on_attach = function(client, bufnr)
        if client then
          client.server_capabilities.semanticTokensProvider = nil
        end

        on_attach(client, bufnr)
      end,
      root_dir = lspconfig_util.root_pattern('package.json'),
      settings = {
        cucumber = {
          features = { 'e2e/features/**/*.feature' },
          glue = { 'e2e/steps/**/*.ts' },
        },
      },
    }),
    html = server_setup,
    jsonls = utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }),
    lua_ls = utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        },
      },
    }),
    marksman = server_setup,
    tsserver = utils.create_server_setup({
      on_attach = on_attach,
      init_options = {
        hostInfo = 'neovim',
        maxTsServerMemory = 8192,
        preferences = {
          importModuleSpecifierEnding = 'minimal',
          importModuleSpecifierPreference = 'shortest',
          interactiveInlayHints = false,
          quotePreference = 'single',
        },
      },
    }),
    yamlls = utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        yaml = {
          schemaStore = { enable = false, url = '' },
          schemas = require('schemastore').yaml.schemas(),
        },
      },
    }),
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
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
    },
    severity_sort = true,
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_text = false,
  })
end

return M
