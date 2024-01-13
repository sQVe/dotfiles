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
    { '<Leader>ia', mode = { 'v' }, ":<C-u>'<,'>GpAppend<CR>", desc = 'Append to selection with prompt', },
    { '<Leader>ib', mode = { 'v' }, ":<C-u>'<,'>GpBugs<CR>", desc = 'Repair bugs in selection', },
    { '<Leader>ic', mode = { 'n', 'v' }, '<Cmd>GpChatToggle<CR>', desc = 'Toggle chat', },
    { '<Leader>id', mode = { 'n' }, '<Cmd>GpChatDelete<CR>', desc = 'Delete chat', },
    { '<Leader>ie', mode = { 'v' }, ":<C-u>'<,'>GpExplain<CR>", desc = 'Explain selection', },
    { '<Leader>if', mode = { 'n' }, '<Cmd>GpChatFinder<CR>', desc = 'Chat finder', },
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
      .. 'The user provided the additional info about how they would like you to respond:\n\n'
      .. "- If you're unsure don't guess and say you don't know instead.\n"
      .. '- Ask question if you need clarification to provide better answer.\n'
      .. '- Use Socratic method to improve your thinking and coding skills.\n'
      .. "- Don't exclude any code from your output if the answer requires coding.\n"
      .. "- Take a deep breath; You've got this!",
  },
  {
    name = 'CodeGPT4',
    chat = false,
    command = true,
    model = { model = 'gpt-4-1106-preview', temperature = 0.8, top_p = 1 },
    system_prompt = 'You are an AI working as a code editor.\n\n'
      .. 'For complex concepts or code, INCLUDE EXPLANATORY COMMENTS to ensure clarity.\n'
      .. 'Please AVOID COMMENTARY OUTSIDE of the codeblock response.\n'
      .. 'Start and end your answer with:\n\n```',
  },
  { name = 'ChatGPT3-5' },
  { name = 'CodeGPT3-5' },
}

local hooks = {
  Bugs = function(gp, params)
    local template = 'I have the following code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond by fixing the bugs for the code above.'

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
      .. 'Please respond by making the text above as concise as possible.'

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
      .. 'Please respond by writing docstrings for the code above, while excluding the code above from the answer.\n'
      .. 'Respond exclusively with the snippet.'

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
    local template = 'I have the following code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond by explaining the code above.'

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
    local template = 'I have the following code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond by writing unit tests for the code above.'

    local current_filetype = vim.bo.filetype
    local javascript_filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    }

    if vim.tbl_contains(javascript_filetypes, current_filetype) then
      template = template
        .. 'Use vitest for running the tests and @testing-library for DOM-related testing.\n\n'
    end

    template = template .. 'Respond exclusively with the snippet.'

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
    local template = 'I have the following code from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond by optimizing the code above.\n'
      .. 'Analyze it for code smells and suggest improvements.'

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
    local template = 'I have the following text from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond with a more readable version of the text above.'

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
    local template = 'I have the following text from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond with a grammar and spelling corrected version for the text above.'

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
    local template = 'I have the following text from {{filename}}:\n\n'
      .. '```{{filetype}}\n{{selection}}\n```\n\n'
      .. 'Please respond with a summarization of the text above.'

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
