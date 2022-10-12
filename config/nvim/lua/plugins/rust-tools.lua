return function()
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
