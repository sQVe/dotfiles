-- ┏━╸┏━┓┏┓╻┏━╸┏━┓┏━┓┏┳┓
-- ┃  ┃ ┃┃┗┫┣╸ ┃ ┃┣┳┛┃┃┃
-- ┗━╸┗━┛╹ ╹╹  ┗━┛╹┗╸╹ ╹
-- Formatter.

local autocmd = require('sQVe.utils.autocmd')

local formatters = require('sQVe.plugins.conform.formatters')

local M = {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
}

M.init = function()
  vim.g.format_on_save = true
end

M.opts = {
  formatters_by_ft = formatters.by_ft,
}

M.config = function(_, opts)
  local conform = require('conform')

  formatters.override_formatting_settings()
  conform.setup(opts)

  autocmd('BufWritePre', {
    group = 'FormatOnSave',
    pattern = '*',
    callback = function(args)
      if
        not vim.g.format_on_save
        or string.match(args.file, '^/tmp/yazi') -- Do not format yazi files.
      then
        return
      end

      conform.format({ async = false, lsp_fallback = true, quiet = true })
    end,
  })
end

return M
