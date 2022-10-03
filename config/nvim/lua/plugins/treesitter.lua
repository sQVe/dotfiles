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
