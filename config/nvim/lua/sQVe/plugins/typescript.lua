-- ╺┳╸╻ ╻┏━┓┏━╸┏━┓┏━╸┏━┓╻┏━┓╺┳╸
--  ┃ ┗┳┛┣━┛┣╸ ┗━┓┃  ┣┳┛┃┣━┛ ┃
--  ╹  ╹ ╹  ┗━╸┗━┛┗━╸╹┗╸╹╹   ╹
-- JavaScript and TypeScript LSP setup.

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
    module = 'typescript',
    config = M.config,
  })
end

M.config = function()
  require('typescript').setup({ disable_commands = false })
end

return M
