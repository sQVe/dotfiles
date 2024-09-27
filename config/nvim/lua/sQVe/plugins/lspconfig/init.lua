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

    -- ccls
    'c',
    'cpp',
    'cuda',
    'objc',
    'objcpp',
    'proto',

    -- cssls and css_variables
    'css',

    -- html
    'html',

    -- jsonls
    'json',
    'jsonc',

    -- lua_ls
    'lua',

    -- marksman,
    'markdown',

    -- yamlls
    'yaml',

    -- biome and vtsls
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
    biome = server_setup,
    ccls = server_setup,
    cssls = utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        css = {
          validate = true,
          lint = { unknownAtRules = 'ignore' },
        },
      },
    }),
    css_variables = utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        cssVariables = {
          blacklistFolders = {
            '**/.cache',
            '**/.git',
            '**/.next',
            '**/dist',
            '**/node_modules',
            '**/tmp',
          },
          lookupFiles = {
            '**/*.css',
            'node_modules/@mantine/core/styles.css',
            'packages/design-system/node_modules/@mantine/core/styles.css',
          },
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
    vtsls = utils.create_server_setup({
      on_attach = on_attach,
      settings = {
        javascript = {
          format = { enable = false },
          preferences = { quoteStyle = 'single' },
          suggest = { completeFunctionCalls = true },
          tsserver = { maxTsServerMemory = 8192 },
        },
        typescript = {
          format = { enable = false },
          preferences = {
            importModuleSpecifier = 'shortest',
            importModuleSpecifierEnding = 'minimal',
            quoteStyle = 'single',
          },
          suggest = { completeFunctionCalls = true },
          tsserver = { maxTsServerMemory = 8192 },
        },
        vtsls = {
          autoUseWorkspaceTsdk = true,
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
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
