-- ┏━╸╻ ╻┏━┓╺┳╸┏━┓
-- ┃  ┣━┫┣━┫ ┃ ┗━┓
-- ┗━╸╹ ╹╹ ╹ ╹ ┗━┛

local format_lines = require('sQVe.utils.format_lines')
local tuning = require('sQVe.plugins.model.tuning')

local create = function(input, ctx)
  return ctx.selection and input or ''
end

local run = function(messages, config)
  table.insert(messages, 1, {
    role = 'system',
    content = format_lines({
      "You're a versatile assistant.",
      '',
      'Follow these guidelines when writing responses:',
      '- Ask for clarification if unsure.',
      '- Ensure accurate and reliable information.',
      '- Use examples if needed.',
      '- Use simple and clear language.',
    }),
  })

  if config.system then
    table.insert(messages, 2, { role = 'system', content = config.system })
  end

  return { messages = messages }
end

local M = {}

M.get_general_chat = function()
  local openai = require('model.providers.openai')

  return {
    provider = openai,
    params = tuning.conversation,
    create = create,
    run = run,
  }
end

return M
