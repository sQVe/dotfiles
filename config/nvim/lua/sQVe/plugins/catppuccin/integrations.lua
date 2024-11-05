-- ╻┏┓╻╺┳╸┏━╸┏━╸┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃┃┗┫ ┃ ┣╸ ┃╺┓┣┳┛┣━┫ ┃ ┃┃ ┃┃┗┫┗━┓
-- ╹╹ ╹ ╹ ┗━╸┗━┛╹┗╸╹ ╹ ╹ ╹┗━┛╹ ╹┗━┛

return {
  alpha = true,
  blink_cmp = true,
  cmp = false,
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
    inlay_hints = { background = true },
    underlines = {
      errors = { 'undercurl' },
      hints = { 'underline' },
      warnings = { 'undercurl' },
      information = { 'underline' },
    },
    virtual_text = {
      errors = { 'italic' },
      hints = { 'italic' },
      warnings = { 'italic' },
      information = { 'italic' },
    },
  },
  render_markdown = true,
  semantic_tokens = true,
  telescope = { enabled = true },
  treesitter = true,
  treesitter_context = true,
  which_key = true,
}
