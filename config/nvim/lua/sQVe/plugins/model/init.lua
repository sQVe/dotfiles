-- ┏┳┓┏━┓╺┳┓┏━╸╻
-- ┃┃┃┃ ┃ ┃┃┣╸ ┃
-- ╹ ╹┗━┛╺┻┛┗━╸┗━╸
-- Interact with LLMs.

local M = {
  'gsuuon/model.nvim',
  cmd = { 'M', 'Model', 'Mchat' },
  ft = 'mchat',
}

M.opts = function()
  local mode = require('model').mode

  local chats = require('sQVe.plugins.model.chats')
  local prompts = require('sQVe.plugins.model.prompts')

  return {
    chats = {
      general = chats.get_general_chat(),
    },
    prompts = {
      append_instruction = prompts.append_instruction(),
      buffer_instruction = prompts.buffer_instruction(),
      commit_message = prompts.commit_message(),
      condense = prompts.condense(),
      docstring = prompts.docstring(),
      explain = prompts.explain(),
      improve = prompts.improve(),
      note = prompts.note(),
      proofread = prompts.proofread(),
      pull_request = prompts.pull_request(),
      readability = prompts.readability(),
      repair = prompts.repair(),
      rephrase = prompts.rephrase(),
      replace_instruction = prompts.replace_instruction(),
      summary = prompts.summary(),
      unit_test = prompts.unit_test(),
    },
  }
end

return M
