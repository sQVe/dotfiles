-- ╺┳╸┏━┓┏━╸┏━╸┏━┓╻╺┳╸╺┳╸┏━╸┏━┓
--  ┃ ┣┳┛┣╸ ┣╸ ┗━┓┃ ┃  ┃ ┣╸ ┣┳┛
--  ╹ ╹┗╸┗━╸┗━╸┗━┛╹ ╹  ╹ ┗━╸╹┗╸
-- Syntax highlighting.

local languages = require('sQVe.plugins.treesitter.languages')

local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'master',
  event = 'BufReadPost',
}

M.opts = {
  ensure_installed = languages,
  highlight = { enable = true },
  indent = { enable = true },
  textsubjects = {
    enable = true,
    prev_selection = ';',
    keymaps = { [','] = 'textsubjects-smart' },
  },
}

M.config = function(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M
