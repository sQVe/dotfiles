-- ┏━┓┏━╸╺┳╸╻┏━┓┏┓╻┏━┓
-- ┣━┫┃   ┃ ┃┃ ┃┃┗┫┗━┓
-- ╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹┗━┛

local format_lines = require('sQVe.utils.format_lines')
local buffer = require('sQVe.utils.buffer')
local path = require('sQVe.utils.path')

local M = {}

M.chat = function()
  return {
    name = 'Chat',
    strategy = 'chat',
    prompts = {
      n = function()
        return require('codecompanion').chat()
      end,
      v = {
        {
          role = 'user',
          content = function(context)
            local text = require('codecompanion.helpers.actions').get_code(
              context.start_line,
              context.end_line
            )

            return format_lines(
              {
                'I have the following text in `%s`:',
                '```%s',
                '%s',
                '```',
              },
              path.get_basename(buffer.get_path(context.bufnr)),
              context.filetype,
              text
            )
          end,
        },
      },
    },
  }
end

M.condense_text = function()
  return {
    condition = function(context)
      return context.is_visual
    end,
    name = 'Condense text',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Condense the text.',
          'Strive for simple, clear language, avoiding complexity or ambiguity.',
          'Start your response with the condensed text in a code block.',
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

          return format_lines(
            {
              'I have the following text in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.debug_code_diagnostics = function()
  return {
    condition = function(context)
      if not context.is_visual then
        return false
      end

      local diagnostics = vim.diagnostic.get(context.bufnr)
      return #diagnostics > 0
    end,
    name = 'Debug code diagnostics',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Debug the code diagnostics.',
          'Explain the diagnostics in a structured way and provide code snippets to help fix the issues when possible.',
        }),
      },
      {
        role = 'user',
        content = function(context)
          local diagnostics =
            require('codecompanion.helpers.lsp').get_diagnostics(
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
          local text = require('codecompanion.helpers.actions').get_code(
            context.start_line,
            context.end_line,
            { show_line_numbers = true }
          )

          return format_lines(
            {
              'I have the following code in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.enhance_text_readability = function()
  return {
    condition = function(context)
      return context.is_visual
    end,
    name = 'Enhance text readability',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Enhance the readability of the text.',
          'Your response should contain the enhanced text, together with a structured explanation of the changes made.',
        }),
      },
      {
        role = 'user',
        content = function(context)
          local text = require('codecompanion.helpers.actions').get_code(
            context.start_line,
            context.end_line
          )

          return format_lines(
            {
              'I have the following text in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.explain_code = function()
  return {
    condition = function(context)
      return context.is_visual
    end,
    name = 'Explain code',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Explain the code.',
          'Thoroughly explain the code I am looking at.',
          'The explanation should be clear, concise, and easy to understand.',
        }),
      },
      {
        role = 'user',
        content = function(context)
          local text = require('codecompanion.helpers.actions').get_code(
            context.start_line,
            context.end_line
          )

          return format_lines(
            {
              'I have the following code in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.generate_docstring = function()
  return {
    condition = function(context)
      return context.is_visual
    end,
    name = 'Generate docstring',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Generate a docstring.',
          'Only provide the docstring, without any other text.',
        }),
      },
      {
        role = 'user',
        content = function(context)
          local text = require('codecompanion.helpers.actions').get_code(
            context.start_line,
            context.end_line
          )

          return format_lines(
            {
              'I have the following code in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.generate_pull_request_description = function()
  return {
    condition = function(context)
      if context.filetype ~= 'markdown' then
        return false
      end

      local git_diff =
        vim.fn.system({ 'git', 'diff', 'main' .. '..' .. 'HEAD' })

      return git_diff:match('^diff')
    end,
    name = 'Generate pull request description',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Generate a very concise and structured pull request description based on the provided diffs. It must be easy to parse for reviewers.',
          'The description should always include:',
          '- A summary of the changes under a ### Overview heading.',
          '- A bulleted list of the main changes under a ### Key Changes heading.',
          'Avoid redundant information.',
        }),
      },
      {
        role = 'user',
        content = function()
          local git_diff =
            vim.fn.system({ 'git', 'diff', 'main' .. '..' .. 'HEAD' })

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
end

M.generate_unit_tests = function()
  local vitest_filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  }

  return {
    condition = function(context)
      return context.is_visual
        and vim.tbl_contains(vitest_filetypes, context.filetype)
    end,
    name = 'Generate unit test',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Generate a unit tests.',
          'Your response should contain the unit tests, testing each possible state of the unit.',
          'Use `vitest` as the test runner and `@testing-library` for any DOM-related tests.',
        }),
      },
      {
        role = 'user',
        content = function(context)
          local text = require('codecompanion.helpers.actions').get_code(
            context.start_line,
            context.end_line
          )

          return format_lines(
            {
              'I have the following code in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.improve_code = function()
  return {
    condition = function(context)
      return context.is_visual
    end,
    name = 'Improve code',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Improve the code.',
          'Your response should contain the improved code, together with a structured explanation of the changes made.',
        }),
      },
      {
        role = 'user',
        content = function(context)
          local text = require('codecompanion.helpers.actions').get_code(
            context.start_line,
            context.end_line
          )

          return format_lines(
            {
              'I have the following code in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.proofread_text = function()
  return {
    condition = function(context)
      return context.is_visual
    end,
    name = 'Proofread text',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Proofread the text.',
          'Strive for simple, clear language, avoiding complexity or ambiguity. Do not focus on any code syntax issues.',
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

          return format_lines(
            {
              'I have the following text in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.rephrase_text = function()
  return {
    condition = function(context)
      return context.is_visual
    end,
    name = 'Rephrase text',
    opts = { auto_submit = true },
    strategy = 'chat',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Rephrase the text.',
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

          return format_lines(
            {
              'I have the following text in `%s`:',
              '```%s',
              '%s',
              '```',
            },
            path.get_basename(buffer.get_path(context.bufnr)),
            context.filetype,
            text
          )
        end,
      },
    },
  }
end

M.write_commit_message = function()
  return {
    condition = function(context)
      return context.filetype == 'gitcommit' and context.is_normal
    end,
    name = 'Write a commit message',
    strategy = 'inline',
    prompts = {
      {
        role = 'system',
        content = format_lines({
          'Generate a commit message.',
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
end

return M
