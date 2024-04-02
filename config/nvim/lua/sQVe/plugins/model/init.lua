-- ┏┳┓┏━┓╺┳┓┏━╸╻
-- ┃┃┃┃ ┃ ┃┃┣╸ ┃
-- ╹ ╹┗━┛╺┻┛┗━╸┗━╸
-- Interact with LLMs.

local M = {
  'gsuuon/model.nvim',
  cmd = { 'M', 'Model', 'Mchat' },
  ft = 'mchat',
  keys = {
    -- TODO: Add keymaps.
  },
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
      -- bdd_test = prompts.bdd_test(),
      -- repair = prompts.repair(),
      accessibility = prompts.accessibility(),
      append_instruction = prompts.custom_instruction({ mode = mode.APPEND })(),
      buffer_instruction = prompts.custom_instruction({ mode = mode.BUFFER })(),
      commit_message = prompts.commit_message(),
      condense = prompts.condense(),
      docstring = prompts.docstring(),
      explain = prompts.explain(),
      improve = prompts.improve(),
      note = prompts.note(),
      proofread = prompts.proofread(),
      pull_request = prompts.pull_request(),
      readability = prompts.readability(),
      rephrase = prompts.rephrase(),
      replace_instruction = prompts.custom_instruction({ mode = mode.REPLACE })(),
      summary = prompts.summary(),
      unit_test = prompts.unit_test(),
    },
  }
end

return M
