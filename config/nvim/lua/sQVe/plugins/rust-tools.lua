-- ┏━┓╻ ╻┏━┓╺┳╸   ╺┳╸┏━┓┏━┓╻  ┏━┓
-- ┣┳┛┃ ┃┗━┓ ┃ ╺━╸ ┃ ┃ ┃┃ ┃┃  ┗━┓
-- ╹┗╸┗━┛┗━┛ ╹     ╹ ┗━┛┗━┛┗━╸┗━┛
-- Rust LSP setup and tooling.

local M = {
  'simrat39/rust-tools.nvim',
  ft = 'rust',
}

M.opts = function()
  local lsp_utils = require('sQVe.utils.lsp')
  local get_codelldb_adapter = require('rust-tools.dap').get_codelldb_adapter

  local codelldb_path = '/usr/bin/codelldb'
  local liblldb_path = '/usr/lib/liblldb.so'

  return {
    dap = { adapter = get_codelldb_adapter(codelldb_path, liblldb_path) },
    tools = { inlay_hints = { auto = false } },
    server = {
      on_attach = function(_, bufnr)
        lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })
      end,
      settings = {
        ['rust-analyzer'] = {
          cargo = { allFeatures = true },
          checkOnSave = { allFeatures = true, command = 'clippy' },
        },
      },
    },
  }
end

return M
