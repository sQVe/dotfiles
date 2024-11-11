-- ╻ ╻╻ ╻╻┏━╸╻ ╻   ╻┏ ┏━╸╻ ╻
-- ┃╻┃┣━┫┃┃  ┣━┫   ┣┻┓┣╸ ┗┳┛
-- ┗┻┛╹ ╹╹┗━╸╹ ╹   ╹ ╹┗━╸ ╹
-- Keymap popup.

local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
}

M.opts = {
  icons = {
    separator = '=',
    group = '> ',
    mappings = false,
  },
  replace = {
    ['<leader>'] = '<Leader>',
    ['<space>'] = '<Space>',
  },
  plugins = {
    spelling = {
      enabled = false,
    },
  },
  show_help = false,
}

M.config = function(_, opts)
  local wk = require('which-key')

  wk.setup(opts)

  -- Add general keys.
  wk.add({
    {
      mode = { 'n', 'v' },
      { "'", desc = 'Marks' },
      { '"', desc = 'Registers' },
      { '<C-q>', desc = 'Quickfix' },
      { '<C-w>', desc = 'Window' },
      { '<Leader>a', desc = 'Avante' },
      { '@', desc = 'Registers' },
      { '[', desc = 'Previous' },
      { ']', desc = 'Next' },
      { '`', desc = 'Marks' },
      { 'go', desc = 'Sort' },
      { 'gq', desc = 'Format' },
    },
  })

  local ai_objects = {
    { "'", desc = "' string" },
    { ' ', desc = 'whitespace' },
    { '"', desc = '" string' },
    { '(', desc = '() block' },
    { ')', desc = '() block with ws' },
    { '<', desc = '<> block' },
    { '>', desc = '<> block with ws' },
    { '?', desc = 'user prompt' },
    { 'U', desc = 'use/call without dot' },
    { '[', desc = '[] block' },
    { ']', desc = '[] block with ws' },
    { '_', desc = 'underscore' },
    { '`', desc = '` string' },
    { 'a', desc = 'argument' },
    { 'b', desc = ')]} block' },
    { 'd', desc = 'digit(s)' },
    { 'e', desc = 'CamelCase / snake_case' },
    { 'g', desc = 'entire file' },
    { 'i', desc = 'indent' },
    { 'o', desc = 'block, conditional, loop' },
    { 'q', desc = 'quote `"\'' },
    { 't', desc = 'tag' },
    { '{', desc = '{} block' },
    { '}', desc = '{} with ws' },
  }

  local ret = { mode = { 'o', 'x' } }
  local mappings = vim.tbl_extend('force', {}, {
    around = 'a',
    inside = 'i',
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',
  }, opts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub('^around_', ''):gsub('^inside_', '')
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(ai_objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == 'i' then
        desc = desc:gsub(' with ws', '')
      end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end

  wk.add(ret, { notify = false })
end

return M
