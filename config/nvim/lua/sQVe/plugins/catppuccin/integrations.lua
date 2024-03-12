-- ╻┏┓╻╺┳╸┏━╸┏━╸┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃┃┗┫ ┃ ┣╸ ┃╺┓┣┳┛┣━┫ ┃ ┃┃ ┃┃┗┫┗━┓
-- ╹╹ ╹ ╹ ┗━╸┗━┛╹┗╸╹ ╹ ╹ ╹┗━┛╹ ╹┗━┛

return {
  alpha = true,
  barbecue = false,
  cmp = true,
  dap = false,
  dap_ui = false,
  dashboard = false,
  fidget = true,
  flash = true,
  gitsigns = true,
  headlines = true,
  illuminate = { enabled = true },
  indent_blankline = { enabled = true, scope_color = '' },
  markdown = true,
  mini = { enabled = true, indentscope_color = '' },
  native_lsp = {
    enabled = true,
    underlines = {
      errors = { 'undercurl' },
      hints = { 'underline' },
      warnings = { 'undercurl' },
      information = { 'underline' },
    },
  },
  neogit = false,
  nvimtree = false,
  rainbow_delimiters = false,
  semantic_tokens = true,
  telescope = { enabled = true },
  treesitter = true,
  treesitter_context = true,
  which_key = true,
}
