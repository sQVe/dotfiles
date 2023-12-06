-- ┏┓ ╻ ╻┏━╸┏━┓┏━╸┏┳┓┏━┓╻ ╻┏━╸
-- ┣┻┓┃ ┃┣╸ ┣┳┛┣╸ ┃┃┃┃ ┃┃┏┛┣╸
-- ┗━┛┗━┛╹  ╹┗╸┗━╸╹ ╹┗━┛┗┛ ┗━╸
-- Delete buffers without losing window layout.

local M = {
  'echasnovski/mini.bufremove',
  config = true,
  keys = {
    {
      '<Leader>q',
      function()
        local bufnr = vim.api.nvim_get_current_buf()

        require('mini.bufremove').delete(bufnr)
      end,
      desc = 'Delete buffer',
    },
    {
      '<Leader>Q',
      function()
        local bufnr = vim.api.nvim_get_current_buf()

        require('mini.bufremove').wipeout(bufnr)
      end,
      desc = 'Wipeout buffer',
    },
  },
}

return M
