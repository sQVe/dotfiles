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
  local lsp_utils = require('sQVe.utils.lsp')
  local map = require('sQVe.utils.vim').map

  local on_attach = function(client, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })

    if client.name == 'typescript-tools' then
      map(
        'n',
        '<Leader>la',
        '<Cmd>TSToolsAddMissingImports<CR>',
        { desc = 'Add missing imports' }
      )
      map(
        'n',
        '<Leader>ldd',
        '<Cmd>TSToolsRemoveUnused<CR>',
        { desc = 'Remove unused statements' }
      )
      map(
        'n',
        '<Leader>ldi',
        '<Cmd>TSToolsRemoveUnusedImports<CR>',
        { desc = 'Remove unused imports' }
      )
      map(
        'n',
        '<Leader>lf',
        '<Cmd>TSToolsFixAll<CR>',
        { desc = 'Fix all fixable errors' }
      )
      map(
        'n',
        '<Leader>lr',
        '<Cmd>TSToolsRenameFile<CR>',
        { desc = 'Rename current file and fix references' }
      )
    end
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
