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

  local on_attach = function(_, bufnr)
    lsp_utils.map_lsp_buffer_keys(bufnr, { 'diagnostics', 'lookup' })
  end

  local server_setup = lsp_utils.create_server_setup({
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        checkOnSave = { allFeatures = true, command = 'clippy' },
      },
    },
  })

  return {
    dap = { adapter = get_codelldb_adapter(codelldb_path, liblldb_path) },
    tools = { inlay_hints = { auto = false } },
    server = server_setup,
  }
end

return M
