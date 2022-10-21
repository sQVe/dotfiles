-- ┏━┓╻ ╻┏━┓╺┳╸   ╺┳╸┏━┓┏━┓╻  ┏━┓
-- ┣┳┛┃ ┃┗━┓ ┃ ╺━╸ ┃ ┃ ┃┃ ┃┃  ┗━┓
-- ╹┗╸┗━┛┗━┛ ╹     ╹ ┗━┛┗━┛┗━╸┗━┛
-- Rust LSP setup and tooling.

local M = {}

M.init = function(use)
  use({
    'simrat39/rust-tools.nvim',
    after = 'nvim-lspconfig',
    config = M.config,
    ft = 'rust',
  })
end

M.config = function()
  local lsp_utils = require('sQVe.utils.lsp')
  local rust_tools = require('rust-tools')
  local get_codelldb_adapter = require('rust-tools.dap').get_codelldb_adapter

  local codelldb_path = '/usr/bin/codelldb'
  local liblldb_path = '/usr/lib/liblldb.so'

  rust_tools.setup({
    dap = {
      adapter = get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    tools = { inlay_hints = { auto = false } },
    server = {
      on_attach = function(_, bufnr)
        lsp_utils.map_lsp_buffer_keys(bufnr)
      end,
      settings = {
        ['rust-analyzer'] = {
          cargo = { allFeatures = true },
          checkOnSave = { allFeatures = true, command = 'clippy' },
        },
      },
    },
  })
end

return M
