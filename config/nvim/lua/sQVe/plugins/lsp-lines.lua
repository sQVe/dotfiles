local M = {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  ft = require('sQVe.plugins.lspconfig').ft,
}

M.config = function()
  require('lsp_lines').setup()

  vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
end

return M
