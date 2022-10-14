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
  })
end

M.config = function()
  local rust_tools = require('rust-tools')

  rust_tools.setup({
    tools = {
      inlay_hints = { auto = false },
    },
    server = {
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
