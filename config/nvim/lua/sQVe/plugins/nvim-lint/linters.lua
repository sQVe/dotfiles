-- ╻  ╻┏┓╻╺┳╸┏━╸┏━┓┏━┓
-- ┃  ┃┃┗┫ ┃ ┣╸ ┣┳┛┗━┓
-- ┗━╸╹╹ ╹ ╹ ┗━╸╹┗╸┗━┛

local M = {}

M.by_ft = {
  javascript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  sh = { 'shellcheck' },
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
}

--- A custom `eslint_d` parser. The main purpose of overriding the default
--- parser is to filter out certain unwanted diagnostics.
M.custom_eslint_d_parser = function(output, bufnr)
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

M.override_linting_settings = function()
  local lint = require('lint')

  lint.linters.eslint_d.parser = M.custom_eslint_d_parser
  lint.linters_by_ft = M.by_ft
end

return M
