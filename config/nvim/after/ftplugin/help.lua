-- ╻ ╻┏━╸╻  ┏━┓
-- ┣━┫┣╸ ┃  ┣━┛
-- ╹ ╹┗━╸┗━╸╹
-- Help specific settings.

local autocmd = require('sQVe.utils.autocmd')

-- Ensure that help windows are split vertically.
autocmd({ 'BufWinEnter' }, {
  group = 'EnableSpellCheckingForNotes',
  callback = function()
    vim.cmd.wincmd('L')
  end,
})
