-- ┏━┓╻ ╻┏━┓┏┓╻╺┳╸┏━╸
-- ┣━┫┃┏┛┣━┫┃┗┫ ┃ ┣╸
-- ╹ ╹┗┛ ╹ ╹╹ ╹ ╹ ┗━╸
-- AI integration.

local format_lines = require('sQVe.utils.format_lines')

local M = {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  build = 'make',
  lazy = false,
  version = false,
  keys = {
    {
      'Åa',
      function()
        require('avante.api').ask()
      end,
      desc = 'Ask',
      mode = { 'n', 'v' },
    },
    {
      'Åe',
      function()
        require('avante.api').edit()
      end,
      desc = 'Edit',
      mode = { 'v' },
    },
    {
      'Åc',
      function()
        require('avante.api').ask({
          question = format_lines({
            'Rewrite the text to be more concise while:',
            '1. Maintaining the core message',
            '2. Using clear and direct language',
            '3. Removing redundant information',
          }),
        })
      end,
      desc = 'Condense',
      mode = { 'v' },
    },
    {
      'Åd',
      function()
        require('avante.api').ask({
          question = format_lines({
            'Generate ocstrings for the code while:',
            '1. Describing the purpose and functionality',
            '2. Including parameters and return values',
            '3. Following language-specific conventions',
          }),
        })
      end,
      desc = 'Docstring',
      mode = { 'v' },
    },
    {
      'Åx',
      function()
        require('avante.api').ask({
          question = format_lines({
            'Explain the code while:',
            '1. Providing a clear overview',
            '2. Breaking down the implementation',
            '3. Highlighting key functionality',
          }),
        })
      end,
      desc = 'Explain',
      mode = { 'v' },
    },
    {
      'Åo',
      function()
        require('avante.api').ask({
          question = format_lines({
            'Optimize the code while considering:',
            '1. Performance improvements',
            '2. Code readability and maintainability',
            '3. Best practices and design patterns',
            '4. Memory efficiency',
          }),
        })
      end,
      desc = 'Optimize',
      mode = { 'v' },
    },
    {
      'Åp',
      function()
        require('avante.api').ask({
          question = format_lines({
            'Proofread the text while:',
            '1. Fixing grammar and spelling',
            '2. Enhancing readability',
            '3. Improving sentence structure',
            '4. Maintaining consistent tone',
          }),
        })
      end,
      desc = 'Proofread',
      mode = { 'v' },
    },
    {
      'År',
      function()
        require('avante.api').ask({
          question = format_lines({
            'Rephrase the text while:',
            '1. Preserving the original meaning',
            '2. Enhancing the clarity and conciseness',
            '3. Maintaining the original tone',
          }),
        })
      end,
      desc = 'Rephrase',
      mode = { 'v' },
    },
  },
}

M.opts = {
  behaviour = {
    auto_set_keymaps = false,
  },
  hints = { enabled = false },
  windows = {
    width = 40,
    input = { height = 10 },
    ask = { start_insert = false },
  },
}

return M
