-- ╺┳┓┏━┓┏━┓╻ ╻╻
--  ┃┃┣━┫┣━┛┃ ┃┃
-- ╺┻┛╹ ╹╹  ┗━┛╹
-- Debug Adapter Protocol UI.

local M = {
  'rcarriga/nvim-dap-ui',
  ft = { 'rust' },
}

M.opts = {
  layouts = {
    {
      elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
      size = 40,
      position = 'left',
    },
    {
      elements = { 'repl', 'console' },
      size = 10,
      position = 'bottom',
    },
  },
}

M.config = function(_, opts)
  local dap = require('dap')
  local dap_ui = require('dapui')

  dap_ui.setup(opts)

  dap.listeners.after.event_initialized['dapui_config'] = function()
    dap_ui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dap_ui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dap_ui.close()
  end
end

return M
