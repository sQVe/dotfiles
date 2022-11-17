-- ╺┳┓┏━┓┏━╸┏━┓┏━┓╻┏┓╻┏━╸
--  ┃┃┣┳┛┣╸ ┗━┓┗━┓┃┃┗┫┃╺┓
-- ╺┻┛╹┗╸┗━╸┗━┛┗━┛╹╹ ╹┗━┛
-- Improve default interfaces.

local M = {}

M.init = function(use)
  use({
    'stevearc/dressing.nvim',
    after = 'telescope.nvim',
    config = M.config,
  })
end

M.config = function()
  require('dressing').setup({
    select = { backend = { 'telescope', 'builtin' } },
  })
end

return M
