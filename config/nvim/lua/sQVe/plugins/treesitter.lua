-- ╺┳╸┏━┓┏━╸┏━╸┏━┓╻╺┳╸╺┳╸┏━╸┏━┓
--  ┃ ┣┳┛┣╸ ┣╸ ┗━┓┃ ┃  ┃ ┣╸ ┣┳┛
--  ╹ ╹┗╸┗━╸┗━╸┗━┛╹ ╹  ╹ ┗━╸╹┗╸
-- Syntax highlighting.

local M = {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  build = ':TSUpdate',
  dependencies = { 'RRethy/nvim-treesitter-textsubjects' },
}

M.opts = {
  ensure_installed = {
    'bash',
    'css',
    'dockerfile',
    'gitignore',
    'go',
    'gomod',
    'graphql',
    'help',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'rust',
    'scss',
    'terraform',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  context_commentstring = { enable = true, enable_autocmd = false },
  highlight = { enable = true },
  indent = { enable = true },
  textsubjects = {
    enable = true,
    keymaps = { ['.'] = 'textsubjects-smart' },
  },
}

M.config = function(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M
