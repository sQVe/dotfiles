-- ╺┳╸╻ ╻┏━┓┏━╸┏━┓┏━╸┏━┓╻┏━┓╺┳╸   ╺┳╸┏━┓┏━┓╻  ┏━┓
--  ┃ ┗┳┛┣━┛┣╸ ┗━┓┃  ┣┳┛┃┣━┛ ┃     ┃ ┃ ┃┃ ┃┃  ┗━┓
--  ╹  ╹ ╹  ┗━╸┗━┛┗━╸╹┗╸╹╹   ╹     ╹ ┗━┛┗━┛┗━╸┗━┛
-- JavaScript and TypeScript integration.

local M = {
  'pmizio/typescript-tools.nvim',
  requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
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

  return {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = 'relative',
        quotePreference = 'single',
      },
    },
    on_attach = on_attach,
    settings = {
      expose_as_code_actions = 'all',
    },
  }
end

return M
