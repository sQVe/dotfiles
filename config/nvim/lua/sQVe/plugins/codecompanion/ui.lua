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
    format_item = function(item)
      return item.name
    end,
    kind = 'codecompanion.nvim',
    prompt = 'Assistant',
  }

  vim.ui.select(items, select_opts, function(selected)
    if not selected then
      return
    end

    return opts.callback(selected)
  end)
end

return M
