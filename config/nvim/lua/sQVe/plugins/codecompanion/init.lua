-- ┏━╸┏━┓╺┳┓┏━╸┏━╸┏━┓┏┳┓┏━┓┏━┓┏┓╻╻┏━┓┏┓╻
-- ┃  ┃ ┃ ┃┃┣╸ ┃  ┃ ┃┃┃┃┣━┛┣━┫┃┗┫┃┃ ┃┃┗┫
-- ┗━╸┗━┛╺┻┛┗━╸┗━╸┗━┛╹ ╹╹  ╹ ╹╹ ╹╹┗━┛╹ ╹
-- Interact with LLMs.

local format_lines = require('sQVe.utils.format_lines')

local actions = require('sQVe.plugins.codecompanion.actions')
local adapters = require('sQVe.plugins.codecompanion.adapters')
local ui = require('sQVe.plugins.codecompanion.ui')

local M = {
  'olimorris/codecompanion.nvim',
  keys = {
    {
      'Å',
      mode = { 'n', 'v' },
      function()
        vim.cmd('CodeCompanionActions')
      end,
      desc = 'Run code companion',
    },
  },
}

M.opts = function()
  return {
    adapters = {
      openai = adapters.openai(),
    },
    display = {
      action_palette = {
        width = 80,
        height = 15,
        relative = 'editor',
      },
      chat = {
        window = {
          layout = 'buffer',
        },
        intro_message = '',
      },
    },
    actions = {
      {
        name = 'Chat with a LLM',
        strategy = 'chat',
        opts = { auto_submit = true },
        prompts = {
          n = function()
            return require('codecompanion').chat()
          end,
          v = {
            {
              role = 'system',
              content = function(context)
                -- FIXME: Make this nicer.
                return 'I want you to act as a senior '
                  .. context.filetype
                  .. ' developer. I will give you specific code examples and ask you questions. I want you to advise me with explanations and code examples.'
              end,
            },
            {
              role = 'user',
              content = function(context)
                -- FIXME: How do I output all messages sent to the LLM?
                return 'What is 1 + 1?'
              end,
            },
          },
        },
      },
      {
        name = 'Generate a commit message',
        strategy = 'inline',
        condition = function(context)
          return context.filetype == 'gitcommit' and context.is_normal
        end,
        opts = { auto_submit = true },
        prompts = {
          {
            role = 'system',
            content = format_lines({
              "You're an advisor for writing optimal git commit messages based on diffs.",
              'Your response should only contain the git commit message, without needing any further editing.',
              'Try to stay below 80 characters total.',
            }),
          },
          {
            role = 'user',
            content = function()
              local git_diff = vim.fn.system({ 'git', 'diff', '--staged' })

              if not git_diff:match('^diff') then
                error('No diff found in the staging area.')
              end
            end,
          },
        },
      },
    },
    use_default_actions = false,
    use_default_prompts = false,
  }
end

M.config = function(_, opts)
  ui.override()

  require('codecompanion').setup(opts)
end

return M
