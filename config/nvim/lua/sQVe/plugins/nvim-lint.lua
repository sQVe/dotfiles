-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local M = {
  'mfussenegger/nvim-lint',
  dev = true,
  ft = {
    -- eslint_d.
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',

    -- shellcheck.
    'sh',
  },
}

M.opts = {
  linters_by_ft = {
    javascript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    sh = { 'shellcheck' },
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
  },
}

M.config = function(_, opts)
  local autocmd = require('sQVe.utils.vim').autocmd
  local augroup = require('sQVe.utils.vim').augroup
  local debounce = require('sQVe.utils.vim').debounce
  local lsp_utils = require('sQVe.utils.lsp')

  local lint = require('lint')
  lint.linters_by_ft = opts.linters_by_ft

  local try_lint = function()
    local names = lint.linters_by_ft[vim.bo.filetype] or {}
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }

    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
    names = vim.tbl_filter(function(name)
      local linter = lint.linters[name]

      return linter
        and not (
          type(linter) == 'table'
          and linter.condition
          and not linter.condition(ctx)
        )
    end, names)

    if #names > 0 then
      lint.try_lint(names)
    end
  end

  lsp_utils.map_lsp_buffer_keys(0, { 'diagnostics' })
  autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = augroup('Lint'),
    callback = debounce(200, try_lint),
  })
end

return M
