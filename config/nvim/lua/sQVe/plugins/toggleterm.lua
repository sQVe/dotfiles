-- ╺┳╸┏━┓┏━╸┏━╸╻  ┏━╸╺┳╸┏━╸┏━┓┏┳┓
--  ┃ ┃ ┃┃╺┓┃╺┓┃  ┣╸  ┃ ┣╸ ┣┳┛┃┃┃
--  ╹ ┗━┛┗━┛┗━┛┗━╸┗━╸ ╹ ┗━╸╹┗╸╹ ╹
-- Manage multiple terminal windows.

local M = {
  'akinsho/toggleterm.nvim',
  cmd = 'ToggleTerm',
  keys = {
    {
      '<Leader>g',
      function()
        local Terminal = require('toggleterm.terminal').Terminal

        Terminal:new({
          cmd = 'lazygit',
          direction = 'float',
          hidden = true,
          on_exit = function(_, _, exit_code)
            if exit_code > 0 then
              vim.notify('No git directory found', vim.log.levels.WARN)
            end
          end,
        }):toggle()
      end,
      desc = 'Open Lazygit',
    },
    { '<C-ö>', desc = 'Open toggle terminal' },
  },
}

M.opts = {
  direction = 'float',
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
