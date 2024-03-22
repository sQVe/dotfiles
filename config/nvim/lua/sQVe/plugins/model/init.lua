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
  local chats = require('sQVe.plugins.model.chats')
  local prompts = require('sQVe.plugins.model.prompts')

  return {
    chats = {
      general = chats.get_general_chat(),
    },
    prompts = {
      -- accessibility = prompts.accessibility(),
      -- bdd_test = prompts.bdd_test(),
      -- note = prompts.note(),
      -- readability = prompts.readability(),
      -- repair = prompts.repair(),
      commit_message = prompts.commit_message(),
      condense = prompts.condense(),
      custom = prompts.custom(),
      docstring = prompts.docstring(),
      explain = prompts.explain(),
      improve = prompts.improve(),
      proofread = prompts.proofread(),
      pull_request = prompts.pull_request(),
      rephrase = prompts.rephrase(),
      summary = prompts.summary(),
      unit_test = prompts.unit_test(),
    },
  }
end

return M
