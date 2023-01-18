-- ┏━┓┏━┓┏━┓╺┳╸
-- ┗━┓┃ ┃┣┳┛ ┃
-- ┗━┛┗━┛╹┗╸ ╹
-- Sort by line and delimiter.

local M = {
  'sQVe/sort.nvim',
  cmd = 'Sort',
  keys = {
    -- Sort current line or selection.
    { 'go', '<Cmd>Sort<CR>' },
    { 'go', '<Esc><Cmd>Sort<CR>', mode = { 'v' } },

    -- Sort motions.
    { 'go"', 'vi"<Esc><Cmd>Sort<CR>' },
    { 'go\'', 'vi\'<Esc><Cmd>Sort<CR>' },
    { 'go(', 'vi(<Esc><Cmd>Sort<CR>' },
    { 'go{', 'vi{<Esc><Cmd>Sort<CR>' },
    { 'go[', 'vi[<Esc><Cmd>Sort<CR>' },
    { 'gop', 'vip<Esc><Cmd>Sort<CR>' },
  },
}

return M
