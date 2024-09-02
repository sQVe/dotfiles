-- ┏━╸┏━┓╺┳┓┏━╸┏━╸┏━┓┏┳┓┏━┓┏━┓┏┓╻╻┏━┓┏┓╻
-- ┃  ┃ ┃ ┃┃┣╸ ┃  ┃ ┃┃┃┃┣━┛┣━┫┃┗┫┃┃ ┃┃┗┫
-- ┗━╸┗━┛╺┻┛┗━╸┗━╸┗━┛╹ ╹╹  ╹ ╹╹ ╹╹┗━┛╹ ╹
-- Interact with LLMs.

local format_lines = require('sQVe.utils.format_lines')
local autocmd = require('sQVe.utils.autocmd')

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
    actions = {
      actions.chat(),
      actions.condense_text(),
      actions.debug_code_diagnostics(),
      actions.enhance_text_readability(),
      actions.explain_code(),
      actions.generate_docstring(),
      actions.generate_pull_request_description(),
      actions.generate_unit_tests(),
      actions.improve_code(),
      actions.proofread_text(),
      actions.rephrase_text(),
      actions.write_commit_message(),
    },
    adapters = {
      openai = adapters.openai,
    },
    display = {
      action_palette = { width = 80, height = 10, relative = 'editor' },
      chat = {
        intro_message = '',
        show_settings = true,
        window = {
          layout = 'buffer',
          opts = { cursorcolumn = false, cursorline = false },
        },
      },
    },
    opts = {
      system_prompt = format_lines({
        "You are an AI programming assistant. You're plugged into the Neovim text editor on a user's machine.",
        '',
        'You must:',
        "- Follow the user's requirements carefully and to the letter.",
        '- Keep your answers short and impersonal, especially if the user responds with context outside of your task',
        '- Minimize prose.',
        '- Use Markdown formatting in your answers.',
        '- Include the programming language name at the start of the Markdown code blocks.',
        '- Avoid line numbers in code blocks.',
        '- Avoid wrapping the whole response in triple backticks.',
        '- Only return relevant code.',
        '',
        'When given a task:',
        '1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail.',
        '2. Output the code in a single code block.',
        '3. You can only give one reply for each.',
      }),
      use_default_actions = false,
      use_default_prompts = false,
    },
    strategies = {
      chat = {
        roles = { llm = 'Assistant', user = 'User' },
      },
    },
  }
end

M.config = function(_, opts)
  ui.override()

  require('codecompanion').setup(opts)

  autocmd('WinClosed', {
    group = 'CloseCodeCompanionChatWindow',
    callback = function(args)
      local bufnr = args.buf

      if vim.bo[bufnr].filetype == 'codecompanion' then
        local last_chat = require('codecompanion.strategies.chat').last_chat()

        if last_chat ~= nil then
          last_chat:close()
        end
      end
    end,
  })
end

return M
