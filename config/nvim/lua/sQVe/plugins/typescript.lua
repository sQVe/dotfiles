-- ╺┳╸╻ ╻┏━┓┏━╸┏━┓┏━╸┏━┓╻┏━┓╺┳╸
--  ┃ ┗┳┛┣━┛┣╸ ┗━┓┃  ┣┳┛┃┣━┛ ┃
--  ╹  ╹ ╹  ┗━╸┗━┛┗━╸╹┗╸╹╹   ╹
-- JavaScript and TypeScript LSP setup.

local M = {}

M.init = function(use)
  use({
    'jose-elias-alvarez/typescript.nvim',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    module = 'typescript',
    config = M.config,
  })
end

M.config = function()
  local lsp_utils = require('sQVe.utils.lsp')
  local typescript = require('typescript')

  local on_attach = function(_, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr)
  end

  typescript.setup({
    disable_commands = false,
    server = { on_attach = on_attach },
  })
end

return M
