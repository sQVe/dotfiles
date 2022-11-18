-- ╺┳┓┏━┓┏━┓
--  ┃┃┣━┫┣━┛
-- ╺┻┛╹ ╹╹
-- Setup Debug Adapter Protocol.

local M = {}

M.init = function(use)
  use({
    'mfussenegger/nvim-dap',
    ft = {
      'go',
      'rust',
    },
    config = M.configs.dap,
  })
  use({
    'nvim-telescope/telescope-dap.nvim',
    module = 'telescope._extensions.dap',
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
    local map = require('sQVe.utils.vim').map
    local telescope = require('telescope')

    local codelldb_path = '/usr/bin/codelldb'
    local liblldb_path = '/usr/lib/liblldb.so'

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      host = '127.0.0.1',
      executable = {
        command = codelldb_path,
        args = { '--liblldb', liblldb_path, '--port', '${port}' },
      },
    }

    dap.configurations.rust = {
      {
        type = 'codelldb',
        name = 'Debug executable',
        request = 'launch',
        program = function()
          local cwd = vim.fn.getcwd()
          local current_directory = vim.fn.fnamemodify(cwd, ':t')
          local debug_path = cwd .. '/target/debug/' .. current_directory

          return vim.fn.input('Path to binary: ', debug_path, 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    vim.fn.sign_define(
      'DapBreakpoint',
      { text = '', texthl = 'GruvboxRedSign' }
    )
    vim.fn.sign_define(
      'DapBreakpointCondition',
      { text = '', texthl = 'GruvboxYellowSign' }
    )
    vim.fn.sign_define(
      'DapStopped',
      { text = '', texthl = 'GruvboxGreenSign' }
    )

    telescope.load_extension('dap')
    map('n', '<Leader>i', telescope.extensions.dap.commands)
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
