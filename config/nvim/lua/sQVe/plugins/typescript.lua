-- ╺┳╸╻ ╻┏━┓┏━╸┏━┓┏━╸┏━┓╻┏━┓╺┳╸
--  ┃ ┗┳┛┣━┛┣╸ ┗━┓┃  ┣┳┛┃┣━┛ ┃
--  ╹  ╹ ╹  ┗━╸┗━┛┗━╸╹┗╸╹╹   ╹
-- JavaScript and TypeScript LSP setup and commands.

local M = {}

M.init = function(use)
  use({
    'jose-elias-alvarez/typescript.nvim',
    after = 'nvim-lspconfig',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    config = M.config,
  })
end

M.config = function()
  local lsp_utils = require('sQVe.utils.lsp')
  local typescript = require('typescript')
  local map = require('sQVe.utils.vim').map

  local on_attach = function(_, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr)
    map(
      'n',
      'gd',
      '<Cmd>TypescriptGoToSourceDefinition<CR>',
      { buffer = bufnr }
    )
  end

  typescript.setup({
    server = { on_attach = on_attach },
  })
end

return M
