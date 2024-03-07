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
    'saadparwaiz1/cmp_luasnip',
  },
}

local get_visible_bufnrs = function()
  local bufnrs = {}

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)

    if not bufnrs[bufnr] then
      table.insert(bufnrs, bufnr)
    end
  end

  return bufnrs
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match('%s')
      == nil
end

local expand_snippet = function(args)
  require('luasnip').lsp_expand(args.body)
end

M.config = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')
  local get_symbol_map = require('sQVe.utils.lsp').get_symbol_map

  local config = cmp.config
  local mapping = cmp.mapping

  -- Pattern that matches any consecutive characters, including special ones.
  local anyWord = [[\k\+]]

  local mapKey = function(fn, modes)
    local defaultModes = { 'c', 'i' }

    return mapping(fn, vim.tbl_extend('force', defaultModes, modes or {}))
  end

  local abort = function(fallback)
    local selected_entry = cmp.get_selected_entry()

    if selected_entry ~= nil then
      cmp.abort()
    else
      fallback()
    end
  end

  local cycle_suggestions = function(fallback)
    local suggestion = require('copilot.suggestion')

    if cmp.visible() then
      cmp.close()
    end

    if suggestion.is_visible() then
      suggestion.next()
    else
      fallback()
    end
  end

  local expand = function(fallback)
    local suggestion = require('copilot.suggestion')

    if luasnip.expandable() then
      luasnip.expand_or_jump()
    elseif suggestion.is_visible() then
      suggestion.accept()
    else
      fallback()
    end
  end

  local next = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.jumpable(1) then
      luasnip.jump(1)
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  local previous = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  local signature_help = function()
    if cmp.visible() then
      cmp.close()
    end
    vim.lsp.buf.signature_help()
  end

  local format_label = function(vim_item)
    local ELLIPSIS_CHAR = '…'
    local MAX_LABEL_WIDTH = 60
    local label = vim_item.abbr
    local label_len = string.len(label)

    if label_len > MAX_LABEL_WIDTH then
      vim_item.abbr = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
        .. ELLIPSIS_CHAR
    elseif label_len < MAX_LABEL_WIDTH then
      vim_item.abbr = label .. string.rep(' ', MAX_LABEL_WIDTH - label_len)
    end

    return vim_item
  end
  cmp.setup({
    formatting = {
      fields = { 'abbr', 'menu', 'kind' },
      format = function(entry, vim_item)
        vim_item = lspkind.cmp_format({
          menu = {
            buffer = ' buf',
            emoji = ' emo',
            luasnip = ' sni',
            nvim_lsp = ' lsp',
            nvim_lua = ' api',
            path = ' path',
          },
          mode = 'symbol',
          symbol_map = get_symbol_map(),
        })(entry, vim_item)

        return format_label(vim_item)
      end,
    },
    mapping = mapping.preset.insert({
      ['<C-CR>'] = mapKey(
        mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-Space>'] = mapKey(
        mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-c>'] = mapKey(abort),
      ['<C-d>'] = mapKey(mapping.scroll_docs(8)),
      ['<C-j>'] = mapKey(cycle_suggestions),
      ['<C-k>'] = mapKey(signature_help),
      ['<C-l>'] = mapKey(expand),
      ['<C-u>'] = mapKey(mapping.scroll_docs(-8)),
      ['<CR>'] = mapKey(mapping.confirm({ select = false })),
      ['<Tab>'] = mapKey(next, { 's' }),
      ['<S-Tab>'] = mapKey(previous, { 's' }),
    }),
    performance = {
      fetching_timeout = 250,
      max_view_entries = 100,
    },
    snippet = { expand = expand },
    sources = config.sources({
      {
        name = 'nvim_lsp',
        option = {
          markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\|\^\)\+]] },
        },
      },
      { name = 'path' },
      { name = 'luasnip', keyword_length = 2 },
      {
        name = 'buffer',
        keyword_length = 4,
        option = {
          get_bufnrs = get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
      { name = 'emoji' },
    }),
  })

  cmp.setup.filetype('markdown', {
    sources = {
      {
        name = 'nvim_lsp',
        option = {
          markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\|\^\)\+]] },
        },
      },
      { name = 'path' },
      { name = 'luasnip', keyword_length = 2 },
      {
        name = 'buffer',
        keyword_length = 2,
        option = {
          get_bufnrs = get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
      { name = 'emoji' },
    },
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = mapping.preset.cmdline(),
    sources = {
      {
        name = 'buffer',
        keyword_length = 2,
        option = {
          get_bufnrs = get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = mapping.preset.cmdline(),
    sources = config.sources({
      { name = 'path' },
      { name = 'cmdline', option = { ignore_cmds = { '!' } } },
      {
        name = 'buffer',
        keyword_length = 4,
        option = {
          get_bufnrs = get_visible_bufnrs,
          keyword_pattern = anyWord,
        },
      },
    }),
  })
end

return M
