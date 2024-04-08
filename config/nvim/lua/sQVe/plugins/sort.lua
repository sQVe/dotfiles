-- ┏━┓┏━┓┏━┓╺┳╸
-- ┗━┓┃ ┃┣┳┛ ┃
-- ┗━┛┗━┛╹┗╸ ╹
-- Sort by line and delimiter.

local M = {
  'sQVe/sort.nvim',
  cmd = 'Sort',
  keys = {
    -- Sort current line or selection.
    { 'go', '<Esc><Cmd>Sort<CR>', mode = { 'v' } },

    -- Sort motions.
    { 'go"', 'vi"<Esc><Cmd>Sort<CR>', desc = 'Sort inside "' },
    { "go'", "vi'<Esc><Cmd>Sort<CR>", desc = "Sort inside '" },
    { 'go(', 'vi(<Esc><Cmd>Sort<CR>', desc = 'Sort inside (' },
    { 'go{', 'vi{<Esc><Cmd>Sort<CR>', desc = 'Sort inside {}' },
    { 'go[', 'vi[<Esc><Cmd>Sort<CR>', desc = 'Sort inside [' },
    { 'gop', 'vip<Esc><Cmd>Sort<CR>', desc = 'Sort inside paragraph' },
  },
}

return M
