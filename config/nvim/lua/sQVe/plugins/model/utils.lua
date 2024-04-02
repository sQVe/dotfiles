-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

M.format_text = function(prompt_lines, ...)
  local arguments = { ... }

  local format_prompts = function(prompt, args)
    return prompt:format(table.unpack(args))
  end

  -- Ensure that all empty arguments are replaced with '%s', since that allows
  -- us to sanitize them.
  for idx, argument in ipairs(arguments) do
    if argument == '' then
      arguments[idx] = '%s'
    end
  end

  local prompt = table.concat(prompt_lines, '\n')
  local ok, formatted_prompt = pcall(format_prompts, prompt, arguments)

  -- Remove any left over '%s', including the newline, from the prompt.
  local sanitized_prompt = (ok and formatted_prompt or prompt):gsub('%%s\n', '')

  return sanitized_prompt
end

M.get_multi_mode = function()
  local mode = require('model').mode

  return vim.fn.visualmode() == 'V' and mode.REPLACE or mode.BUFFER
end

return M
