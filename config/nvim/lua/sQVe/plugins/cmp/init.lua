-- ┏━╸┏┳┓┏━┓
-- ┃  ┃┃┃┣━┛
-- ┗━╸╹ ╹╹
-- Completion engine.

local M = {
  'hrsh7th/nvim-cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'petertriho/cmp-git',
  },
}

M.config = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local methods = require('sQVe.plugins.cmp.methods')
  local utils = require('sQVe.plugins.cmp.utils')

  -- Pattern that matches any consecutive characters, including special ones.
  local anyWord = [[\k\+]]

  local mapKey = function(fn, modes)
    local defaultModes = { 'c', 'i' }

    return cmp.mapping(fn, vim.tbl_extend('force', defaultModes, modes or {}))
  end

  cmp.setup({
    formatting = {
      fields = { 'abbr', 'menu', 'kind' },
      format = function(entry, vim_item)
        vim_item = lspkind.cmp_format({
          menu = {
            buffer = ' buf',
            emoji = ' emo',
            git = ' git',
            snippets = ' sni',
            nvim_lsp = ' lsp',
            nvim_lua = ' api',
            path = ' path',
          },
          mode = 'symbol',
          symbol_map = utils.get_symbol_map(),
        })(entry, vim_item)

        return methods.format_label(vim_item)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-CR>'] = mapKey(
        cmp.mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-Space>'] = mapKey(
        cmp.mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-c>'] = mapKey(methods.abort),
      ['<C-d>'] = mapKey(cmp.mapping.scroll_docs(8)),
      ['<C-j>'] = mapKey(methods.expand_suggestion_word),
      ['<C-k>'] = mapKey(methods.signature_help),
      ['<C-l>'] = mapKey(methods.expand_snippet_or_suggestion),
      ['<C-u>'] = mapKey(cmp.mapping.scroll_docs(-8)),
      ['<CR>'] = mapKey(cmp.mapping.confirm({ select = false })),
      ['<Tab>'] = mapKey(methods.next, { 's' }),
      ['<S-Tab>'] = mapKey(methods.previous, { 's' }),
    }),
    performance = {
      fetching_timeout = 250,
      max_view_entries = 100,
    },
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'snippets' },
      {
        name = 'buffer',
        keyword_length = 4,
        option = {
          get_bufnrs = utils.get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
      { name = 'emoji' },
    }),
  })

  cmp.setup.filetype('gitcommit', {
    sources = {
      { name = 'git' },
      {
        name = 'buffer',
        keyword_length = 2,
        option = {
          get_bufnrs = utils.get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
      { name = 'emoji' },
    },
  })

  cmp.setup.filetype('markdown', {
    sources = {
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'snippets' },
      {
        name = 'buffer',
        keyword_length = 2,
        option = {
          get_bufnrs = utils.get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
      { name = 'emoji' },
    },
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {
        name = 'buffer',
        keyword_length = 2,
        option = {
          get_bufnrs = utils.get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline', option = { ignore_cmds = { '!' } } },
      {
        name = 'buffer',
        keyword_length = 4,
        option = {
          get_bufnrs = utils.get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
    }),
  })

  require('cmp_git').setup()
end

return M
