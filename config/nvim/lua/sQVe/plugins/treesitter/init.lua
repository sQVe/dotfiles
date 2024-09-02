-- ╺┳╸┏━┓┏━╸┏━╸┏━┓╻╺┳╸╺┳╸┏━╸┏━┓
--  ┃ ┣┳┛┣╸ ┣╸ ┗━┓┃ ┃  ┃ ┣╸ ┣┳┛
--  ╹ ╹┗╸┗━╸┗━╸┗━┛╹ ╹  ╹ ┗━╸╹┗╸
-- Syntax highlighting.

local languages = require('sQVe.plugins.treesitter.languages')
local utils = require('sQVe.plugins.treesitter.utils')

local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',
  dependencies = { 'RRethy/nvim-treesitter-textsubjects' },
}

M.opts = {
  ensure_installed = languages,
  highlight = {
    enable = true,
    disable = function(_, buf)
      return utils.is_filesize_larger_than(
        buf,
        100 * 1024 -- 100 KiB
      )
    end,
  },
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
