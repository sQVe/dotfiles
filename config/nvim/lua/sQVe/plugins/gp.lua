-- ┏━╸┏━┓
-- ┃╺┓┣━┛
-- ┗━┛╹
-- Communicate with the ChatGPT API.

local M = {
  'robitx/gp.nvim',
  keys = {
    -- stylua: ignore start
    { '<Leader>i*', mode = { 'v' }, ":<C-u>'<,'>GpDocumentation<CR>", desc = 'Generate documentation for selection', },
    { '<Leader>i-', mode = { 'v' }, ":<C-u>'<,'>GpCompress<CR>", desc = 'Compress selection', },
    { '<Leader>i?', mode = { 'v' }, ":<C-u>'<,'>GpExplain<CR>", desc = 'Explain selection', },
    { '<Leader>ia', mode = { 'v' }, ":<C-u>'<,'>GpAtomic<CR>", desc = 'Suggest note improvements for selection', },
    { '<Leader>ib', mode = { 'v' }, ":<C-u>'<,'>GpBugs<CR>", desc = 'Repair bugs in selection', },
    { '<Leader>ic', mode = { 'n', 'v' }, '<Cmd>GpChatToggle<CR>', desc = 'Toggle chat', },
    { '<Leader>id', mode = { 'n' }, '<Cmd>GpChatDelete<CR>', desc = 'Delete chat', },
    { '<Leader>id', mode = { 'v' }, ":<C-u>'<,'>GpDiff<CR>", desc = 'Generate description from a diff', },
    { '<Leader>ie', mode = { 'v' }, ":<C-u>'<,'>GpEmojify<CR>", desc = 'Emojify selection', },
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
    { '<Leader>iw', mode = { 'v' }, ":<C-u>'<,'>GpReword<CR>", desc = 'Reword selection', },
    { '<Leader>iz', mode = { 'v' }, ":<C-u>'<,'>GpSummarize<CR>", desc = 'Summarize selection', },
    -- stylua: ignore end
  },
}

local javascript_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

-- Ensure that we have access to `table.unpack`.
if not table.unpack then
  table.unpack = unpack
end

--- Generates a prompt string.
--- @param prompt_lines table<string> The table of lines that will be concatenated to form the prompt.
--- @vararg string A variable number of arguments used to format the prompt.
local generate_prompt = function(prompt_lines, ...)
  local arguments = { ... }

  local format_prompts = function(prompt, arguments)
    return prompt:format(table.unpack(arguments))
  end

  -- Ensure that all empty arguments are replaced with '%s', since that allows
  -- us to sanitize them.
  for idx, argument in ipairs(arguments) do
    if argument == '' then
      arguments[idx] = '%s'
    end
  end

  local prompt = table.concat(prompt_lines, '\n')
  local ok, formatted_prompt = pcall(format_prompts, prompt, arguments)

  -- Remove any left over '%s', including the newline, from the prompt.
  local sanitized_prompt = (ok and formatted_prompt or prompt):gsub('%%s\n', '')

  return sanitized_prompt
end

local agents = {
  {
    name = 'ChatGPT4',
    chat = true,
    command = false,
    model = { model = 'gpt-4-1106-preview', temperature = 1.1, top_p = 1 },
    system_prompt = generate_prompt({
      'You are a general-purpose AI assistant.',
      '',
      'Here are additional guidelines for your responses:',
      '- Stay factual: Admit lack of knowledge rather than making assumptions if unsure.',
      '- Seek clarity: Ask questions when necessary to provide more helpful answers.',
      '- Foster learning: Use the Socratic method to guide users to better understanding and coding practices.',
      '- Be comprehensive: When required, include relevant code examples in outputs.',
      '- Pay attention to Markdown formatting: Use sentence case in Markdown headers.',
    }),
  },
  {
    name = 'CodeGPT4',
    chat = false,
    command = true,
    model = { model = 'gpt-4-1106-preview', temperature = 1.1, top_p = 1 },
    system_prompt = generate_prompt({
      'You are an AI working as a code editor.',
      '',
      'When handling code:',
      '- Make sure to INCLUDE EXPLANATORY COMMENTS within the code for better comprehension.',
      '- Refrain from adding commentary outside code blocks.',
      '- Ensure that Markdown headers use sentence case.',
      '',
      'Enclose your code-centric answers within code block delimiters:',
      '```code',
      '-- Your code and comments here',
      '```',
    }),
  },
  { name = 'ChatGPT3-5' },
  { name = 'CodeGPT3-5' },
}

local hooks = {
  Atomic = function(gp, params)
    local prompt = generate_prompt({
      'I have the following code from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Each note should encompass a single cohesive topic; split the text into distinct, self-contained notes if it spans multiple diverse subjects.',
      'Preserve any YAML data within the notes exactly as it is, ensuring no changes are made to this formatting or content.',
      'Focus on enhancements to grammar and spelling to ensure the notes are well-written and easily comprehensible.',
      'Format and structure each note for optimal clarity, using bullet points, numbered lists, or headings where appropriate.',
      'Please remember that these notes are tailored for personal use and should be optimally organized for quick reference.',
    })

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Bugs = function(gp, params)
    local prompt = generate_prompt({
      'I have encountered an issue in the code from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Could you help me by identifying and fixing any bugs in the above code?.',
    })

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Compress = function(gp, params)
    local prompt = generate_prompt({
      'I have the following text from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Could you assist by condensing the text above to its most succinct form?.',
    })

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Diff = function(gp, params)
    local prompt = generate_prompt({
      'I have the following git diff from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Please provide a PR description for the changes.',
      'Keep the wording concise and clear.',
      'The description should always start with a `### Overview` section, followed by a `### Key changes` section. Changes should preferably be grouped together.',
    })

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Documentation = function(gp, params)
    local current_filetype = vim.bo.filetype
    local prompt = generate_prompt(
      {
        'I have the following code from {{filename}}:',
        '',
        '```{{filetype}}',
        '{{selection}}',
        '```',
        '',
        'Please provide a documentation for the code block above.',
        '%s',
        'Keep the wording concise and clear.',
        'Respond with only the comment snippet, omitting the original code block from your answer.',
      },
      (
        vim.tbl_contains(javascript_filetypes, current_filetype)
        and 'Ensure that you follow the JSDoc standard for all documentation.'
      )
        or (current_filetype == 'lua' and 'Ensure that you use follow the Lua Language Server (`luals`) annotations standard. All docstring comments MUST begin with `---`.')
        or ''
    )

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Emojify = function(gp, params)
    local current_filetype = vim.bo.filetype
    local prompt = generate_prompt(
      {
        'I have the following text from {{filename}}:',
        '',
        '```{{filetype}}',
        '{{selection}}',
        '```',
        '',
        '%s',
      },
      current_filetype == 'markdown'
          and 'Please help me by prefixing each header with an emoji.'
        or 'Please help me by giving me one more more emoji suggestions.'
    )

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Explain = function(gp, params)
    local prompt = generate_prompt({
      'I need an explanation for the code from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Please provide a detailed explanation of the code block shown above.',
    })

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Tests = function(gp, params)
    local current_filetype = vim.bo.filetype
    local prompt = generate_prompt(
      {
        'Please write unit tests for the code from {{filename}}:',
        '',
        '```{{filetype}}',
        '{{selection}}',
        '```',
        '',
        '%s',
        'Ensure your response exclusively consists of the unit tests corresponding to the presented code snippet.',
      },

      (
        vim.tbl_contains(javascript_filetypes, current_filetype)
        and 'Please use `vitest` as the test runner and `@testing-library` for any DOM-related tests.'
      ) or ''
    )

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Optimize = function(gp, params)
    local prompt = generate_prompt({
      'The code from {{filename}} requires optimization:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Please examine the code for any code smells and suggest improvements.',
      'Your response should focus on optimizing the provided code snippet.',
    })

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Readability = function(gp, params)
    local prompt = generate_prompt({
      'Give me a more readable version of the text from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Please enhance the clarity and readability of the code snippet above in your response.',
    })

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Reword = function(gp, params)
    local prompt = generate_prompt({
      'I need to express the text from {{filename}} differently:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Please reword the text, ensuring that the meaning is preserved.',
    })

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Spelling = function(gp, params)
    local prompt = generate_prompt({
      'Correct the grammar and spelling in the following text from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Please respond with the revised text only.',
    })

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.enew,
      nil,
      agent.model,
      prompt,
      agent.system_prompt
    )
  end,
  Summarize = function(gp, params)
    local prompt = generate_prompt({
      'Summarize the text from {{filename}}:',
      '',
      '```{{filetype}}',
      '{{selection}}',
      '```',
      '',
      'Please focus your response on a concise summary of the provided text.',
    })

    local agent = gp.get_chat_agent()

    gp.Prompt(
      params,
      gp.Target.enew('markdown'),
      nil,
      agent.model,
      prompt,
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
