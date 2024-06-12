-- ┏━╸┏━┓╺┳┓┏━╸┏━╸┏━┓┏┳┓┏━┓┏━┓┏┓╻╻┏━┓┏┓╻
-- ┃  ┃ ┃ ┃┃┣╸ ┃  ┃ ┃┃┃┃┣━┛┣━┫┃┗┫┃┃ ┃┃┗┫
-- ┗━╸┗━┛╺┻┛┗━╸┗━╸┗━┛╹ ╹╹  ╹ ╹╹ ╹╹┗━┛╹ ╹
-- Interact with LLMs.

local actions = require('sQVe.plugins.codecompanion.actions')
local adapters = require('sQVe.plugins.codecompanion.adapters')
local ui = require('sQVe.plugins.codecompanion.ui')

local M = {
  'olimorris/codecompanion.nvim',
  keys = {
    {
      'Å',
      mode = { 'n', 'v' },
      function()
        vim.cmd('CodeCompanionActions')
      end,
      desc = 'Run code companion',
    },
  },
}

M.opts = function()
  -- require('codecompanion.actions').static.actions = vim.tbl_map(function(fn)
  --   return fn()
  -- end, actions)

  return {
    adapters = {
      openai = adapters.openai(),
    },
    display = {
      action_palette = {
        width = 80,
        height = 15,
        relative = 'editor',
      },
      chat = { layout = 'buffer' },
    },
    tools = {
      ['code_runner'] = { enabled = false },
    },
  }
end

M.config = function(_, opts)
  ui.override()

  require('codecompanion').setup(opts)
end

return M
