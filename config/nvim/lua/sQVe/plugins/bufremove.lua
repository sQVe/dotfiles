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
        local winnr = vim.api.nvim_get_current_win()

        if vim.api.nvim_get_option_value('winfixbuf', { win = winnr }) then
          return vim.api.nvim_win_close(winnr, true)
        end

        require('mini.bufremove').delete(bufnr)
      end,
      desc = 'Delete buffer',
    },
    {
      '<Leader>Q',
      function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_get_current_buf() ~= bufnr then
            require('mini.bufremove').delete(bufnr)
          end
        end
      end,
      desc = 'Delete all buffers',
    },
  },
}

return M
