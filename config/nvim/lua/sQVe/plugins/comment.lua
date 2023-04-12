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

M.opts = {
  ignore = '^$',
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

return M
