local M = {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  keys = {
    {
      '<Leader>dl',
      function()
        require('lsp_lines').toggle()
      end,
      desc = 'Toggle diagnostic virtual lines',
    },
  },
}

M.config = function()
  require('lsp_lines').setup()

  -- Disable virtual lines by default.
  vim.diagnostic.config({ virtual_lines = false })
end

return M
