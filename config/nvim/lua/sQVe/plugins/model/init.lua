-- ┏┳┓┏━┓╺┳┓┏━╸╻
-- ┃┃┃┃ ┃ ┃┃┣╸ ┃
-- ╹ ╹┗━┛╺┻┛┗━╸┗━╸
-- Interact with LLMs.

local M = {
  'gsuuon/model.nvim',
  cmd = { 'M', 'Model', 'Mchat' },
  ft = 'mchat',
}

M.init = function()
  vim.filetype.add({
    extension = {
      mchat = 'mchat',
    },
  })
end

M.opts = function()
  local openai = require('model.providers.openai')
  -- local model = require('model')

  -- local mode = model.mode

  return {
    chats = {
      openai = {
        provider = openai,
        system = 'You are a helpful assistant. Your name is Groonk.',
        params = { model = 'gpt-4-1106-preview' },
        create = function(input, ctx)
          return ctx.selection and input or ''
        end,
        run = function(messages, config)
          if config.system then
            table.insert(messages, 1, {
              role = 'system',
              content = config.system,
            })
          end

          return { messages = messages }
        end,
      },
    },
  }
end

return M
