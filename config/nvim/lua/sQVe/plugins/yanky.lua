-- ╻ ╻┏━┓┏┓╻╻┏ ╻ ╻
-- ┗┳┛┣━┫┃┗┫┣┻┓┗┳┛
--  ╹ ╹ ╹╹ ╹╹ ╹ ╹
-- Better yanking.

local M = {
  'gbprod/yanky.nvim',
  event = 'VeryLazy',
  keys = {
    keys = {
      {
        'p',
        '<Plug>(YankyPutAfter)',
        mode = { 'n', 'x' },
        desc = 'Put yanked text after cursor',
      },
      {
        'P',
        '<Plug>(YankyPutBefore)',
        mode = { 'n', 'x' },
        desc = 'Put yanked text before cursor',
      },
      {
        '=p',
        '<Plug>(YankyPutAfterLinewise)',
        desc = 'Put yanked text in line below',
      },
      {
        '=P',
        '<Plug>(YankyPutBeforeLinewise)',
        desc = 'Put yanked text in line above',
      },
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yanky yank' },
    },
  },
}

M.opts = {
  highlight = { timer = 200 },
  system_clipboard = {
    sync_with_ring = false,
  },
}

return M
