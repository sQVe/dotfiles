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
    {
      '<C-g><C-p>',
      function()
        local line = vim.fn.getline('.')
        local is_whitespace_only = line:match('^%s*$') ~= nil

        require('chainsaw').messageLog()

        if is_whitespace_only then
          print('Deleting line')
          vim.cmd('norm k')
          vim.cmd('norm! "_dd')
        end
      end,
      mode = { 'i' },
      desc = 'Message debug log',
    },
  },
}

M.opts = {
  visuals = {
    lineHlgroup = 'ChainsawLog',
    icon = '',
  },
  logStatements = {
    variableLog = {
      nvim_lua = 'print("{{marker}} {{var}}: " .. vim.inspect({{var}}))',
    },
    messageLog = {
      lua = 'print("{{marker}} ")',
    },
  },
  marker = '💩',
}

return M
