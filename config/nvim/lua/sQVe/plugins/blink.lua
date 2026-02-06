-- ┏┓ ╻  ╻┏┓╻╻┏    ┏━╸┏┳┓┏━┓
-- ┣┻┓┃  ┃┃┗┫┣┻┓   ┃  ┃┃┃┣━┛
-- ┗━┛┗━╸╹╹ ╹╹ ╹   ┗━╸╹ ╹╹
-- Performant completion.

local M = {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'InsertEnter',
}

M.opts = function()
  return {
    completion = {
      documentation = { auto_show = true },
      list = { selection = { auto_insert = true, preselect = false } },
      menu = {
        draw = {
          columns = { { 'label', gap = 1 }, { 'kind_icon' } },
          components = {
            kind_icon = {
              ellipsis = false,
              highlight = function(ctx)
                if ctx.kind == 'Copilot' then
                  return 'Comment'
                end
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
              text = function(ctx)
                if ctx.kind == 'Copilot' then
                  return '󱙺 '
                end
                local icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return icon
              end,
            },
          },
        },
      },
    },
    keymap = {
      ['<C-Space>'] = { 'hide_documentation', 'show', 'show_documentation' },
      ['<C-CR>'] = { 'hide_documentation', 'show', 'show_documentation' },
      ['<C-e>'] = { 'cancel', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-j>'] = { 'snippet_forward', 'fallback' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
    },
    signature = { enabled = true },
    sources = {
      default = function()
        local node = vim.treesitter.get_node()
        local enabled_providers = { 'lsp', 'buffer', 'path', 'snippets' }

        if
          node
          and vim.tbl_contains({
            'comment',
            'line_comment',
            'block_comment',
          }, node:type())
        then
          return { 'buffer', 'path' }
        end

        return enabled_providers
      end,

      per_filetype = {
        minifiles = {},
      },

      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          fallbacks = { 'lsp' },
        },
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
        },
        buffer = {
          name = 'Buffer',
          module = 'blink.cmp.sources.buffer',
        },
        path = {
          name = 'Path',
          module = 'blink.cmp.sources.path',
          score_offset = 3,
          opts = {
            show_hidden_files_by_default = true,
          },
        },
        snippets = {
          name = 'Snippets',
          module = 'blink.cmp.sources.snippets',
          min_keyword_length = 1,
          score_offset = -3,
          opts = { friendly_snippets = false },
        },
      },
    },
  }
end

return M
