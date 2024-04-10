-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

M.format_text = function(prompt_lines, ...)
  local arguments = { ... }

  -- Ensure that all empty arguments are replaced with '%s', since that allows
  -- us to sanitize them.
  for idx, argument in ipairs(arguments) do
    if argument == '' then
      arguments[idx] = '%s'
    end
  end

  local prompt = table.concat(prompt_lines, '\n')
  local formatted_prompt = prompt:format(unpack(arguments))

  -- Remove any left over '%s', including the newline, from the prompt.
  return formatted_prompt:gsub('%%s\n', '')
end

M.get_multi_mode = function()
  local mode = require('model').mode

  return vim.fn.visualmode() == 'V' and mode.REPLACE or mode.BUFFER
end

return M
