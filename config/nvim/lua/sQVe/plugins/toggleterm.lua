-- ╺┳╸┏━┓┏━╸┏━╸╻  ┏━╸╺┳╸┏━╸┏━┓┏┳┓
--  ┃ ┃ ┃┃╺┓┃╺┓┃  ┣╸  ┃ ┣╸ ┣┳┛┃┃┃
--  ╹ ┗━┛┗━┛┗━┛┗━╸┗━╸ ╹ ┗━╸╹┗╸╹ ╹
-- Manage multiple terminal windows.

local M = {
  'akinsho/toggleterm.nvim',
  cmd = 'ToggleTerm',
  keys = {
    {
      '<Leader>l',
      function()
        local Terminal = require('toggleterm.terminal').Terminal

        Terminal:new({
          cmd = 'lazygit',
          direction = 'float',
          hidden = true,
        }):toggle()
      end,
      desc = 'Open Lazygit',
    },
    { '<C-ö>', desc = 'Open toggle terminal' },
  },
}

M.opts = {
  float_opts = {
    border = 'none',
    height = function()
      return math.floor(vim.o.lines * 0.8)
    end,
    width = function()
      if vim.o.columns > 200 then
        return 200
      end

      return math.floor(vim.o.columns * 0.8)
    end,
  },
  highlights = {
    NormalFloat = { guibg = '#303030' },
  },
  open_mapping = [[<C-ö>]],
  shading_factor = 20,
  size = 25,
}

return M
