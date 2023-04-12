-- ┏━╸┏━┓┏┳┓┏┳┓┏━╸┏┓╻╺┳╸
-- ┃  ┃ ┃┃┃┃┃┃┃┣╸ ┃┗┫ ┃
-- ┗━╸┗━┛╹ ╹╹ ╹┗━╸╹ ╹ ╹
-- Comment motions.

local M = {
  'numToStr/Comment.nvim',
  keys = {
    { 'gb', mode = { 'n', 'v' }, desc = 'Block comment' },
    { 'gc', mode = { 'n', 'v' }, desc = 'Comment' },
  },
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
}

-- Set opts via a function since we're running a require in it.
M.opts = function()
  return {
    ignore = '^$',
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  }
end

return M
