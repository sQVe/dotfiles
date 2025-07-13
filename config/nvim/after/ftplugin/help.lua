-- ╻ ╻┏━╸╻  ┏━┓
-- ┣━┫┣╸ ┃  ┣━┛
-- ╹ ╹┗━╸┗━╸╹
-- Help specific settings.

local autocmd = require('sQVe.utils.autocmd')

-- Ensure that help windows are split vertically.
autocmd({ 'BufWinEnter' }, {
  group = 'HelpWindowLayout',
  callback = function()
    if vim.bo.filetype == 'help' then
      local window_width = vim.fn.winwidth(0)

      if window_width > 160 then
        vim.cmd.wincmd('L')
      end
    end
  end,
})
