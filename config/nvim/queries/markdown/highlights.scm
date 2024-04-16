;; Conceal backticks.
(fenced_code_block
  (fenced_code_block_delimiter) @conceal
  (#set! conceal ""))
(fenced_code_block
  (info_string (language) @conceal
  (#set! conceal "")))

; Conceal bullet points.
([
  (list_marker_minus)
  (list_marker_plus)
  (list_marker_star)
 ] @punctuation.special
  (#offset! @punctuation.special 0 0 0 -2)
  (#set! conceal "󰧞"))

([
  (list_marker_minus)
  (list_marker_plus)
  (list_marker_star)
 ] @punctuation.special
  (#any-of? @punctuation.special "+" "*" "-")
  (#set! conceal "󰧞"))

; Conceal unchecked task list items.
((task_list_marker_unchecked) @text.todo.unchecked
  (#offset! @text.todo.unchecked 0 0 0 0)
  (#set! conceal "󰄱"))

; Conceal checked task list items.
((task_list_marker_checked) @text.todo.checked
  (#offset! @text.todo.checked 0 0 0 0)
  (#set! conceal "󰄲"))

; Set a highlight for the text of checked task list items.
(list_item
 (task_list_marker_checked)
 (_) @text.todo.checked.text)

; Set a highlight for the text of unchecked task list items.
(list_item
 (task_list_marker_unchecked)
 (_) @text.todo.unchecked.text)

; Enable spelling.
(inline) @spell
