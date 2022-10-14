-- ┏━┓┏━┓┏━┓╺┳╸
-- ┗━┓┃ ┃┣┳┛ ┃
-- ┗━┛┗━┛╹┗╸ ╹
-- Sort by line and delimiter.

local M = {}

M.init = function(use)
  use({
    'sQVe/sort.nvim',
    cmd = { 'Sort' },
    config = M.config,
    keys = {
      { 'n', 'go' },
      { 'v', 'go' },
    },
  })
end

M.config = function()
  local map = require('sQVe.utils.keymap').map

  -- Sort current line or selection.
  map('n', 'go', '<Cmd>Sort<CR>')
  map('v', 'go', '<Esc><Cmd>Sort<CR>')

  -- Sort motions.
  map('n', 'go"', 'vi"<Esc><Cmd>Sort<CR>')
  map('n', 'go\'', 'vi\'<Esc><Cmd>Sort<CR>')
  map('n', 'go(', 'vi(<Esc><Cmd>Sort<CR>')
  map('n', 'go{', 'vi{<Esc><Cmd>Sort<CR>')
  map('n', 'go[', 'vi[<Esc><Cmd>Sort<CR>')
  map('n', 'gop', 'vip<Esc><Cmd>Sort<CR>')
end

return M
