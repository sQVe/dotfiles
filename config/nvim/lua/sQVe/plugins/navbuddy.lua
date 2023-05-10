-- ┏┓╻┏━┓╻ ╻┏┓ ╻ ╻╺┳┓╺┳┓╻ ╻
-- ┃┗┫┣━┫┃┏┛┣┻┓┃ ┃ ┃┃ ┃┃┗┳┛
-- ╹ ╹╹ ╹┗┛ ┗━┛┗━┛╺┻┛╺┻┛ ╹
-- Buffer symbol tree via LSP.

local M = {
  'SmiteshP/nvim-navbuddy',
  -- Plugin needs to be loaded with the LSP.
  ft = require('sQVe.plugins.lspconfig').ft,
}

M.opts = function()
  local actions = require('nvim-navbuddy.actions')
  local get_symbol_map = require('sQVe.utils.lsp').get_symbol_map

  return {
    use_default_mappings = false,
    mappings = {
      ['<Enter>'] = actions.select(),
      ['<Esc>'] = actions.select(),
      ['q'] = actions.select(),

      ['j'] = actions.next_sibling(),
      ['k'] = actions.previous_sibling(),

      ['h'] = actions.parent(),
      ['l'] = actions.children(),
      ['0'] = actions.root(),

      ['J'] = actions.move_down(),
      ['K'] = actions.move_up(),

      ['<Left>'] = actions.parent(),
      ['<Right>'] = actions.children(),

      ['v'] = actions.visual_name(),
      ['V'] = actions.visual_scope(),

      ['y'] = actions.yank_name(),
      ['Y'] = actions.yank_scope(),

      ['i'] = actions.insert_name(),
      ['I'] = actions.insert_scope(),

      ['a'] = actions.append_name(),
      ['A'] = actions.append_scope(),

      ['r'] = actions.rename(),

      ['f'] = actions.telescope({
        layout_config = {
          height = 0.60,
          prompt_position = 'top',
          width = 0.60,
          flex = { flip_columns = 280 },
          vertical = { preview_height = 0.4 },
        },
        layout_strategy = 'flex',
      }),

      ['g?'] = actions.help(),
    },
    icons = get_symbol_map(true),
    lsp = { auto_attach = true },
    window = {
      border = 'rounded',
      scrolloff = tonumber(vim.opt.scrolloff),
      sections = {
        left = { size = '30%' },
        mid = { size = '40%' },
        right = { size = '30%' },
      },
    },
  }
end

M.config = function(_, opts)
  require('nvim-navbuddy').setup(opts)
end

return M
