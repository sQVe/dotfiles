-- ┏┓ ╻ ╻┏━╸┏━┓┏━╸┏┳┓┏━┓╻ ╻┏━╸
-- ┣┻┓┃ ┃┣╸ ┣┳┛┣╸ ┃┃┃┃ ┃┃┏┛┣╸
-- ┗━┛┗━┛╹  ╹┗╸┗━╸╹ ╹┗━┛┗┛ ┗━╸
-- Delete buffers without losing window layout.

local buffer = require('sQVe.utils.buffer')

local M = {
  'echasnovski/mini.bufremove',
  config = true,
  keys = {
    {
      '<Leader>q',
      function()
        local bufnr = buffer.get_bufnr()
        local winnr = vim.api.nvim_get_current_win()

        if vim.wo[winnr].winfixbuf then
          return vim.api.nvim_win_close(winnr, true)
        end

        require('mini.bufremove').delete(bufnr)
      end,
      desc = 'Delete buffer',
    },
    {
      '<Leader>Q',
      function()
        local current_bufnr = buffer.get_bufnr()

        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if current_bufnr ~= bufnr then
            require('mini.bufremove').delete(bufnr)
          end
        end
      end,
      desc = 'Delete all buffers',
    },
  },
}

return M
