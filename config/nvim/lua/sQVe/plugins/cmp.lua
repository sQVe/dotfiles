-- ┏━╸┏┳┓┏━┓
-- ┃  ┃┃┃┣━┛
-- ┗━╸╹ ╹╹
-- Completion engine.

local M = {}

M.init = function(use)
  use({
    'hrsh7th/nvim-cmp',
    config = M.config,
    event = { 'CmdlineEnter', 'InsertEnter' },
    requires = { { 'onsails/lspkind-nvim', module = 'lspkind' } },
  })
  use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }) -- Buffer completion.
  use({ 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }) -- Command completion.
  use({ 'hrsh7th/cmp-emoji', after = 'nvim-cmp' }) -- Emoji completion.
  use({ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }) -- LSP completion.
  use({ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }) -- API completion.
  use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' }) -- Path completion.
  use({ 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' }) -- VSnip completion.
end

M.config = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local config = cmp.config
  local mapping = cmp.mapping

  -- Pattern that matches any consecutive characters, including special ones.
  local anyWord = [[\k\+]]

  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match('%s')
        == nil
  end

  local mapKey = function(keymap)
    return mapping(keymap, { 'c', 'i' })
  end

  local signature_help = function()
    if cmp.visible() then
      cmp.close()
    end
    vim.lsp.buf.signature_help()
  end

  local next = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  local previous = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end

  local parentheses = function(fallback)
    if cmp.visible() then
      cmp.complete()
      vim.api.nvim_put({ '()' }, 'c', false, true)
    else
      fallback()
    end
  end

  local fallback = function(fallback)
    fallback()
  end

  local expand_snippet = function(args)
    vim.fn['vsnip#anonymous'](args.body)
  end

  local compare_locality = function(...)
    return require('cmp_buffer'):compare_locality(...)
  end

  local get_sources = function(keyword_length)
    return config.sources({
      { name = 'nvim_lua', keyword_length = keyword_length, priority = 80 },
      { name = 'nvim_lsp', keyword_length = keyword_length, priority = 80 },
      { name = 'path', keyword_length = keyword_length, priority = 60 },
      {
        name = 'buffer',
        keyword_length = 4,
        option = {
          keyword_pattern = anyWord,
        },
        priority = 40,
      },
      { name = 'vsnip', keyword_length = 2, priority = 20 },
      { name = 'emoji', priority = 10 },
    })
  end

  local get_mapping = function(is_cmdline)
    local triggerCompleteMapping = is_cmdline and mapKey(cmp.mapping.complete())
      or mapKey(mapping.complete({
        reason = cmp.ContextReason.Auto,
        config = { sources = get_sources(0) },
      }))

    return mapping.preset.insert({
      ['()'] = is_cmdline and mapKey(fallback) or mapKey(parentheses),
      ['<C-CR>'] = triggerCompleteMapping,
      ['<C-Space>'] = triggerCompleteMapping,
      ['<C-d>'] = mapKey(mapping.scroll_docs(8)),
      ['<C-e>'] = mapKey(mapping.close()),
      ['<C-k>'] = mapKey(signature_help),
      ['<C-u>'] = mapKey(mapping.scroll_docs(-8)),
      ['<CR>'] = mapKey(mapping.confirm({ select = false })),
      ['<Tab>'] = mapKey(next),
      ['<S-Tab>'] = mapKey(previous),
    })
  end

  cmp.setup({
    experimental = { ghost_text = { hl_group = 'GruvboxGray' } },
    formatting = {
      format = lspkind.cmp_format({
        with_text = false,
        menu = {
          buffer = ' buf',
          emoji = ' emo',
          nvim_lsp = ' lsp',
          nvim_lua = ' api',
          path = ' path',
          vsnip = ' snip',
        },
      }),
    },
    mapping = get_mapping(),
    snippet = { expand = expand_snippet },
    sorting = {
      comparators = {
        compare_locality,
        config.compare.offset,
        config.compare.exact,
        config.compare.score,
        config.compare.length,
        config.compare.sort_text,
        config.compare.order,
      },
    },
    sources = get_sources(1),
    preselect = cmp.PreselectMode.None,
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = get_mapping(true),
    sources = config.sources({
      {
        name = 'buffer',
        keyword_length = 2,
        option = { keyword_pattern = anyWord },
      },
    }),
  })
  cmp.setup.cmdline(':', {
    mapping = get_mapping(true),
    sources = config.sources({
      { name = 'cmdline', priority = 40 },
      { name = 'path', priority = 20 },
      {
        name = 'buffer',
        keyword_length = 4,
        option = { keyword_pattern = anyWord },
        priority = 10,
      },
    }),
  })
end

return M