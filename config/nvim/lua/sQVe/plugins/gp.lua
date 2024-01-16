-- ┏━╸┏━┓
-- ┃╺┓┣━┛
-- ┗━┛╹
-- Communicate with the ChatGPT API.

local M = {
  'robitx/gp.nvim',
  keys = {
    -- stylua: ignore start
    { '<Leader>i*', mode = { 'v' }, ":<C-u>'<,'>GpDocstring<CR>", desc = 'Generate docstring for selection', },
    { '<Leader>i-', mode = { 'v' }, ":<C-u>'<,'>GpCompress<CR>", desc = 'Compress selection', },
    { '<Leader>i=', mode = { 'v' }, ":<C-u>'<,'>GpSummarize<CR>", desc = 'Summarize selection', },
    { '<Leader>ia', mode = { 'v' }, ":<C-u>'<,'>GpAtomic<CR>", desc = 'Suggest note improvements for selection', },
    { '<Leader>ib', mode = { 'v' }, ":<C-u>'<,'>GpBugs<CR>", desc = 'Repair bugs in selection', },
    { '<Leader>ic', mode = { 'n', 'v' }, '<Cmd>GpChatToggle<CR>', desc = 'Toggle chat', },
    { '<Leader>id', mode = { 'n' }, '<Cmd>GpChatDelete<CR>', desc = 'Delete chat', },
    { '<Leader>ie', mode = { 'v' }, ":<C-u>'<,'>GpExplain<CR>", desc = 'Explain selection', },
    { '<Leader>if', mode = { 'n' }, '<Cmd>GpChatFinder<CR>', desc = 'Chat finder', },
    { '<Leader>ii', mode = { 'n' }, "<Cmd>GpAppend<CR>", desc = 'Append with prompt', },
    { '<Leader>ii', mode = { 'v' }, ":<C-u>'<,'>GpAppend<CR>", desc = 'Append to selection with prompt', },
    { '<Leader>in', mode = { 'n' }, '<Cmd>GpChatNew vsplit<CR>', desc = 'New chat', },
    { '<Leader>in', mode = { 'v' }, ":<C-u>'<,'>GpChatNew vsplit<CR>", desc = 'New chat with selection', },
    { '<Leader>io', mode = { 'v' }, ":<C-u>'<,'>GpOptimize<CR>", desc = 'Optimize selection', },
    { '<Leader>ip', mode = { 'v' }, ":<C-u>'<,'>GpChatPaste<CR>", desc = 'Paste selection into chat', },
    { '<Leader>iq', mode = { 'v' }, ":<C-u>'<,'>GpEnew<CR>", desc = 'Answer prompt with selection context', },
    { '<Leader>ir', mode = { 'v' }, ":<C-u>'<,'>GpReadability<CR>", desc = 'Improve readability of selection', },
    { '<Leader>is', mode = { 'v' }, ":<C-u>'<,'>GpSpelling<CR>", desc = 'Fix spelling in selection', },
    { '<Leader>it', mode = { 'v' }, ":<C-u>'<,'>GpTests<CR>", desc = 'Generate tests for selection', },
    -- stylua: ignore end
  },
}

local agents = {
  {
    name = 'ChatGPT4',
    chat = true,
    command = false,
    model = { model = 'gpt-4-1106-preview', temperature = 1.1, top_p = 1 },
    system_prompt = 'You are a general AI assistant.\n\n'
      .. 'The user has provided additional guidelines for your response:\n\n'
      .. '- Stay factual: If unsure, admit lack of knowledge rather than guessing.\n'
      .. '- Seek clarity: When necessary, ask questions to provide better answers.\n'
      .. '- Foster learning: Utilize the Socratic method to enhance thinking and coding abilities.\n'
      .. '- Be comprehensive: Include any relevant code in your outputs when required.\n'
      .. '- Remain calm: Remember to take a deep breath. Confidence is key!',
  },
  {
    name = 'CodeGPT4',
    chat = false,
    command = true,
    model = { model = 'gpt-4-1106-preview', temperature = 0.8, top_p = 1 },
    system_prompt = 'You are an AI working as a code editor.\n\n'
      .. 'When handling complex concepts or code:\n'
      .. '- Make sure to INCLUDE EXPLANATORY COMMENTS within the code for better comprehension.\n'
      .. '- Refrain from adding commentary outside code blocks.\n\n'
      .. 'Enclose your code-centric answers within code block delimiters:\n'
      .. '```code\n'
      .. '-- Your code and comments here\n'
      .. '```\n',
  },
  { name = 'ChatGPT3-5' },
  { name = 'CodeGPT3-5' },
}

local hooks = {
  Atomic = function(gp, params)
    local template = 'I have the following code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Each note should encompass a single cohesive topic; split the text into distinct, self-contained notes if it spans multiple diverse subjects.\n'
      .. 'Preserve any YAML data within the notes exactly as it is, ensuring no changes are made to this formatting or content.\n'
      .. 'Focus on enhancements to grammar and spelling to ensure the notes are well-written and easily comprehensible.\n'
      .. 'Format and structure each note for optimal clarity, using bullet points, numbered lists, or headings where appropriate.\n'
      .. 'Please remember that these notes are tailored for personal use and should be optimally organized for quick reference.'

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Bugs = function(gp, params)
    local template = 'I have encountered an issue in the code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Could you help me by identifying and fixing any bugs in the above code?.'

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Compress = function(gp, params)
    local template = 'I have the following text from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Could you assist by condensing the text above to its most succinct form?.'

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Docstring = function(gp, params)
    local template = 'I have the following code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please provide docstrings for the code block shown above.\n'
      .. 'Respond with only the docstring snippet, omitting the original code block from your answer..'

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Explain = function(gp, params)
    local template = 'I need an explanation for the code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please provide a detailed explanation of the code block shown above.'

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Tests = function(gp, params)
    local template = 'Please devise unit tests for the code excerpted from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Kindly ensure your response exclusively consists of the unit tests corresponding to the presented code snippet.'

    local current_filetype = vim.bo.filetype
    local javascript_filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    }

    if vim.tbl_contains(javascript_filetypes, current_filetype) then
      template = template
        .. '\nPlease use `vitest` as the test runner and `@testing-library` for any DOM-related tests.'
    end

    template = template .. '\nRespond exclusively with the snippet.'

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Optimize = function(gp, params)
    local template = 'The code from {{filename}} requires optimization:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please examine the code for any code smells and suggest improvements.\n'
      .. 'Your response should focus on optimizing the provided code snippet.'

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Readability = function(gp, params)
    local template = 'A more readable version is requested for the text from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please enhance the clarity and readability of the code snippet above in your response.'

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Spelling = function(gp, params)
    local template = 'Correct the grammar and spelling in the following text from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond with the revised text only.'

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
  Summarize = function(gp, params)
    local template = 'Summarize the text from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please focus your response on a concise summary of the provided text.'

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      template,
      agent.system_prompt
    )
  end,
}

M.opts = {
  agents = agents,
  chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-x>' },
  chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-n>' },
  chat_shortcut_respond = { modes = { 'n', 'v', 'x' }, shortcut = '<CR>' },
  chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-c>' },
  chat_user_prefix = '💬:',
  command_auto_select_response = false,
  hooks = hooks,
  image_dir = os.getenv('XDG_DATA_HOME') .. '/nvim/gp/images',
  whisper_dir = os.getenv('XDG_DATA_HOME') .. '/nvim/gp/whispers',
}

return M
