-- ┏┓ ┏━┓┏━┓┏┓ ┏━╸┏━╸╻ ╻┏━╸
-- ┣┻┓┣━┫┣┳┛┣┻┓┣╸ ┃  ┃ ┃┣╸
-- ┗━┛╹ ╹╹┗╸┗━┛┗━╸┗━╸┗━┛┗━╸
-- Winbar with LSP context.

local M = {
  'utilyre/barbecue.nvim',
  event = 'VeryLazy',
  name = 'barbecue',
  version = '*',
}

M.opts = function()
  local colors = require('gruvbox.palette').colors
  local get_symbol_map = require('sQVe.utils.lsp').get_symbol_map

  return {
    show_modified = true,
    symbols = {
      modified = '',
      ellipsis = '…',
      separator = '',
    },
    kinds = get_symbol_map(),
    theme = {
      normal = { fg = colors.bright_aqua },
      ellipsis = { fg = colors.gray },
      separator = { fg = colors.gray },
      modified = { fg = colors.bright_red },

      dirname = { fg = colors.gray },
      basename = { bold = true },
      context = { fg = colors.bright_purple },

      context_array = { fg = colors.bright_orange },
      context_boolean = { fg = colors.bright_purple },
      context_class = { link = 'CmpItemKindClass' },
      context_constant = { link = 'CmpItemKindConstant' },
      context_constructor = { link = 'CmpItemKindConstructor' },
      context_enum = { link = 'CmpItemKindEnum' },
      context_enum_member = { link = 'CmpItemKindEnumMember' },
      context_event = { fg = colors.bright_aqua },
      context_field = { link = 'CmpItemKindField' },
      context_file = { link = 'CmpItemKindFile' },
      context_function = { link = 'CmpItemKindFunction' },
      context_interface = { link = 'CmpItemKindInterface' },
      context_key = { link = 'CmpItemKindKeyword' },
      context_method = { link = 'CmpItemKindMethod' },
      context_module = { link = 'CmpItemKindModule' },
      context_namespace = { fg = colors.bright_red },
      context_null = { fg = colors.bright_red },
      context_number = { fg = colors.bright_purple },
      context_object = { fg = colors.bright_orange },
      context_operator = { fg = colors.bright_orange },
      context_package = { fg = colors.bright_green },
      context_property = { link = 'CmpItemKindProperty' },
      context_string = { fg = colors.bright_green },
      context_struct = { link = 'CmpItemKindStruct' },
      context_type_parameter = { link = 'CmpItemKindTypeParameter' },
      context_variable = { fg = colors.bright_red },
    },
  }
end

return M
