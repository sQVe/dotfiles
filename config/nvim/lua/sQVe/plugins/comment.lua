-- ┏━╸┏━┓┏┳┓┏┳┓┏━╸┏┓╻╺┳╸
-- ┃  ┃ ┃┃┃┃┃┃┃┣╸ ┃┗┫ ┃
-- ┗━╸┗━┛╹ ╹╹ ╹┗━╸╹ ╹ ╹
-- Comment motions.

local M = {}

M.init = function(use)
  use({
    'numToStr/Comment.nvim',
    config = M.config,
    keys = {
      { 'n', 'gb' },
      { 'n', 'gc' },
      { 'v', 'gb' },
      { 'v', 'gc' },
    },
    requires = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        module = 'ts_context_commentstring',
      },
    },
  })
end

M.config = function()
  require('Comment').setup({
    ignore = '^$',
    pre_hook = function(ctx)
      local utils = require('Comment.utils')

      local type = ctx.ctype == utils.ctype.linewise and '__default'
        or '__multiline'

      local location = nil
      if ctx.ctype == utils.ctype.block then
        location =
          require('ts_context_commentstring.utils').get_cursor_location()
      elseif
        ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V
      then
        location =
          require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
        key = type,
        location = location,
      })
    end,
  })
end

return M
