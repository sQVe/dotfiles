-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local M = {
  'mfussenegger/nvim-lint',
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
    lua = { 'luacheck' },
    sh = { 'shellcheck' },
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
  },
}

M.config = function(_, opts)
  local autocmd = require('sQVe.utils.vim').autocmd
  local augroup = require('sQVe.utils.vim').augroup
  local debounce = require('sQVe.utils.vim').debounce

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

  autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = augroup('Lint'),
    callback = debounce(200, try_lint),
  })
end

return M
