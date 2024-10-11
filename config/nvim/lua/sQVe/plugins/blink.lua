-- ┏┓ ╻  ╻┏┓╻╻┏    ┏━╸┏┳┓┏━┓
-- ┣┻┓┃  ┃┃┗┫┣┻┓   ┃  ┃┃┃┣━┛
-- ┗━┛┗━╸╹╹ ╹╹ ╹   ┗━╸╹ ╹╹
-- Performant completion.

local M = {
  'saghen/blink.cmp',
  version = 'v0.*',
}

M.opts = {
  highlight = { use_nvim_cmp_as_default = true },
  keymap = {
    accept = '<CR>',
    hide = '<C-e>',
    scroll_documentation_down = '<C-d>',
    scroll_documentation_up = '<C-u>',
    select_next = { '<Down>', '<Tab>' },
    select_prev = { '<Up>', '<S-Tab>' },
    show = { '<C-Space>', '<C-CR>' },
  },
  sources = {
    providers = {
      {
        { 'blink.cmp.sources.lsp' },
        { 'blink.cmp.sources.buffer', keyword_length = 1 },
        { 'blink.cmp.sources.path' },
        {
          'blink.cmp.sources.snippets',
          score_offset = -4,
          opts = {
            extended_filetypes = {
              javascriptreact = { 'javascript' },
              typescript = { 'javascript' },
              typescriptreact = {
                'javascript',
                'javascriptreact',
                'typescript',
              },
            },
            friendly_snippets = false,
          },
        },
      },
    },
  },
  trigger = {
    completion = { show_on_insert_on_trigger_character = false },
    signature_help = { enabled = true },
  },
  windows = {
    autocomplete = { preselect = false },
  },
}

return M
