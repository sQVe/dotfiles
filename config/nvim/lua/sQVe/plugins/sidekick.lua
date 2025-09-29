-- ┏━┓╻╺┳┓┏━╸╻┏ ╻┏━╸╻┏
-- ┗━┓┃ ┃┃┣╸ ┣┻┓┃┃  ┣┻┓
-- ┗━┛╹╺┻┛┗━╸╹ ╹╹┗━╸╹ ╹
-- AI sidekick.

local M = {
  'folke/sidekick.nvim',
  event = 'InsertLeave',
  keys = {
    {
      '<CR>',
      function()
        if not require('sidekick').nes_jump_or_apply() then
          return '<CR>'
        end
      end,
      expr = true,
      desc = 'Goto/apply next copilot edit suggestion',
    },
  },
}

M.opts = {
  signs = {
    icon = '󱙺 ',
  },
}

return M
