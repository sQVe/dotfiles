-- ┏━┓┏━┓┏━┓┏┳┓┏━┓╺┳╸┏━┓
-- ┣━┛┣┳┛┃ ┃┃┃┃┣━┛ ┃ ┗━┓
-- ╹  ╹┗╸┗━┛╹ ╹╹   ╹ ┗━┛

local format_lines = require('sQVe.utils.format_lines')
local buffer = require('sQVe.utils.buffer')
local path = require('sQVe.utils.path')

local M = {}

M.chat = {
  strategy = 'chat',
  prompts = {
    n = function()
      return require('codecompanion').chat()
    end,
    v = {
      {
        role = 'user',
        content = function(context)
          return format_lines({
            'I have the following text in `%s`:',
          }, path.get_basename(buffer.get_path(context.bufnr)))
        end,
      },
    },
  },
}

M.condense_text = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to condense the text.',
        'Strive for simple, clear language, avoiding complexity or ambiguity.',
        'Start your response with the condensed text in a code block.',
        'End your response with a concise list of the changes made.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following text in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.inline_prompt = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { user_prompt = true },
  strategy = 'inline',
  prompts = {
    {
      role = 'system',
      content = function(context)
        return format_lines({
          'Act as a expert %s developer.',
          "I will ask questions; return raw code only (no codeblocks, no explanations). If you can't, respond with nothing",
        }, context.filetype)
      end,
    },
  },
}

M.debug_code_diagnostics = {
  condition = function(context)
    if not context.is_visual then
      return false
    end

    local diagnostics = vim.diagnostic.get(context.bufnr)
    return #diagnostics > 0
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to debug the code diagnostics.',
        'Explain the diagnostics in a structured way and provide code snippets to help fix the issues when possible.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        local diagnostics =
          require('codecompanion.helpers.actions').get_diagnostics(
            context.start_line,
            context.end_line,
            context.bufnr
          )

        local concatenated_diagnostics = ''
        for index, diagnostic in ipairs(diagnostics) do
          concatenated_diagnostics = concatenated_diagnostics
            .. format_lines(
              {
                'Issue %s:',
                '- Line: %s',
                '- Message: %s',
                '- Severity: %s',
                '',
              },
              index,
              diagnostic.line_number,
              diagnostic.severity,
              diagnostic.message
            )
        end

        return format_lines({
          'List of diagnostics errors:',
          '%s',
        }, concatenated_diagnostics)
      end,
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following code in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.enhance_text_readability = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to enhance the readability of the text.',
        'Your response should contain the enhanced text, together with a structured explanation of the changes made.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following text in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.explain_code = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to explain the code.',
        'Thoroughly explain the code I am looking at.',
        'The explanation should be clear, concise, and easy to understand.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following code in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.generate_docstring = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to generate a docstring.',
        'Only provide the docstring, without any other text.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following code in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.generate_pull_request_description = {
  condition = function(context)
    local git_diff = vim.fn.system({
      'git',
      'diff',
      'main..HEAD',
      '--',
      ':!pnpm-lock.yaml',
    })

    return git_diff:match('^diff')
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to generate a very concise and structured pull request description based on the provided diffs. It must be easy to parse for reviewers.',
        'The description should always include:',
        '- A summary of the changes under a ### Overview heading.',
        '- A bulleted list of the main changes under a ### Key Changes heading.',
        'Avoid redundant information.',
      }),
    },
    {
      role = 'user',
      content = function()
        local git_diff = vim.fn.system({
          'git',
          'diff',
          'main..HEAD',
          '--',
          ':!pnpm-lock.yaml',
        })

        return format_lines({
          'I have made the following changes:',
          '```%s',
          '%s',
          '```',
        }, vim.bo.filetype, git_diff)
      end,
    },
  },
}

M.generate_unit_tests = {
  condition = function(context)
    return context.is_visual
      and vim.tbl_contains({
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      }, context.filetype)
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to generate unit tests.',
        'Your response should contain the unit tests, testing each possible state of the unit.',
        'Use `vitest` as the test runner and `@testing-library` for any DOM-related tests.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following code in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.improve_code = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to improve the code.',
        'Your response should contain the improved code, together with a structured explanation of the changes made.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following code in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.proofread_text = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to proofread the text.',
        'Strive for simple, clear language, avoiding complexity or ambiguity. Do not focus on any code syntax issues.',
        'End your response with a concise list of the changes made.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        return format_lines({
          'I have the following text in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.rephrase_text = {
  condition = function(context)
    return context.is_visual
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to rephrase the text.',
        'Strive for simple, clear language, avoiding complexity or ambiguity.',
        'Start your response with the rephrased text in a code block.',
        'End your response with a concise list of the changes made.',
      }),
    },
    {
      role = 'user',
      content = function(context)
        local text = require('codecompanion.helpers.actions').get_code(
          context.start_line,
          context.end_line
        )

        return format_lines({
          'I have the following text in `%s`:',
        }, path.get_basename(buffer.get_path(context.bufnr)))
      end,
    },
  },
}

M.write_commit_message = {
  condition = function(context)
    return context.filetype == 'gitcommit' and context.is_normal
  end,
  opts = { auto_submit = true },
  strategy = 'chat',
  prompts = {
    {
      role = 'system',
      content = format_lines({
        'Your task is to generate a commit message.',
        'Follow the conventional commits specification without a description.',
        'Keep the message under 80 characters. Output must be raw text without code blocks.',
      }),
    },
    {
      role = 'user',
      content = function()
        local git_diff = vim.fn.system({ 'git', 'diff', '--staged' })

        if not git_diff:match('^diff') then
          error('No diff found in the staging area.')
        end

        return format_lines({
          'I have made the following changes:',
          '```%s',
          '%s',
          '```',
          'Please replace the current line with the message.',
        }, vim.bo.filetype, git_diff)
      end,
    },
  },
}

return M
