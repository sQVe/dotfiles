-- ╺┳╸╻ ╻┏━┓┏━╸┏━┓┏━╸┏━┓╻┏━┓╺┳╸   ╺┳╸┏━┓┏━┓╻  ┏━┓
--  ┃ ┗┳┛┣━┛┣╸ ┗━┓┃  ┣┳┛┃┣━┛ ┃     ┃ ┃ ┃┃ ┃┃  ┗━┓
--  ╹  ╹ ╹  ┗━╸┗━┛┗━╸╹┗╸╹╹   ╹     ╹ ┗━┛┗━┛┗━╸┗━┛
-- JavaScript and TypeScript integration.

local M = {
  'pmizio/typescript-tools.nvim',
  dependencies = {
    { 'dmmulroy/ts-error-translator.nvim', config = true },
  },
  ft = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
}

M.opts = function()
  local lsp_utils = require('sQVe.plugins.lspconfig.utils')
  local map = require('sQVe.utils.vim').map

  local on_attach = function(client, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })
  end

  return {
    on_attach = on_attach,
    settings = {
      expose_as_code_actions = {
        'add_missing_imports',
        'fix_all',
        'remove_unused',
        'remove_unused_imports',
      },
    },
    tsserver_file_preferences = {
      importModuleSpecifierPreference = 'relative',
      quotePreference = 'single',
    },
  }
end

return M
