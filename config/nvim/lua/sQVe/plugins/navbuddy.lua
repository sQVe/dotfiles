-- ┏┓╻┏━┓╻ ╻┏┓ ╻ ╻╺┳┓╺┳┓╻ ╻
-- ┃┗┫┣━┫┃┏┛┣┻┓┃ ┃ ┃┃ ┃┃┗┳┛
-- ╹ ╹╹ ╹┗┛ ┗━┛┗━┛╺┻┛╺┻┛ ╹
-- Buffer symbol tree via LSP.

local M = {
  'SmiteshP/nvim-navbuddy',
  ft = require('sQVe.plugins.lspconfig').ft,
}

M.opts = function()
  local actions = require('nvim-navbuddy.actions')

  return {
    use_default_mappings = false,
    mappings = {
      ['<Enter>'] = actions.select,
      ['<Esc>'] = actions.select,
      ['q'] = actions.select,

      ['j'] = actions.next_sibling,
      ['k'] = actions.previous_sibling,

      ['h'] = actions.parent,
      ['l'] = actions.children,

      ['<Left>'] = actions.parent,
      ['<Right>'] = actions.children,

      ['v'] = actions.visual_name,
      ['V'] = actions.visual_scope,

      ['y'] = actions.yank_name,
      ['Y'] = actions.yank_scope,

      ['i'] = actions.insert_name,
      ['I'] = actions.insert_scope,

      ['a'] = actions.append_name,
      ['A'] = actions.append_scope,

      ['r'] = actions.rename,
    },
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
