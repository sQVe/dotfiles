-- ╺┳┓┏━┓┏━┓
--  ┃┃┣━┫┣━┛
-- ╺┻┛╹ ╹╹
-- Setup Debug Adapter Protocol.

local M = {
  'mfussenegger/nvim-dap',
  ft = {
    'go',
    'rust',
  },
  dependencies = {
    'nvim-telescope/telescope-dap.nvim',
    { 'leoluz/nvim-dap-go', config = true },
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = { enabled_commands = false },
    },
  },
}

M.config = function()
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
        local debug_path =
          string.format('%s/target/debug/%s', cwd, current_directory)

        return vim.fn.input(
          string.format('Path to binary: %s file', debug_path)
        )
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
  map(
    'n',
    '<Leader>i',
    telescope.extensions.dap.commands,
    { desc = 'List DAP commands' }
  )
end

return M
