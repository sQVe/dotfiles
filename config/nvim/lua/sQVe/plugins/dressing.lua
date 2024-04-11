-- ╺┳┓┏━┓┏━╸┏━┓┏━┓╻┏┓╻┏━╸
--  ┃┃┣┳┛┣╸ ┗━┓┗━┓┃┃┗┫┃╺┓
-- ╺┻┛╹┗╸┗━╸┗━┛┗━┛╹╹ ╹┗━┛
-- Improve default UI elements for input and select.

local M = {
  'stevearc/dressing.nvim',
  lazy = true,
}

M.init = function()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(...)
    require('lazy').load({ plugins = { 'dressing.nvim' } })
    return vim.ui.select(...)
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(...)
    require('lazy').load({ plugins = { 'dressing.nvim' } })
    return vim.ui.input(...)
  end
end

M.opts = {
  input = {
    win_options = {
      winhighlight = 'NormalFloat:InputNormat,FloatBorder:InputBorder,FloatTitle:InputTitle',
    },
  },
  select = {
    backend = { 'telescope' },
    telescope = {
      attach_mappings = function(_, map)
        -- Disable certain keymaps that breaks the select.
        map('i', '<C-v>', function() end)
        map('i', '<C-s>', function() end)

        return true
      end,
      layout_strategy = 'horizontal',
      layout_config = {
        preview_cutoff = false,
        width = function(_, max_columns, _)
          return math.min(max_columns, 80)
        end,
        height = function(_, _, max_lines)
          return math.min(max_lines, 25)
        end,
      },
    },
  },
}

return M
