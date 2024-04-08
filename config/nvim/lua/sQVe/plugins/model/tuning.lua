-- ╺┳╸╻ ╻┏┓╻╻┏┓╻┏━╸
--  ┃ ┃ ┃┃┗┫┃┃┗┫┃╺┓
--  ╹ ┗━┛╹ ╹╹╹ ╹┗━┛

local model = 'gpt-4-1106-preview'

return {
  code_explanation = { model = model, temperature = 0.3, top_p = 0.5 },
  code_generation = { model = model, temperature = 0.1, top_p = 0.2 },
  comment_generation = { model = model, temperature = 0.3, top_p = 0.3 },
  conversation = { model = model, temperature = 0.6 },
  creative_writing = { model = model, temperature = 0.7 },
  technical_writing = { model = model, temperature = 0.4 },
  test_generation = { model = model, temperature = 0.4, top_p = 0.5 },
  text_processing = { model = model, temperature = 0.2, top_p = 0.4 },
}
