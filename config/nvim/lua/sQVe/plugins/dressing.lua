-- ╺┳┓┏━┓┏━╸┏━┓┏━┓╻┏┓╻┏━╸
--  ┃┃┣┳┛┣╸ ┗━┓┗━┓┃┃┗┫┃╺┓
-- ╺┻┛╹┗╸┗━╸┗━┛┗━┛╹╹ ╹┗━┛
-- Improve default interfaces.

local M = {}

M.init = function(use)
  use({
    'stevearc/dressing.nvim',
    config = M.config,
    event = 'BufEnter',
  })
end

M.config = function()
  require('dressing').setup({
    select = { backend = { 'telescope', 'builtin' } },
  })
end

return M
