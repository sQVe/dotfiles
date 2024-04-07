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
  },
  key_labels = {
    ['<leader>'] = '<Leader>',
    ['<space>'] = '<Space>',
  },
  operators = {
    gc = 'Comment',
    gq = 'Format',
    gs = 'Surround',
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

  -- Register general keys.
  wk.register({
    mode = { 'n', 'v' },
    ["'"] = { 'Marks' },
    ['"'] = { 'Registers' },
    ['<C-q>'] = { 'Quickfix' },
    ['<C-w>'] = { 'Window' },
    ['@'] = { 'Registers' },
    ['['] = { 'Previous' },
    [']'] = { 'Next' },
    ['`'] = { 'Marks' },
    g = { o = 'Sort' },
    y = { o = { 'Toggle settings' } },
  })

  local inner_textobjects = {
    [' '] = 'Whitespace',
    ['"'] = '"',
    ["'"] = "'",
    ['`'] = '`',
    ['('] = '(',
    [')'] = ') including white-space',
    ['>'] = '> including white-space',
    ['<lt>'] = '<',
    [']'] = '] including white-space',
    ['['] = '[',
    ['}'] = '} including white-space',
    ['{'] = '{',
    ['?'] = 'User prompt',
    _ = 'Underscore',
    a = 'Argument',
    b = '), ], }',
    B = '], }',
    c = 'Class',
    f = 'Function',
    i = 'Indentation',
    o = 'Block, conditional, loop',
    p = 'Paragraph',
    q = 'Quote `, ", \'',
    s = 'Sentence',
    t = 'Tag',
    w = 'word',
    W = 'WORD',
  }
  local around_textobjects = vim.deepcopy(inner_textobjects)

  for key, description in pairs(inner_textobjects) do
    around_textobjects[key] = description:gsub(' including.*', '')
  end

  -- Register textobjects keys.
  require('which-key').register({
    mode = { 'o', 'x' },
    i = inner_textobjects,
    a = around_textobjects,
  })
end

return M
