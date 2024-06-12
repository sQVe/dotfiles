-- ┏┳┓┏━┓╺┳┓┏━╸╻
-- ┃┃┃┃ ┃ ┃┃┣╸ ┃
-- ╹ ╹┗━┛╺┻┛┗━╸┗━╸
-- Interact with LLMs.

local chats = require('sQVe.plugins.model.chats')
local prompts = require('sQVe.plugins.model.prompts')

local M = {
  'gsuuon/model.nvim',
  cmd = { 'M', 'Model', 'Mchat' },
  ft = 'mchat',
}

M.opts = function()
  return {
    chats = {
      general = chats.get_general_chat(),
    },
    prompts = {
      commit_message = prompts.commit_message(),
      condense = prompts.condense(),
      docstring = prompts.docstring(),
      explain = prompts.explain(),
      improve = prompts.improve(),
      instruction = prompts.instruction(),
      note = prompts.note(),
      proofread = prompts.proofread(),
      pull_request = prompts.pull_request(),
      readability = prompts.readability(),
      rephrase = prompts.rephrase(),
      summary = prompts.summary(),
      unit_test = prompts.unit_test(),
    },
  }
end

return {}
