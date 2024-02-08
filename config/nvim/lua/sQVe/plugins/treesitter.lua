-- ╺┳╸┏━┓┏━╸┏━╸┏━┓╻╺┳╸╺┳╸┏━╸┏━┓
--  ┃ ┣┳┛┣╸ ┣╸ ┗━┓┃ ┃  ┃ ┣╸ ┣┳┛
--  ╹ ╹┗╸┗━╸┗━╸┗━┛╹ ╹  ╹ ┗━╸╹┗╸
-- Syntax highlighting.

local is_filesize_larger_than =
  require('sQVe.utils.treesitter').is_filesize_larger_than

local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',
  dependencies = { 'RRethy/nvim-treesitter-textsubjects' },
}

M.opts = {
  ensure_installed = {
    'bash',
    'c_sharp',
    'css',
    'diff',
    'dockerfile',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'luadoc',
    'luap',
    'make',
    'markdown',
    'markdown_inline',
    'query',
    'regex',
    'scss',
    'sql',
    'toml',
    'tsx',
    'typescript',
    'vhs',
    'vim',
    'vimdoc',
    'vimdoc',
    'xml',
    'yaml',
  },
  highlight = {
    enable = true,
    disable = function(_, buf)
      return is_filesize_larger_than(
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
