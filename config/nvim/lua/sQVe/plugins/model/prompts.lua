-- ┏━┓┏━┓┏━┓┏┳┓┏━┓╺┳╸┏━┓
-- ┣━┛┣┳┛┃ ┃┃┃┃┣━┛ ┃ ┗━┓
-- ╹  ╹┗╸┗━┛╹ ╹╹   ╹ ┗━┛

local M = {}

local guidelines = {
  language = 'Use straightforward and easy-to-understand language.',
}

-- 0.01 = error-free code generation and calculations
-- 0.1 = classification, extraction, text processing
-- 0.2 = error free API function, if AI would invoke external tool to answer
-- 0.3 = factual question answering
-- 0.4 = factual documentation, technical writing
-- 0.5 = philosophical hypothetical question answering
-- 0.6 = friendly chat with AI
-- 0.7 = articles, essays
-- 0.8 = fiction writing
-- 1.0 = poetry, unexpected words
-- 1.2 = random results and unpredicable chosen text desired
-- 2.0 = nonsense incoherent output desired

local model = 'gpt-4-1106-preview'

local tuning = {
  automation = { model = model, temperature = 0.5, top_p = 0.6 },
  base = { model = model, temperature = 0.7 },
  code_generation = { model = model, temperature = 0.1, top_p = 0.2 },
  code_explanation = { model = model, temperature = 0.3, top_p = 0.5 },
  comment_generation = { model = model, temperature = 0.3, top_p = 0.3 },
  conversation = { model = model, temperature = 0.6, top_p = 0.9 },
  creative_writing = { model = model, temperature = 0.6, top_p = 0.4 },
  technical_writing = { model = model, temperature = 0.4, top_p = 0.4 },
  test = { model = model, temperature = 0.4, top_p = 0.5 },
  text_processing = { model = model, temperature = 0.2, top_p = 0.4 },
  translation = { model = model, temperature = 0.3, top_p = 0.3 },
}

-- Input with vim.ui.input().
-- builder = function(input, context)
--   return function(build)
--     vim.ui.input({ prompt = 'Instruction: ' }, function(user_input)
--       build({
--         messages = {
--           { role = 'user', content = user_input },
--         },
--       })
--     end)
--   end
-- end,

M.commit_message = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  return {
    provider = openai,
    mode = mode.REPLACE,
    params = tuning.code_comment_generation,
    builder = function()
      local git_diff = vim.fn.system({ 'git', 'diff', '--staged' })

      if not git_diff:match('^diff') then
        error('No diff found in the staging area.')
      end

      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're an advisor for writing optimal git commit messages based on diffs.",
              'Your response should only contain the git commit message, without needing any further editing.',
              'Try to stay below 80 characters total.',
            }),
          },
          {
            role = 'user',
            content = utils.format_text({
              'I have made the following changes:',
              '```%s',
              '%s',
              '```',
              'Please write a commit message following the conventional commits specification.',
            }, vim.bo.filetype, git_diff),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

M.condense = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  local get_content = function(filename, filetype, input)
    return utils.format_text({
      'I have the following text from %s:',
      '```%s',
      '%s',
      '```',
      'Please condense it to its most succinct form.',
    }, filename, filetype, input)
  end

  return {
    provider = openai,
    mode = mode.REPLACE,
    params = tuning.text_processing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're an assistant specialized in condensing text.",
              'Your response should only contain the condensed text, replacing the input directly without needing any further editing. If the input text is already as concise as possible, return it as is.',
              guidelines.language,
            }),
          },
          {
            role = 'user',
            content = get_content(
              'neovim.txt',
              'txt',
              'Neovim is a modern and powerful text editor that is fully compatible with Vim and supports Lua plugins, LSP client, and remote plugins. '
            ),
          },
          {
            role = 'assistant',
            content = 'Neovim is a modern text editor with full Vim compatibility, Lua plugin support, LSP client, and remote plugins',
          },
          {
            role = 'user',
            content = get_content(context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

M.explain = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = { model = 'gpt-4-1106-preview' },
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're an assistant specialized in explaining code.",
              'Use examples to illustrate your explaining, if necessary.',
              guidelines.language,
            }),
          },
          {
            role = 'user',
            content = utils.format_text({
              'I have the following code from %s:',
              '```%s',
              '%s',
              '```',
              'Please provide a brief explanation of what it does.',
            }, context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
  }
end

M.docstring = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  local get_content = function(filename, filetype, input)
    return utils.format_text({
      'I have the following code from %s:',
      '```%s',
      '%s',
      '```',
      'Please write a docstring for it.',
    }, filename, filetype, input)
  end

  return {
    provider = openai,
    mode = mode.INSERT,
    params = tuning.code_comment_generation,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a coding assistant, specialized in writing docstrings.",
              'Your response should only contain the docstring, without needing any further editing.',
              'The output should ALWAYS end with a newline character.',
              guidelines.language,
            }),
          },
          {
            role = 'user',
            content = get_content(
              'arithmetics.ts',
              'typescript',
              'const add = (a: number, b: number) => a + b;'
            ),
          },
          {
            role = 'assistant',
            content = table.concat({
              '/**',
              ' * Adds two numbers together.',
              ' *',
              ' * @param a - The first number to add.',
              ' * @param b - The second number to add.',
              ' * @returns The sum of `a` and `b`.',
              ' */',
              '',
            }, '\n'),
          },
          {
            role = 'user',
            content = get_content(context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

M.rephrase = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  local get_content = function(filename, filetype, input)
    return utils.format_text({
      'I have the following text from %s:',
      '```%s',
      '%s',
      '```',
      'Please rephrase it while ensuring that the meaning remains the same.',
    }, filename, filetype, input)
  end

  return {
    provider = openai,
    mode = mode.REPLACE,
    params = { model = 'gpt-4-1106-preview' },
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a rephrasing assistant.",
              'Your response should only contain the rephrased text, without needing any further editing.',
              guidelines.language,
            }),
          },
          {
            role = 'user',
            content = get_content(
              'neovim.txt',
              'txt',
              '"Neovim is a modern and powerful text editor that is fully compatible with Vim and supports Lua plugins, LSP client, and remote plugins.",'
            ),
          },
          {
            role = 'assistant',
            content = '"Neovim is an advanced text editor with complete Vim compatibility, offering support for Lua extensions, a language server protocol client, and external plugins.",',
          },
          {
            role = 'user',
            content = get_content(context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

M.proofread = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  local get_content = function(filename, filetype, input)
    return utils.format_text({
      'I have the following text from %s:',
      '```%s',
      '%s',
      '```',
      'Please correct any spelling or grammatical errors.',
    }, filename, filetype, input)
  end

  return {
    provider = openai,
    mode = mode.REPLACE,
    params = { model = 'gpt-4-1106-preview', temperature = 0.8 },
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a proofreader.",
              'Your response should only contain the corrected text, replacing the input directly without needing any further editing. If the input text is already correct, return it as is.',
              'Strive for simple, clear language, avoiding complexity or ambiguity.',
            }),
          },
          {
            role = 'user',
            content = get_content(
              'sentence.txt',
              'txt',
              'Their going to the libary tommorow to borow some books.'
            ),
          },
          {
            role = 'assistant',
            content = "They're going to the library tomorrow to borrow some books.",
          },
          {
            role = 'user',
            content = get_content(context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

M.pull_request = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  return {
    provider = openai,
    mode = mode.INSERT,
    params = { model = 'gpt-4-1106-preview', temperature = 0.4 },
    builder = function(input, context)
      local base_branch = (context.args ~= '' and context.args) or 'main'

      local git_diff =
        vim.fn.system({ 'git', 'diff', base_branch .. '..' .. 'HEAD' })

      if not git_diff:match('^diff') then
        error('No diff found against ' .. base_branch .. '.')
      end

      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're an advisor for writing optimal pull request descriptions based on diffs.",
              'Your response should only contain the pull request, without needing any further editing.',
              'Start the description with `### Overview`, followed by `### Key changes`. Try to group the changes into logical sections.',
            }),
          },
          {
            role = 'user',
            content = utils.format_text({
              'I have made the following changes:',
              '```%s',
              '%s',
              '```',
              'Please write a pull request description.',
            }, vim.bo.filetype, git_diff),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

M.summary = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')
  local extract = require('model.prompts.extract')

  local utils = require('sQVe.plugins.model.utils')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = { model = 'gpt-4-1106-preview' },
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're an assistant specialized in summarizing text.",
              'Your response should only contain the summary, without needing any further editing. If the input text is as concise as possible, return it as is.',
              guidelines.language,
            }),
          },
          {
            role = 'user',
            content = utils.format_text({
              'I have the following text from %s:',
              '```%s',
              '%s',
              '```',
              'Please summarize it.',
            }, context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

return M
