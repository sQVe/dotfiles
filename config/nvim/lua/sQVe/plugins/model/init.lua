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
  local openai = require('model.providers.openai')

  local chats = require('sQVe.plugins.model.chats')
  local prompts = require('sQVe.plugins.model.prompts')

  return {
    chats = {
      general = chats.get_general_chat(),
    },
    prompts = {
      -- accessibility = prompts.accessibility(),
      -- bdd_test = prompts.bdd_test(),
      -- custom = prompts.custom(),
      -- improve = prompts.improve(),
      -- note = prompts.note(),
      -- readability = prompts.readability(),
      -- repair = prompts.repair(),
      -- unit_test = prompts.unit_test(),
      commit_message = prompts.commit_message(),
      condense = prompts.condense(),
      docstring = prompts.docstring(),
      explain = prompts.explain(),
      proofread = prompts.proofread(),
      pull_request = prompts.pull_request(),
      rephrase = prompts.rephrase(),
      summary = prompts.summary(),
    },
  }
end

return M
