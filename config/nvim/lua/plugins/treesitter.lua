--  ╺┳╸┏━┓┏━╸┏━╸┏━┓╻╺┳╸╺┳╸┏━╸┏━┓
--   ┃ ┣┳┛┣╸ ┣╸ ┗━┓┃ ┃  ┃ ┣╸ ┣┳┛
--   ╹ ╹┗╸┗━╸┗━╸┗━┛╹ ╹  ╹ ┗━╸╹┗╸

return function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'comment',
      'css',
      'dockerfile',
      'go',
      'gomod',
      'graphql',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'markdown',
      'scss',
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
  })
end