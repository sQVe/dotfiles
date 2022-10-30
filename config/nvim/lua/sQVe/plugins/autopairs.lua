-- ┏━┓╻ ╻╺┳╸┏━┓┏━┓┏━┓╻┏━┓┏━┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┣━┛┣━┫┃┣┳┛┗━┓
-- ╹ ╹┗━┛ ╹ ┗━┛╹  ╹ ╹╹╹┗╸┗━┛
-- Complete pairs.

local M = {}

M.init = function(use)
  use({
    'windwp/nvim-autopairs',
    config = M.config,
    event = { 'InsertEnter' },
  })
end

M.config = function()
  require('nvim-autopairs').setup({
    check_ts = true,
    ts_config = {
      lua = { 'string' },
      javascript = { 'template_string' },
    },
  })
end

return M
