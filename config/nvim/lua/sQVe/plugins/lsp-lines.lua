local M = {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  ft = require('sQVe.plugins.lspconfig').ft,
}

M.config = function()
  require('lsp_lines').setup()

  -- Disable virtual lines by default.
  vim.diagnostic.config({ virtual_lines = false })
end

return M
