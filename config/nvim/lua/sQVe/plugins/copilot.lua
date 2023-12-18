-- ┏━╸┏━┓┏━┓╻╻  ┏━┓╺┳╸
-- ┃  ┃ ┃┣━┛┃┃  ┃ ┃ ┃
-- ┗━╸┗━┛╹  ╹┗━╸┗━┛ ╹
-- GitHub Copilot support.

local M = {
  'zbirenbaum/copilot.lua',
  build = ':Copilot auth',
  cmd = 'Copilot',
  event = 'InsertEnter',
}

M.opts = {
  panel = { enabled = false },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = { accept = '<C-l>' },
  },
}

return M
