-- ┏━╸┏━┓┏━┓┏━┓┏━┓╻  ┏━╸
-- ┃╺┓┣┳┛┣━┫┣━┛┣━┛┃  ┣╸
-- ┗━┛╹┗╸╹ ╹╹  ╹  ┗━╸┗━╸
-- Bookmark files to quickly navigate between them.

local M = {
  'cbochs/grapple.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<Leader>g', '<Cmd>Grapple toggle<CR>', desc = 'Grapple toggle tag' },
    {
      '<Backspace>',
      '<Cmd>Grapple toggle_tags<CR>',
      desc = 'Grapple toggle tags',
    },
    {
      '<Tab>',
      '<Cmd>Grapple cycle forward<CR>',
      desc = 'Grapple cycle forward',
    },
    {
      '<S-Tab>',
      '<Cmd>Grapple cycle backward<CR>',
      desc = 'Grapple cycle backward',
    },
    {
      '<Leader>1',
      '<Cmd>Grapple select index=1<CR>',
      desc = 'Grapple select 1',
    },
    {
      '<Leader>2',
      '<Cmd>Grapple select index=2<CR>',
      desc = 'Grapple select 2',
    },
    {
      '<Leader>3',
      '<Cmd>Grapple select index=3<CR>',
      desc = 'Grapple select 3',
    },
    {
      '<Leader>4',
      '<Cmd>Grapple select index=4<CR>',
      desc = 'Grapple select 4',
    },
  },
}

M.opts = {
  scope = 'git_branch',
  quick_select = '1234567890',
}

return M
