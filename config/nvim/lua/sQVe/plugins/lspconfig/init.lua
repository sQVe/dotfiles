-- ╻  ┏━┓┏━┓┏━╸┏━┓┏┓╻┏━╸╻┏━╸
-- ┃  ┗━┓┣━┛┃  ┃ ┃┃┗┫┣╸ ┃┃╺┓
-- ┗━╸┗━┛╹  ┗━╸┗━┛╹ ╹╹  ╹┗━┛
-- Setup Language Server Protocol servers.

local map = require('sQVe.utils.map')
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

    -- gopls
    'go',
    'gomod',
    'gowork',
    'gotmpl',

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

    -- gdscript
    'gd',
    'gdscript',
    'gdscript3',

    -- biome and vtsls
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',

    -- other filetypes where copilot might be useful
    'dockerfile',
    'gitcommit',
    'gitignore',
    'graphql',
    'make',
    'sql',
    'toml',
    'vim',
    'xml',
  },
}

M.config = function()
  local on_attach = function(_, bufnr)
    utils.map_diagnostic_keys(bufnr)
    utils.map_lookup_keys(bufnr)

    map('i', '<C-l>', function()
      vim.lsp.inline_completion.get()
    end, { expr = true, buffer = bufnr })
  end

  local capabilities = require('blink.cmp').get_lsp_capabilities()

  vim.lsp.inline_completion.enable()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = utils.diagnostic_handler
  vim.lsp.log.set_level('OFF')

  vim.lsp.config('bashls', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config('biome', {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(bufnr, on_dir)
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local root = vim.fs.dirname(
        vim.fs.find(
          { 'biome.json', 'biome.jsonc' },
          { path = filename, upward = true }
        )[1]
      )
      on_dir(root)
    end,
  })

  vim.lsp.config('ccls', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config('copilot', {
    on_attach = on_attach,
  })

  vim.lsp.config('cssls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      css = {
        validate = true,
        lint = { unknownAtRules = 'ignore' },
      },
    },
  })

  vim.lsp.config('css_variables', {
    on_attach = on_attach,
    capabilities = capabilities,
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
  })

  vim.lsp.config('gdscript', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config('gopls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          fillstruct = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        completeUnimported = true,
        directoryFilters = { '-.git', '-node_modules' },
        gofumpt = true,
        usePlaceholders = true,
      },
    },
  })

  vim.lsp.config('html', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config('jsonls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  })

  vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
          library = {
            '${3rd}/busted/library',
          },
        },
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  })

  vim.lsp.config('marksman', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config('vtsls', {
    on_attach = on_attach,
    capabilities = capabilities,
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
  })

  vim.lsp.config('yamlls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        schemaStore = { enable = false, url = '' },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  })

  vim.lsp.enable({
    'bashls',
    'biome',
    'ccls',
    'copilot',
    'css_variables',
    'cssls',
    'gdscript',
    'gopls',
    'html',
    'jsonls',
    'lua_ls',
    'marksman',
    'vtsls',
    'yamlls',
  })

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
