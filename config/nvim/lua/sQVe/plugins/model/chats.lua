-- ┏━╸╻ ╻┏━┓╺┳╸┏━┓
-- ┃  ┣━┫┣━┫ ┃ ┗━┓
-- ┗━╸╹ ╹╹ ╹ ╹ ┗━┛

local M = {}

local create = function(input, ctx)
  return ctx.selection and input or ''
end

local run = function(messages, config)
  local utils = require('sQVe.plugins.model.utils')

  table.insert(messages, 1, {
    role = 'system',
    content = utils.format_text({
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

M.get_general_chat = function()
  local openai = require('model.providers.openai')

  local tuning = require('sQVe.plugins.model.tuning')

  return {
    provider = openai,
    params = tuning.conversation,
    create = create,
    run = run,
  }
end

return M
