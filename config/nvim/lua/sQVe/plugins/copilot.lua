-- ┏━╸┏━┓┏━┓╻╻  ┏━┓╺┳╸
-- ┃  ┃ ┃┣━┛┃┃  ┃ ┃ ┃
-- ┗━╸┗━┛╹  ╹┗━╸┗━┛ ╹
-- AI Copilot.

local M = {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
}

M.opts = {
  panel = { enabled = false },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = false,
      accept_word = false,
      accept_line = false,
      next = false,
      prev = false,
    },
  },
}

M.config = function(_, opts)
  local map = require('sQVe.utils.map')

  require('copilot').setup(opts)

  local suggestion = require('copilot.suggestion')

  map('i', '<C-l>', function()
    if suggestion.is_visible() then
      suggestion.accept()
    end
  end, { desc = 'Accept Copilot suggestion' })

  map('i', '<C-j>', function()
    if suggestion.is_visible() then
      suggestion.accept_word()
    end
  end, { desc = 'Accept Copilot word' })
end

return M
