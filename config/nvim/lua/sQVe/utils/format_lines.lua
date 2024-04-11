-- ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸   ╻  ╻┏┓╻┏━╸┏━┓
-- ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃    ┃  ┃┃┗┫┣╸ ┗━┓
-- ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹    ┗━╸╹╹ ╹┗━╸┗━┛

return function(prompt_lines, ...)
  local arguments = { ... }

  -- Ensure that all empty arguments are replaced with '%s', since that allows
  -- us to sanitize them.
  for idx, argument in ipairs(arguments) do
    if argument == '' then
      arguments[idx] = '%s'
    end
  end

  local prompt = table.concat(prompt_lines, '\n')

  if #arguments > 0 then
    prompt = prompt:format(unpack(arguments))
  end

  -- Remove any left over '%s', including the newline, from the prompt.
  return prompt:gsub('%%s\n', '')
end
