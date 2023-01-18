-- ┏━┓╻ ╻╺┳╸┏━┓┏━┓┏━┓╻┏━┓┏━┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┣━┛┣━┫┃┣┳┛┗━┓
-- ╹ ╹┗━┛ ╹ ┗━┛╹  ╹ ╹╹╹┗╸┗━┛
-- Complete pairs.

local M = {
  'windwp/nvim-autopairs',
  event = { 'InsertEnter' },
}

M.opts = {
  check_ts = true,
  ts_config = {
    javascript = { 'template_string' },
    lua = { 'string' },
  },
}

return M
