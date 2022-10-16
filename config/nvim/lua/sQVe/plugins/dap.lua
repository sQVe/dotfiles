-- ╺┳┓┏━┓┏━┓
--  ┃┃┣━┫┣━┛
-- ╺┻┛╹ ╹╹
-- Setup Debug Adapter Protocol.

local M = {}

M.init = function(use)
  use({
    'mfussenegger/nvim-dap',
    after = 'rust-tools.nvim',
    cmd = {
      'DapSetLogLevel',
      'DapShowLog',
      'DapContinue',
      'DapToggleBreakpoint',
      'DapToggleRepl',
      'DapStepOver',
      'DapStepInto',
      'DapStepOut',
      'DapTerminate',
      'DapLoadLaunchJSON',
      'DapRestartFrame',
      'RustDebuggables',
    },
    config = M.configs.dap,
    requires = { 'rust-tools.nvim' },
  })
  use({ 'rcarriga/nvim-dap-ui', after = 'nvim-dap', config = M.configs.dap_ui })
  use({ 'leoluz/nvim-dap-go', after = 'nvim-dap', config = M.configs.dap_go })
  use({
    'theHamsta/nvim-dap-virtual-text',
    after = 'nvim-dap',
    config = M.configs.dap_virtual_text,
  })
end

M.configs = {
  dap = function()
    local dap = require('dap')
    local get_codelldb_adapter = require('rust-tools.dap').get_codelldb_adapter

    local codelldb_path = '/usr/bin/codelldb'
    local liblldb_path = '/usr/lib/liblldb.so'

    dap.adapters.codelldb = get_codelldb_adapter(codelldb_path, liblldb_path)

    dap.configurations.rust = {
      {
        type = 'codelldb',
        name = 'Debug executable',
        request = 'launch',
        program = function()
          return vim.fn.input(
            'Path to executable: ',
            vim.fn.getcwd() .. '/target/debug/',
            'file'
          )
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
  dap_go = function()
    require('dap-go').setup()
  end,
  dap_ui = function()
    local dap = require('dap')
    local dap_ui = require('dapui')

    dap_ui.setup({
      layouts = {
        {
          elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
          size = 40,
          position = 'left',
        },
        { elements = { 'repl', 'console' }, size = 10, position = 'bottom' },
      },
    })

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dap_ui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dap_ui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dap_ui.close()
    end
  end,
  dap_virtual_text = function()
    require('nvim-dap-virtual-text').setup({
      enabled_commands = false,
    })
  end,
}

return M
