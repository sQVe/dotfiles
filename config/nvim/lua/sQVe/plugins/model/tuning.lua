-- ╺┳╸╻ ╻┏┓╻╻┏┓╻┏━╸
--  ┃ ┃ ┃┃┗┫┃┃┗┫┃╺┓
--  ╹ ┗━┛╹ ╹╹╹ ╹┗━┛

-- 0.01 = error-free code generation and calculations
-- 0.10 = classification, extraction, text processing
-- 0.20 = error free API function, if AI would invoke external tool to answer
-- 0.30 = factual question answering
-- 0.40 = factual documentation, technical writing
-- 0.50 = philosophical hypothetical question answering
-- 0.60 = friendly chat with AI
-- 0.70 = articles, essays
-- 0.80 = fiction writing
-- 1.00 = poetry, unexpected words
-- 1.20 = random results and unpredicable chosen text desired
-- 2.00 = nonsense incoherent output desired

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
  translation = { model = model, temperature = 0.3, top_p = 0.3 },
}
