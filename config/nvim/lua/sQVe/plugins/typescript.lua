-- ╺┳╸╻ ╻┏━┓┏━╸┏━┓┏━╸┏━┓╻┏━┓╺┳╸
--  ┃ ┗┳┛┣━┛┣╸ ┗━┓┃  ┣┳┛┃┣━┛ ┃
--  ╹  ╹ ╹  ┗━╸┗━┛┗━╸╹┗╸╹╹   ╹
-- JavaScript and TypeScript LSP setup.

local M = {
  'jose-elias-alvarez/typescript.nvim',
  ft = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
}

M.opts = function()
  local lsp_utils = require('sQVe.utils.lsp')

  local on_attach = function(_, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })
  end

  local server_setup = lsp_utils.create_server_setup({
    init_options = {
      preferences = {
        importModuleSpecifierPreference = 'relative',
        quotePreference = 'single',
      },
    },
    on_attach = on_attach,
  })

  return {
    disable_commands = false,
    server = server_setup,
  }
end

return M
