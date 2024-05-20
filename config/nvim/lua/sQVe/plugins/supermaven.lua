-- ┏━┓╻ ╻┏━┓┏━╸┏━┓┏┳┓┏━┓╻ ╻┏━╸┏┓╻
-- ┗━┓┃ ┃┣━┛┣╸ ┣┳┛┃┃┃┣━┫┃┏┛┣╸ ┃┗┫
-- ┗━┛┗━┛╹  ┗━╸╹┗╸╹ ╹╹ ╹┗┛ ┗━╸╹ ╹
-- AI Copilot.

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
  disable_keymaps = true,
}

return M
