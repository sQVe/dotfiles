-- ┏━╸┏━┓┏┓╻┏━╸┏━┓┏━┓┏┳┓
-- ┃  ┃ ┃┃┗┫┣╸ ┃ ┃┣┳┛┃┃┃
-- ┗━╸┗━┛╹ ╹╹  ┗━┛╹┗╸╹ ╹
-- Formatter.

local M = {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
}

M.opts = function()
  local formatters = require('sQVe.plugins.conform.formatters')

  return {
    formatters_by_ft = formatters.by_ft,
  }
end

M.config = function(_, opts)
  local conform = require('conform')
  local util = require('conform.util')

  local map = require('sQVe.utils.vim').map
  local formatters = require('sQVe.plugins.conform.formatters')

  formatters.override_formatting_settings()
  conform.setup(opts)

  map({ 'n', 'v' }, '<Leader><Leader>', function()
    conform.format({ async = true, lsp_fallback = true })
  end, { desc = 'Format' })

  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args)
      -- Disable formatting for temporary yazi files.
      if string.match(args.file, '^/tmp/yazi') then
        return
      end

      conform.format({ async = false, lsp_fallback = true, quiet = true })
    end,
  })
end

return M
