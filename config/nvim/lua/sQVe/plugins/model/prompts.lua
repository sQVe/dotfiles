-- ┏━┓┏━┓┏━┓┏┳┓┏━┓╺┳╸┏━┓
-- ┣━┛┣┳┛┃ ┃┃┃┃┣━┛ ┃ ┗━┓
-- ╹  ╹┗╸┗━┛╹ ╹╹   ╹ ┗━┛

local M = {}

local guidelines = {
  language = 'Use straightforward and easy-to-understand language.',
}

M.accessibility = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.technical_writing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a accessibility assistant.",
              'Your response should contain the improved code, together with an structured explanation of the changes made.',
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
              'Please make it more accessible.',
            }, context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
  }
end

M.append_instruction = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.APPEND,
    params = tuning.technical_writing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a versatile code assistant.",
              'Your response should only contain the response, without needing any further editing.',
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
              '%s',
            }, context.filename, vim.bo.filetype, input, context.args),
          },
        },
      }
    end,
  }
end

M.buffer_instruction = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.technical_writing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a versatile code assistant.",
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
              '%s',
            }, context.filename, vim.bo.filetype, input, context.args),
          },
        },
      }
    end,
  }
end

M.commit_message = function()
  local mode = require('model').mode
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.REPLACE,
    params = tuning.comment_generation,
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
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

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
    mode = utils.get_multi_mode(),
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

M.docstring = function()
  local mode = require('model').mode
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

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
    params = tuning.comment_generation,
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

M.explain = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.code_explanation,
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

M.improve = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.code_generation,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're an assistant specialized in suggesting improvements to code.",
              'Your response should contain the improved code, together with an structured explanation of the changes made.',
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
              'Please suggest improvements and optimizations.',
            }, context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
  }
end

M.note = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.creative_writing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're an assistant specialized note-taking.",
              'Your response should contain the improved notes, together with an structured explanation of the changes made.',
              'Keep YAML data intact with its formatting and content.',
              'Improve grammar and spelling for clear, comprehensible notes.',
              'Use lists, bullet points, or headings to clarify note structure where appropriate.',
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
              'Please suggest improvements to my note.',
            }, context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
  }
end

M.proofread = function()
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

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
    mode = utils.get_multi_mode(),
    params = tuning.creative_writing,
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
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.INSERT,
    params = tuning.code_explanation,
    builder = function(_, context)
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

M.readability = function()
  local mode = require('model').mode
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.technical_writing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a readability assistant.",
              'Your response should contain the improved text, together with an structured explanation of the changes made.',
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
              'Please rewrite it to make it more readable.',
            }, context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

-- TODO: Implement prompt.
M.repair = function() end

M.rephrase = function()
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

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
    mode = utils.get_multi_mode(),
    params = tuning.technical_writing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a rephrasing assistant.",
              'Your response should only contain the rephrased text, replacing the input directly without needing any further editing.',
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

M.replace_instruction = function()
  local mode = require('model').mode
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.REPLACE,
    params = tuning.technical_writing,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text({
              "You're a versatile code assistant.",
              'Your response should only contain the response, without needing any further editing.',
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
              '%s',
            }, context.filename, vim.bo.filetype, input, context.args),
          },
        },
      }
    end,
  }
end

M.summary = function()
  local mode = require('model').mode
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.text_processing,
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

M.unit_test = function()
  local mode = require('model').mode
  local extract = require('model.prompts.extract')
  local openai = require('model.providers.openai')

  local utils = require('sQVe.plugins.model.utils')
  local tuning = require('sQVe.plugins.model.tuning')

  local vitest_filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  }

  return {
    provider = openai,
    mode = mode.BUFFER,
    params = tuning.test_generation,
    builder = function(input, context)
      return {
        messages = {
          {
            role = 'system',
            content = utils.format_text(
              {
                "You're an assistant specialized in writing unit tests.",
                'Your response should contain the unit tests, testing each possible state of the unit.',
                '%s',
                guidelines.language,
              },
              (
                vim.tbl_contains(vitest_filetypes, vim.bo.filetype)
                and 'Use `vitest` as the test runner and `@testing-library` for any DOM-related tests.'
              ) or ''
            ),
          },
          {
            role = 'user',
            content = utils.format_text({
              'I have the following text from %s:',
              '```%s',
              '%s',
              '```',
              'Please write unit tests for it.',
            }, context.filename, vim.bo.filetype, input),
          },
        },
      }
    end,
    transform = extract.markdown_code,
  }
end

return M
