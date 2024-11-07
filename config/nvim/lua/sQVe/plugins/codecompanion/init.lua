-- ┏━╸┏━┓╺┳┓┏━╸┏━╸┏━┓┏┳┓┏━┓┏━┓┏┓╻╻┏━┓┏┓╻
-- ┃  ┃ ┃ ┃┃┣╸ ┃  ┃ ┃┃┃┃┣━┛┣━┫┃┗┫┃┃ ┃┃┗┫
-- ┗━╸┗━┛╺┻┛┗━╸┗━╸┗━┛╹ ╹╹  ╹ ╹╹ ╹╹┗━┛╹ ╹
-- Interact with LLMs.

local format_lines = require('sQVe.utils.format_lines')
local autocmd = require('sQVe.utils.autocmd')

local prompts = require('sQVe.plugins.codecompanion.prompts')
local ui = require('sQVe.plugins.codecompanion.ui')

local M = {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanionChat' },
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

M.opts = {
  display = {
    action_palette = {
      width = 80,
      height = 10,
      relative = 'editor',
      opts = {
        show_default_actions = false,
        show_default_prompt_library = false,
      },
    },
    chat = {
      intro_message = '',
      show_settings = true,
      window = {
        layout = 'buffer',
      },
    },
    diff = { provider = 'mini_diff' },
  },
  opts = {
    system_prompt = format_lines({
      "You are an AI programming assistant. You're plugged into the Neovim text editor on a user's machine.",
      '',
      'You must:',
      "- Follow the user's requirements carefully and to the letter.",
      '- Keep your answers short and impersonal, especially if the user responds with context outside of your task',
      '- Minimize prose.',
      '- Use proper punctuation in comments.',
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
  },
  prompt_library = {
    ['Chat'] = prompts.chat,
    ['Condense text'] = prompts.condense_text,
    ['Debug code diagnostics'] = prompts.debug_code_diagnostics,
    ['Enhance text readability'] = prompts.enhance_text_readability,
    ['Explain code'] = prompts.explain_code,
    ['Generate docstring'] = prompts.generate_docstring,
    ['Generate pull request description'] = prompts.generate_pull_request_description,
    ['Generate unit tests'] = prompts.generate_unit_tests,
    ['Improve code'] = prompts.improve_code,
    ['Inline prompt'] = prompts.inline_prompt,
    ['Proofread text'] = prompts.proofread_text,
    ['Rephrase text'] = prompts.rephrase_text,
    ['Write commit message'] = prompts.write_commit_message,
  },
  strategies = {
    inline = { adapter = 'anthropic' },
    chat = {
      adapter = 'anthropic',
      roles = {
        llm = 'Assistant',
        user = 'User',
      },
    },
  },
}

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
