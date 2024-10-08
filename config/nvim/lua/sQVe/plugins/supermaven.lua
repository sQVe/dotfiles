-- ┏━┓╻ ╻┏━┓┏━╸┏━┓┏┳┓┏━┓╻ ╻┏━╸┏┓╻
-- ┗━┓┃ ┃┣━┛┣╸ ┣┳┛┃┃┃┣━┫┃┏┛┣╸ ┃┗┫
-- ┗━┛┗━┛╹  ┗━╸╹┗╸╹ ╹╹ ╹┗┛ ┗━╸╹ ╹
-- AI Copilot.

local palette = require('sQVe.plugins.catppuccin.palette')

local enabled_filetypes = {
  'css',
  'cucumber',
  'dockerfile',
  'graphql',
  'html',
  'javascript',
  'javascriptreact',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'mchat',
  'scss',
  'sh',
  'typescript',
  'typescriptreact',
  'yaml',
  'zsh',
}

local M = {
  'supermaven-inc/supermaven-nvim',
  ft = enabled_filetypes,
}

M.opts = {
  color = { cterm = 244, suggestion_color = palette.colors.custom.steel },
  keymaps = {
    accept_suggestion = '<C-l>',
    accept_word = '<C-j>',
  },
  log_level = 'off',
}

return M
