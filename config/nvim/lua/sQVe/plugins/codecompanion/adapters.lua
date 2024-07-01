-- ┏━┓╺┳┓┏━┓┏━┓╺┳╸┏━╸┏━┓┏━┓
-- ┣━┫ ┃┃┣━┫┣━┛ ┃ ┣╸ ┣┳┛┗━┓
-- ╹ ╹╺┻┛╹ ╹╹   ╹ ┗━╸╹┗╸┗━┛

local M = {}

M.openai = function()
  local adapters = require('codecompanion.adapters')

  return adapters.use('openai', {
    schema = {
      temperature = { default = 0.6 },
      top_p = { default = 0.4 },
    },
  })
end

return M
