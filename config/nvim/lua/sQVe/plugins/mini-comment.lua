-- ┏┳┓╻┏┓╻╻   ┏━╸┏━┓┏┳┓┏┳┓┏━╸┏┓╻╺┳╸
-- ┃┃┃┃┃┗┫┃   ┃  ┃ ┃┃┃┃┃┃┃┣╸ ┃┗┫ ┃
-- ╹ ╹╹╹ ╹╹   ┗━╸┗━┛╹ ╹╹ ╹┗━╸╹ ╹ ╹
-- Comment lines.

local M = {
  'echasnovski/mini.comment',
  keys = {
    { 'gc', mode = { 'n', 'v' }, desc = 'Comment' },
    { 'gcc', mode = { 'n', 'v' }, desc = 'Comment' },
  },
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
}

M.opts = {
  options = {
    custom_commentstring = function()
      return require('ts_context_commentstring.internal').calculate_commentstring()
        or vim.bo.commentstring
    end,
  },
}

return M
