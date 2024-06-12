-- ╻ ╻╻
-- ┃ ┃┃
-- ┗━┛╹

local selection = require('sQVe.utils.selection')

local M = {}

M.run_model = function(prompt, instruction)
  instruction = instruction or ''

  if selection.is_visual_mode() then
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

    if choice == 'instruction' then
      vim.ui.input(
        { prompt = '🤖 Instruction' },
        vim.schedule_wrap(function(instruction)
          if #instruction > 0 then
            M.run_model(choice, instruction)
          else
            vim.notify('No instruction provided.', vim.log.levels.WARN)
          end
        end)
      )
    else
      M.run_model(choice)
    end
  end)
end

return M
