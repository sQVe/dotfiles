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

  vim.api.nvim_create_autocmd('User', {
    pattern = 'BlinkCmpMenuOpen',
    callback = function()
      vim.b.copilot_suggestion_hidden = true
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'BlinkCmpMenuClose',
    callback = function()
      vim.b.copilot_suggestion_hidden = false
    end,
  })

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
