-- ╻ ╻╻
-- ┃ ┃┃
-- ┗━┛╹

local M = {}

M.override = function()
  local ui = require('codecompanion.utils.ui')

  ui.selector = M.selector
end

M.selector = function(items, opts)
  local select_opts = {
    prompt = 'Assistant',
    kind = 'codecompanion.nvim',
    format_item = function(item)
      return item.name
    end,
  }

  vim.ui.select(items, select_opts, function(selected)
    if not selected then
      return
    end

    return opts.callback(selected)
  end)
end

return M
