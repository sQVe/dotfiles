-- ╻ ╻╻
-- ┃ ┃┃
-- ┗━┛╹

local M = {}

M.run_model = function(prompt, instruction)
  instruction = instruction or ''

  if vim.fn.visualmode() == 'V' then
    vim.api.nvim_command("'<,'>M " .. prompt .. ' ' .. instruction)
  else
    vim.api.nvim_command('M ' .. prompt .. ' ' .. instruction)
  end
end

M.run_prompt = function()
  local prompts = require('sQVe.plugins.model').opts().prompts

  vim.ui.select(vim.tbl_keys(prompts), {
    prompt = 'Run prompt',
    format_item = function(item)
      return item:gsub('_', ' ')
    end,
  }, function(choice)
    if choice == nil then
      return
    end

    local custom_instruction_prompts = {
      'buffer_instruction',
      'append_instruction',
      'replace_instruction',
    }

    if vim.tbl_contains(custom_instruction_prompts, choice) then
      local mode = choice:match('^(.-)_')

      vim.ui.input(
        { prompt = string.format('🤖 Instruction for %s', mode) },
        function(instruction)
          if #instruction > 0 then
            M.run_model(choice, instruction)
          else
            vim.notify('No instruction provided.', vim.log.levels.WARN)
          end
        end
      )
    else
      M.run_model(choice)
    end
  end)
end

return M
