-- ╺┳╸┏━┓┏━╸┏━╸┏━┓╻╺┳╸╺┳╸┏━╸┏━┓   ┏━╸┏━┓┏┓╻╺┳╸┏━╸╻ ╻╺┳╸
--  ┃ ┣┳┛┣╸ ┣╸ ┗━┓┃ ┃  ┃ ┣╸ ┣┳┛   ┃  ┃ ┃┃┗┫ ┃ ┣╸ ┏╋┛ ┃
--  ╹ ╹┗╸┗━╸┗━╸┗━┛╹ ╹  ╹ ┗━╸╹┗╸   ┗━╸┗━┛╹ ╹ ╹ ┗━╸╹ ╹ ╹
-- Context when scrolling through code.

local M = {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufReadPost',
}

M.opts = { mode = 'cursor' }

return M
