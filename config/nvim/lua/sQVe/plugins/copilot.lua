-- ┏━╸┏━┓┏━┓╻╻  ┏━┓╺┳╸
-- ┃  ┃ ┃┣━┛┃┃  ┃ ┃ ┃
-- ┗━╸┗━┛╹  ╹┗━╸┗━┛ ╹
-- AI Copilot.

local M = {
  'github/copilot.vim',
}

M.config = function()
  vim.g.copilot_no_tab_map = true
  vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
  })
  vim.keymap.set('i', '<C-j>', '<Plug>(copilot-accept-word)')
end

return M
