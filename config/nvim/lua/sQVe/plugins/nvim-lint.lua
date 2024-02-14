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
    sh = { 'shellcheck' },
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
  },
}

--- A custom `eslint_d` parser. The main purpose of overriding the default
--- parser is to filter out certain unwanted diagnostics.
local custom_eslint_d_parser = function(output, bufnr)
  local result = require('lint.linters.eslint').parser(output, bufnr)
  local ignored_messages = {
    'output: Error: No ESLint configuration found',
    'output: No ESLint found',
  }

  result = vim.tbl_filter(function(diagnostic)
    for _, ignored_message in ipairs(ignored_messages) do
      if string.find(diagnostic.message, ignored_message) then
        return false
      end
    end

    return true
  end, result)

  for _, diagnostic in ipairs(result) do
    diagnostic.source = 'eslint_d'
  end

  return result
end

M.config = function(_, opts)
  local autocmd = require('sQVe.utils.vim').autocmd
  local augroup = require('sQVe.utils.vim').augroup
  local debounce = require('sQVe.utils.vim').debounce
  local lsp_utils = require('sQVe.utils.lsp')

  local lint = require('lint')
  lint.linters.eslint_d.parser = custom_eslint_d_parser
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
