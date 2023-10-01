-- ╻  ╻┏┓╻╺┳╸
-- ┃  ┃┃┗┫ ┃
-- ┗━╸╹╹ ╹ ╹
-- Linter.

local uv = vim.uv or vim.loop

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

M.config = function(_, opts)
  local autocmd = require('sQVe.utils.vim').autocmd
  local augroup = require('sQVe.utils.vim').augroup
  local lint = require('lint')

  lint.linters_by_ft = opts.linters_by_ft

  local debounce_ms = 500
  local timer = assert(uv.new_timer())

  autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
    group = augroup('Lint'),
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()

      timer:stop()
      timer:start(
        debounce_ms,
        0,
        vim.schedule_wrap(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.api.nvim_buf_call(bufnr, function()
              lint.try_lint(nil, { ignore_errors = true })
            end)
          end
        end)
      )
    end,
  })
end

return M
