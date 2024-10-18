-- ┏━╸╻ ╻┏━┓╻┏┓╻┏━┓┏━┓╻ ╻
-- ┃  ┣━┫┣━┫┃┃┗┫┗━┓┣━┫┃╻┃
-- ┗━╸╹ ╹╹ ╹╹╹ ╹┗━┛╹ ╹┗┻┛
-- Smooth debug logging.

local M = {
  'chrisgrieser/nvim-chainsaw',
  event = 'VeryLazy',
  keys = {
    {
      'gp',
      function()
        local word = vim.fn.expand('<cword>')
        local filetype = vim.bo.filetype

        if word ~= '' or filetype == 'css' then
          require('chainsaw').variableLog()
        else
          require('chainsaw').messageLog()
        end
      end,
      mode = { 'n' },
      desc = 'Message debug log',
    },
    {
      'gp',
      function()
        require('chainsaw').variableLog()
      end,
      mode = { 'v' },
      desc = 'Message debug log',
    },
  },
}

M.opts = {
  logHighlightGroup = 'ChainsawLog',
  logStatements = {
    variableLog = {
      nvim_lua = 'print("%s %s: " .. vim.inspect(%s))',
    },
    messageLog = {
      lua = 'print("%s ")',
    },
  },
  marker = '💩',
}

return M
